import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/lat_lng_extension.dart';
import 'package:petjoo/domain/enums/advert/animals.dart';
import 'package:petjoo/domain/enums/reservation/reservation_status.dart';
import 'package:petjoo/domain/repositories/transport_reservation_repository.dart';
import 'package:petjoo/infrastructure/model/transport_reservation_model.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import 'package:petjoo/presentation/animal_transport/view/transport_advert_confirm_view.dart';
import 'package:petjoo/presentation/common/successfully_saved/successfully_saved_view.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/constants/map_argument.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/services/location_service.dart';

class TransportAdvertBookingViewmodel extends PageNotifier {
  TransportAdvertBookingViewmodel(super.context, this._repository);

  final TransportReservationRepository _repository;
  late final TransportAdvertModel data;
  List<ReservationTab> tabList = [];
  int currentTabIndex = 0;
  Completer<GoogleMapController> beginMapController = Completer();
  Completer<GoogleMapController> endMapController = Completer();
  Marker? beginMarker;
  Marker? endMarker;

  final GlobalKey<FormState> formKey = GlobalKey();
  final PageController pageController = PageController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController destinationAddressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ValueNotifier<Animals> animalType = ValueNotifier(Animals.none);
  final ValueNotifier<String> dialCode = ValueNotifier('+90');
  DateTime selectedDate = DateTime.now();
  GeoPoint? beginLocation;
  GeoPoint? endLocation;

  @override
  void dispose() {
    pageController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    destinationAddressController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void createTabs() {
    final today = DateTime.now();
    _repository.getReservedHours(data.id!, DateTime(today.year, today.month, today.day)).then((value) {
      tabList = List.generate(7, (index) => ReservationTab(today.add(Duration(days: index)), value.where((reservation) => reservation.date.day == (today.day + index)).toList()));
      notifyListeners();
    }, onError: (e) {
      log(e.toString());
      context.showSnackBar(context.localization.somethingWentWrong);
      context.pop();
    });
  }

  void changeTab(int value) {
    currentTabIndex = value;
    notifyListeners();
  }

  selectDate(DateTime day, TimeOfDay start) {
    selectedDate = DateTime(day.year, day.month, day.day, start.hour, start.minute);
    pageController.animateToPage(1, duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  void save() async {
    if (!formKey.currentState!.validate()) return;
    if (beginLocation == null) {
      context.showSnackBar("Adres konumunu seçiniz.");
      return;
    }
    if (endLocation == null) {
      context.showSnackBar("Varış adres konumunu seçiniz.");
      return;
    }
    bool? rs = await showDialog(
        context: context, builder: (context) => TransportAdvertConfirmView(beginLocation!, endLocation!, data.pricePerKm, (MediaQuery.of(context).size.width * 0.169082126)));
    if (!(rs ?? false)) return;

    changeLoading();
    final reservation = TransportReservationModel(
        id: null,
        userId: FirebaseAuth.instance.currentUser!.uid,
        advertId: data.id!,
        fullName: fullNameController.text,
        title: data.title,
        description: descriptionController.text,
        dialCode: dialCode.value,
        phone: phoneController.text,
        address: addressController.text,
        destinationAddress: destinationAddressController.text,
        date: selectedDate,
        animalType: animalType.value,
        beginGeoPoint: beginLocation,
        endGeoPoint: endLocation,
        status: ReservationStatus.waiting,
        distance: MapArgument.calculateDistance(beginLocation!, endLocation!),
        resPricePerKm: data.pricePerKm);

    _repository.createReservation(reservation).then((value) {
      context.pushReplacement(SuccessfullySaved(onTap: (context) => context.pop()));
    }, onError: (e) {
      changeLoading();
      context.showSnackBar(context.localization.somethingWentWrong);
    });
  }

  Future<void> selectBeginLocation() async {
    final Uint8List markerIcon = await MapArgument.getBytesFromAsset(Images.customMarker, 50);
    if (beginLocation == null) {
      await LocationService.determineLocation(
        onPermissionDenied: context.pop,
        onPermissionDeniedForever: context.pop,
        onServiceDisabled: context.pop,
        onLocationDetermined: (pos) => beginLocation = pos.toGeoPoint(),
      );
    }
    // ignore: use_build_context_synchronously
    final tmpLocation = await context.pushNamed(Routes.transportAdvertMapInput, arguments: beginLocation);
    if (tmpLocation != null) beginLocation = tmpLocation as GeoPoint;
    LatLng showLocation = LatLng(beginLocation!.latitude, beginLocation!.longitude);
    beginMarker = Marker(
      markerId: MarkerId(showLocation.toString()),
      position: showLocation,
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );
    notifyListeners();
    final GoogleMapController controller = await beginMapController.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(beginLocation!.latitude, beginLocation!.longitude), zoom: 13)));
  }

  Future<void> selectEndLocation() async {
    final Uint8List markerIcon = await MapArgument.getBytesFromAsset(Images.customMarker, 50);
    if (endLocation == null) {
      await LocationService.determineLocation(
        onPermissionDenied: context.pop,
        onPermissionDeniedForever: context.pop,
        onServiceDisabled: context.pop,
        onLocationDetermined: (pos) => endLocation = pos.toGeoPoint(),
      );
    }
    // ignore: use_build_context_synchronously
    final tmpLocation = await context.pushNamed(Routes.transportAdvertMapInput, arguments: endLocation);
    if (tmpLocation != null) endLocation = tmpLocation as GeoPoint;
    LatLng showLocation = LatLng(endLocation!.latitude, endLocation!.longitude);
    endMarker = Marker(
      markerId: MarkerId(showLocation.toString()),
      position: showLocation,
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );
    notifyListeners();
    final GoogleMapController controller = await endMapController.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(endLocation!.latitude, endLocation!.longitude), zoom: 13)));
  }

  void onEndMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(MapArgument.darkStyleText);
    endMapController.complete(controller);
  }

  void onBeginMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(MapArgument.darkStyleText);
    beginMapController.complete(controller);
  }
}

class ReservationTab {
  ReservationTab(this.day, this.reservations);

  final DateTime day;
  final List<TransportReservationModel> reservations;
}
