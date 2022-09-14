import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/chat/model/chat_advert_model.dart';
import 'package:petjoo/chat/service/chat_service.dart';
import 'package:petjoo/pet/model/pet_advert_model.dart';
import 'package:petjoo/pet/service/pet_service.dart';
import 'package:petjoo/pet/view/pet_detail_view.dart';
import 'package:petjoo/store/model/store_advert_model.dart';
import 'package:petjoo/store/service/store_service.dart';
import 'package:petjoo/store/view/store_detail_view.dart';
import 'package:petjoo/transport/model/transport_advert_model.dart';
import 'package:petjoo/transport/service/transport_service.dart';
import 'package:petjoo/transport/view/transport_detail_view.dart';
part 'message_advert_box_viewmodel.g.dart';

class MessageAdvertBoxViewModel = MessageAdvertBoxViewModelBase
    with _$MessageAdvertBoxViewModel;

abstract class MessageAdvertBoxViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  ChatAdvertModel? model;
  @observable
  String title = '';
  @observable
  String image = '';

  @action
  void setModel(ChatAdvertModel xmodel) {
    model = xmodel;
  }

  @action
  Future getAdvertInfo() async {
    isLoading = !isLoading;
    Map data = {};
    switch (model!.advertCollection) {
      case 'adverts':
        data = await ChatService.getAdvertInfo(
            model!.advertCollection, model!.advertId);
        break;
      case 'store_adverts':
        data = await ChatService.getAdvertInfo(
            model!.advertCollection, model!.advertId);
        break;
      case 'transport_adverts':
        data = await ChatService.getAdvertInfo(
            model!.advertCollection, model!.advertId);
        break;
      default:
    }
    title = data['title'];
    image = data['image'];
    isLoading = !isLoading;
  }

  @action
  Future goAdvert(BuildContext context) async {
    switch (model!.advertCollection) {
      case 'adverts':
        await PetService.db
            .collection('adverts')
            .doc(model!.advertId)
            .get()
            .then((value) {
          PetAdvertModel model = PetAdvertModel.fromDS(value);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PetDetailView(model: model)));
        });
        break;
      case 'store_adverts':
        await StoreService.db
            .collection('store_adverts')
            .doc(model!.advertId)
            .get()
            .then((value) {
          StoreAdvertModel model = StoreAdvertModel.fromDS(value);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StoreDetailView(model: model)));
        });
        break;
      case 'transport_adverts':
        await TransportService.db
            .collection('transport_adverts')
            .doc(model!.advertId)
            .get()
            .then((value) {
          TransportAdvertModel model = TransportAdvertModel.fromDS(value);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TransportDetailView(model: model)));
        });
        break;
      default:
    }
  }
}
