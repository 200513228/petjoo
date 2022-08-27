import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/modules/base/color_palette.dart';
import 'package:petjoo/modules/user/viewmodel/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  final LoginViewModel vm = LoginViewModel();
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
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
                  textField(vm.emailCont, 'E-Posta', false),
                  const SizedBox(height: 20),
                  textField(vm.passCont, 'Şifre', true),
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
              title: const Text(
                'Şifremi Unuttum',
                style: TextStyle(color: Colors.black),
              ),
              content: Row(
                children: [
                  Expanded(child: textField(vm.emailCont, 'E-Posta', false))
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () async => await vm.forgotPass(context),
                    child: const Text('Gönder'))
              ],
            ),
          );
        },
        child: const Text('Şifremi Unuttum',
            style: TextStyle(color: Colors.black87)),
      ),
    );
  }

  Widget textField(TextEditingController cont, String label, bool isPass) {
    return TextFormField(
      keyboardType: isPass ? TextInputType.text : TextInputType.emailAddress,
      controller: cont,
      obscureText: isPass,
      decoration: InputDecoration(labelText: label),
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
              child: const Text('Giriş Yap'),
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
      child: const Text(
        'Hesabınız Yok Mu?  Bir Hesap Oluşturun.',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget get logo {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Image.asset('assets/images/logo.png'),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Giriş Yap'),
    );
  }
}
