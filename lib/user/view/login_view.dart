import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/ui/loading.dart';
import 'package:petjoo/ui/color_palette.dart';
import 'package:petjoo/user/viewmodel/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  final LoginViewModel vm = LoginViewModel();
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              logo,
              const SizedBox(height: 50),
              buildForm(context),
              const SizedBox(height: 50),
              createAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    return Observer(builder: (_) {
      return vm.isLoading
          ? const Loading()
          : Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textField(vm.emailCont, 'email'.tr(), false),
                  const SizedBox(height: 20),
                  textField(vm.passCont, 'password'.tr(), true),
                  const SizedBox(height: 5),
                  forgotPass(context),
                  const SizedBox(height: 20),
                  signButton(context),
                ],
              ),
            );
    });
  }

  Widget forgotPass(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: colorPalette['primary'],
              title: Text(
                'login_forgot'.tr(),
                style: const TextStyle(color: Colors.black),
              ),
              content: Row(
                children: [
                  Expanded(child: textField(vm.emailCont, 'email'.tr(), false))
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () async => await vm.forgotPass(context),
                    child: Text('login_send'.tr()))
              ],
            ),
          );
        },
        child: Text('login_forgot'.tr(),
            style: const TextStyle(color: Colors.black87)),
      ),
    );
  }

  Widget textField(TextEditingController cont, String label, bool isPass) {
    return TextFormField(
      keyboardType: isPass ? TextInputType.text : TextInputType.emailAddress,
      controller: cont,
      obscureText: isPass ? vm.obscPass : false,
      decoration: InputDecoration(
          labelText: label,
          suffixIcon: isPass
              ? IconButton(
                  onPressed: vm.changeObsc,
                  icon: const Icon(Icons.password, color: Colors.white),
                )
              : null),
    );
  }

  Widget signButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Hero(
            tag: 'button',
            child: ElevatedButton(
              onPressed: () async {
                await vm.login(context);
              },
              child: Text('login_title'.tr()),
            ),
          ),
        ),
      ],
    );
  }

  Widget createAccount(BuildContext context) {
    return InkWell(
      onTap: () {
        vm.createAcc(context);
      },
      child: Text(
        'login_no_account'.tr(),
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget get logo {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Image.asset('assets/images/logo.png'),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          )),
      centerTitle: true,
      title: Text('login_title'.tr()),
    );
  }
}
