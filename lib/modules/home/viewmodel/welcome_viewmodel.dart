import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/user/service/user_service.dart';
part 'welcome_viewmodel.g.dart';

class WelcomeViewModel = WelcomeViewModelBase with _$WelcomeViewModel;

abstract class WelcomeViewModelBase with Store {
  @observable
  bool userLog = false;

  @action
  Future userLogin() async {
    if (UserService.auth.currentUser != null) {
      await UserService.currentUser();
      userLog = !userLog;
    }
  }
}
