import 'package:mobx/mobx.dart';
import 'package:petjoo/chat/model/chat_advert_model.dart';
import 'package:petjoo/chat/service/chat_service.dart';
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
}
