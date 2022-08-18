import 'package:flutter/material.dart';
import 'package:petjoo/modules/user/viewmodel/register_viewmodel.dart';

class RegisterView extends StatelessWidget {
  final RegisterViewModel vm = RegisterViewModel();
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Hesap Oluştur'),
    );
  }
}
