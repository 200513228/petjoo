import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/domain/enums/shift/days.dart';
import 'package:petjoo/infrastructure/model/shift_model.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/providers/user_provider.dart';
import 'package:petjoo/product/services/dynamic_link_service.dart';
import 'package:petjoo/product/ui/widgets/fullscreen_slider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../domain/repositories/transport_repository.dart';
import '../../../infrastructure/model/transport_advert_model.dart';

class TransportAdvertDetailOwnerViewModel extends PageNotifier {
  TransportAdvertDetailOwnerViewModel(super.context, this._repository, this._userProvider);

  final TransportRepository _repository;
  final UserProvider _userProvider;
  TransportAdvertModel? data;

  void share() async => Share.share((await DynamicLinkService.instance.createTransportAdvertLink(data!)).toString());

  void edit() {
    context.pushNamed(Routes.transportAdvertInput, arguments: data).then((value) => notifyListeners());
  }

  void editShifts() {
    context.pushNamed(Routes.transportAdvertShiftInput, arguments: data).then((value) => notifyListeners());
  }

  showFullScreen(int index) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.black,
        isScrollControlled: true,
        builder: (_) =>
            Padding(padding: EdgeInsets.only(top: context.mediaQuery.padding.top), child: FullscreenSlider(images: data!.images, index: index)));
  }

  void getData() async {
    data = await _repository.getTransportAdvert(FirebaseAuth.instance.currentUser!.uid).then((value) => value,
        onError: (_) => TransportAdvertModel(
            title: "",
            description: "",
            dialCode: _userProvider.user.dialCode,
            phone: _userProvider.user.phone,
            address: "",
            pricePerKm: 0,
            vehicleCapacity: 0,
            isIntercity: false,
            hasCage: false,
            hasCollar: false,
            canCatch: false,
            isActive: true,
            foundedDate: DateTime.now(),
            shifts: List.generate(
                Days.values.length,
                (index) => ShiftModel(
                    day: Days.values[index],
                    start: const TimeOfDay(hour: 0, minute: 0),
                    end: const TimeOfDay(hour: 0, minute: 0),
                    isActive: false))));
    notifyListeners();
  }
}
