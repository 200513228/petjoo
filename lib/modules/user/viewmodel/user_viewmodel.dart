import 'package:mobx/mobx.dart';
part 'user_viewmodel.g.dart';

class UserViewModel = UserViewModelBase with _$UserViewModel;

abstract class UserViewModelBase with Store {}
