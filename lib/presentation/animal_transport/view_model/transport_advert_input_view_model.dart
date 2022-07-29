import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/lat_lng_extension.dart';
import 'package:petjoo/domain/repositories/transport_repository.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/constants/map_argument.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/services/location_service.dart';

class TransportAdvertInputViewModel extends PageNotifier {
  TransportAdvertInputViewModel(BuildContext context, this._repository) : super(context);

  final TransportRepository _repository;
  late final TransportAdvertModel data;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Marker? addressMarker;
  Completer<GoogleMapController> addressMapController = Completer();

  late final TextEditingController titleController = TextEditingController(text: data.title);
  late final TextEditingController descriptionController = TextEditingController(text: data.description);
  late final TextEditingController phoneController = TextEditingController(text: data.phone);
  late final TextEditingController addressController = TextEditingController(text: data.address);
  late final TextEditingController priceController = TextEditingController(text: data.pricePerKm.toString());
  late final ValueNotifier<String> dialCode = ValueNotifier(data.dialCode);
  late GeoPoint? addressLocation = data.geoPoint;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    phoneController.dispose();
    addressController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void save() {
    if (!formKey.currentState!.validate()) return;
    changeLoading();

    data.title = titleController.text;
    data.description = descriptionController.text;
    data.dialCode = dialCode.value;
    data.phone = phoneController.text;
    data.address = addressController.text;
    data.pricePerKm = double.tryParse(priceController.text) ?? 0;
    data.geoPoint = addressLocation;
    (data.id == null ? _repository.createTransportAdvert(data) : _repository.updateTransportAdvert(data)).then((value) {
      data.id = FirebaseAuth.instance.currentUser!.uid;
      context.pushNamed(Routes.transportAdvertImageInput, arguments: data);
      changeLoading();
    }, onError: (e) {
      changeLoading();
      context.showSnackBar(context.localization.somethingWentWrong);
    });
  }

  void changeIntl() {
    data.isIntercity = !data.isIntercity;
    notifyListeners();
  }

  void changeCage() {
    data.hasCage = !data.hasCage;
    notifyListeners();
  }

  void changeCollar() {
    data.hasCollar = !data.hasCollar;
    notifyListeners();
  }

  void changeCatch() {
    data.canCatch = !data.canCatch;
    notifyListeners();
  }

  Future<void> getMarker() async {
    addressLocation = data.geoPoint;
    if (addressLocation == null) return;
    final Uint8List markerIcon = await MapArgument.getBytesFromAsset(Images.customMarker, 50);
    addressMarker = Marker(
      markerId: MarkerId(addressLocation.toString()),
      position: LatLng(addressLocation!.latitude, addressLocation!.longitude),
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );
    notifyListeners();
  }

  Future<void> selectAddressLocation() async {
    final Uint8List markerIcon = await MapArgument.getBytesFromAsset(Images.customMarker, 50);
    if (addressLocation == null) {
      await LocationService.determineLocation(
        onPermissionDenied: context.pop,
        onPermissionDeniedForever: context.pop,
        onServiceDisabled: context.pop,
        onLocationDetermined: (pos) => addressLocation = pos.toGeoPoint(),
      );
    }
    // ignore: use_build_context_synchronously
    final tmpLocation = await context.pushNamed(Routes.transportAdvertMapInput, arguments: addressLocation);
    if (tmpLocation != null) addressLocation = tmpLocation as GeoPoint;
    LatLng showLocation = LatLng(addressLocation!.latitude, addressLocation!.longitude);
    addressMarker = Marker(
      markerId: MarkerId(showLocation.toString()),
      position: showLocation,
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );
    notifyListeners();
    final GoogleMapController controller = await addressMapController.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(addressLocation!.latitude, addressLocation!.longitude), zoom: 13)));
  }

  void onAddressMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(MapArgument.darkStyleText);
    addressMapController.complete(controller);
  }
}
