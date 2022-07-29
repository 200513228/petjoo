import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/domain/repositories/transport_repository.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import 'package:petjoo/infrastructure/model/transport_reservation_model.dart';
import 'package:petjoo/presentation/chat/view/chat_message_list_view.dart';
import 'package:petjoo/product/constants/map_argument.dart';
import 'package:petjoo/product/models/chat_model.dart';
import 'package:petjoo/product/providers/chat_provider.dart';
import 'package:petjoo/product/ui/widgets/fullscreen_slider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TransportReservationDetailViewModel extends PageNotifier {
  TransportReservationDetailViewModel(super.context, this._repository, this.chatProvider, this.data) {
    _getAdvertData();
  }

  final TransportRepository _repository;
  final TransportReservationModel data;
  final ChatProvider chatProvider;
  TransportAdvertModel? advert;
  final _userId = FirebaseAuth.instance.currentUser!.uid;

  bool get isOwner => advert!.id == _userId;

  Set<Marker> beginMarkers = {};
  Set<Marker> endMarkers = {};
  late GoogleMapController mapBeginController;
  late GoogleMapController mapEndController;

  void getBeginDirections() => MapArgument.goToMap(data.beginGeoPoint);
  void getEndDirections() => MapArgument.goToMap(data.endGeoPoint);

  bool get showBeginLocation => (data.beginGeoPoint != null && data.beginGeoPoint!.latitude != 0);
  bool get showEndLocation => (data.endGeoPoint != null && data.endGeoPoint!.latitude != 0);

  void onBeginMapCreated(GoogleMapController controller) async {
    mapBeginController = controller;
    mapBeginController.setMapStyle(MapArgument.darkStyleText);
  }

  void onEndMapCreated(GoogleMapController controller) async {
    mapEndController = controller;
    mapEndController.setMapStyle(MapArgument.darkStyleText);
  }

  showFullScreen(int index) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.black,
        isScrollControlled: true,
        builder: (_) => Padding(padding: EdgeInsets.only(top: context.mediaQuery.padding.top), child: FullscreenSlider(images: advert!.images, index: index)));
  }

  _getAdvertData() {
    changeLoading();
    _repository.getTransportAdvert(data.advertId).then((value) {
      advert = value;
      changeLoading();
    }, onError: (e) {
      context.showSnackBar(context.localization.somethingWentWrong);
      context.pop();
    });
  }

  void call() => _launch(isOwner ? 'tel:${data.dialCode}${data.phone}' : 'tel:${advert!.dialCode}${advert!.phone}');

  void message() => context.push(ChatMessageListView(
      chatProvider.chats.firstOrNullWhere((x) => x.userIds.containsAll([_userId, data.userId])) ?? ChatModel(userIds: [FirebaseAuth.instance.currentUser!.uid, data.userId])));

  Future<void> _launch(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
