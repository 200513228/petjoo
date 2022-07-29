import 'dart:typed_data';

import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/enums/report_types.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/domain/repositories/advert_repository.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';
import 'package:petjoo/presentation/chat/view/chat_message_list_view.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/constants/map_argument.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/models/chat_model.dart';
import 'package:petjoo/product/providers/chat_provider.dart';
import 'package:petjoo/product/services/dynamic_link_service.dart';
import 'package:petjoo/product/ui/dialogs/delete_dialog.dart';
import 'package:petjoo/product/ui/dialogs/info_dialog.dart';
import 'package:petjoo/product/ui/dialogs/warning_dialog.dart';
import 'package:petjoo/product/ui/widgets/fullscreen_slider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AdvertDetailViewModel extends PageNotifier {
  AdvertDetailViewModel(super.context, this._repository, this.data, this.chatProvider);

  final AdvertRepository _repository;
  final AdvertModel data;
  final ChatProvider chatProvider;
  final _userId = FirebaseAuth.instance.currentUser!.uid;

  bool get isOwner => data.userId == _userId;
  Set<Marker> markers = {};
  late GoogleMapController mapController;

  void share() async => Share.share((await DynamicLinkService.instance.createAdvertLink(data)).toString());
  void report() async {
    _repository.reportAdvert(data.id!, _userId, ReportTypes.spam);
    showDialog(
        context: context,
        builder: (context) => InfoDialog(
              title: context.localization.advertReportTitle,
              description: context.localization.advertReportDescription,
            ));
  }

  void getDirections() => MapArgument.goToMap(data.geoPoint);

  void call() => _launch('tel:${data.dialCode}${data.phone}');

  void message() => context.push(ChatMessageListView(
      chatProvider.chats.firstOrNullWhere((x) => x.userIds.containsAll([_userId, data.userId])) ?? ChatModel(userIds: [FirebaseAuth.instance.currentUser!.uid, data.userId])));

  void edit() => context.pushNamed(Routes.advertInput, arguments: data);

  void sureFordelete() => showDialog(context: context, builder: (context) => DeleteDialog(onDeleteTap: _delete));

  void adaptionWarning() => showDialog(
      context: context,
      builder: (context) => WarningDialog(
            title: context.localization.adoptionWarning,
            description: context.localization.adoptionWarningDescription,
            cancelText: context.localization.skip,
            doneText: context.localization.download,
            onCancelTap: _setAsAdopted,
            onDoneTap: () {
              context.pop();
              _launch(
                  "https://firebasestorage.googleapis.com/v0/b/petjoo-129db.appspot.com/o/docs%2Fsahiplendirme%20formu.docx?alt=media&token=0d6d5ff7-812f-4274-beb9-75bf26f86b43");
            },
          ));

  void _setAsAdopted() async {
    await _repository.updateAdvertAsAdopted(data.id!);
    data.isAdopted = true;
    notifyListeners();
  }

  void _delete() {
    context.pop();
    changeLoading();

    _repository.deleteAdvert(data.id!).then((value) => context.pop(), onError: (_) {
      context.showSnackBar(context.localization.somethingWentWrong);
      changeLoading();
    });
  }

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
