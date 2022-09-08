import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/home/service/dlink_service.dart';
import 'package:petjoo/home/view/home_view.dart';
import 'package:petjoo/pet/model/pet_advert_model.dart';
import 'package:petjoo/pet/service/pet_service.dart';
import 'package:petjoo/pet/view/pet_detail_view.dart';
import 'package:petjoo/store/model/store_advert_model.dart';
import 'package:petjoo/store/service/store_service.dart';
import 'package:petjoo/store/view/store_detail_view.dart';
import 'package:petjoo/user/service/user_service.dart';
part 'welcome_viewmodel.g.dart';

class WelcomeViewModel = WelcomeViewModelBase with _$WelcomeViewModel;

abstract class WelcomeViewModelBase with Store {
  @observable
  bool userLog = false;

  @observable
  bool isLoading = false;

  @action
  Future userLogin(BuildContext context) async {
    if (UserService.auth.currentUser != null) {
      isLoading = !isLoading;
      await UserService.currentUser().then((value) {
        userLog = !userLog;
        isLoading = !isLoading;
        DLinkService.type != null ? navDLink(context) : null;
      });
    }
  }

  @action
  void goModule(BuildContext _, String title) {
    Navigator.push(
        _, MaterialPageRoute(builder: (context) => HomeView(title: title)));
  }

  @action
  Future navDLink(BuildContext context) async {
    if (DLinkService.isGo) {
      switch (DLinkService.type) {
        case 'pet':
          await PetService.db
              .collection('adverts')
              .doc(DLinkService.docid)
              .get()
              .then((value) {
            PetAdvertModel model = PetAdvertModel.fromDS(value);
            DLinkService.isGo = false;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PetDetailView(model: model)));
          });
          break;
        case 'store':
          await StoreService.db
              .collection('store_adverts')
              .doc(DLinkService.docid)
              .get()
              .then((value) {
            StoreAdvertModel model = StoreAdvertModel.fromDS(value);
            DLinkService.isGo = false;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StoreDetailView(model: model)));
          });
          break;
        default:
      }
    }
  }
}
