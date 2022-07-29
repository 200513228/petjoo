import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/enums/report_types.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/domain/repositories/transport_repository.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import 'package:petjoo/presentation/chat/view/chat_message_list_view.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/constants/map_argument.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/models/chat_model.dart';
import 'package:petjoo/product/models/user_model.dart';
import 'package:petjoo/product/providers/chat_provider.dart';
import 'package:petjoo/product/services/dynamic_link_service.dart';
import 'package:petjoo/product/ui/dialogs/info_dialog.dart';
import 'package:petjoo/product/ui/widgets/fullscreen_slider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TransportAdvertDetailViewModel extends PageNotifier {
  TransportAdvertDetailViewModel(super.context, this._repository, this.data, this._chatProvider);

  final TransportRepository _repository;
  final TransportAdvertModel data;
  final ChatProvider _chatProvider;
  final _userId = FirebaseAuth.instance.currentUser!.uid;
  Set<Marker> markers = {};
  late GoogleMapController mapController;

  bool get isOwner => data.id == _userId;

  void share() async => Share.share((await DynamicLinkService.instance.createTransportAdvertLink(data)).toString());
  void report() async {
    _repository.reportTransportAdvert(data.id!, _userId, ReportTypes.spam);
    showDialog(
        context: context,
        builder: (context) => InfoDialog(
              title: context.localization.advertReportTitle,
              description: context.localization.advertReportDescription,
            ));
  }

  void call() => _launch('tel:${data.dialCode}${data.phone}');

  void message() => context.push(ChatMessageListView(
      _chatProvider.chats.firstOrNullWhere((x) => x.userIds.containsAll([_userId, data.id!])) ?? ChatModel(userIds: [FirebaseAuth.instance.currentUser!.uid, data.id!])));

  void edit() => context.pushNamed(Routes.transportAdvertInput, arguments: data);
  void editShifts() => context.pushNamed(Routes.transportAdvertShiftInput, arguments: data);

  Future<void> _launch(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  showFullScreen(int index) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.black,
        isScrollControlled: true,
        builder: (_) => Padding(padding: EdgeInsets.only(top: context.mediaQuery.padding.top), child: FullscreenSlider(images: data.images, index: index)));
  }

  book() async {
    final query = await FirebaseFirestore.instance.collection("users").get();
    final docs = query.docs.map((e) => UserModel.fromJson(e));
    for (var element in docs) {
      FirebaseFirestore.instance.collection("users_info").doc(element.id).set(element.toBasicModel.toJson());
    }
  }

  void getDirections() => MapArgument.goToMap(data.geoPoint);

  Future<void> getMarkers() async {
    final Uint8List markerIcon = await MapArgument.getBytesFromAsset(Images.customMarker, 70);
    LatLng showLocation = LatLng(data.geoPoint!.latitude, data.geoPoint!.longitude);
    markers.add(Marker(
      markerId: MarkerId(showLocation.toString()),
      position: showLocation,
      icon: BitmapDescriptor.fromBytes(markerIcon),
    ));
    notifyListeners();
  }
}
