import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/dropdown_x.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/modules/user/viewmodel/register_viewmodel.dart';
import 'package:petjoo/product/constants/dial_codes.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/validators.dart';

class RegisterView extends StatelessWidget {
  final RegisterViewModel vm = RegisterViewModel();
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Observer(builder: (_) {
        return Column(
          children: [
            Expanded(
                flex: 6, child: vm.isLoading ? loading() : buildForm(context)),
          ],
        );
      }),
    );
  }

  Widget buildForm(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Form(
        key: vm.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              textField(vm.emailCont, 'E-Posta'),
              textField(vm.nameCont, 'İsim'),
              textField(vm.surNameCont, 'Soyisim'),
              buildPhone,
              textField(vm.passCont, 'Şifre'),
              info(context),
              registerButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(TextEditingController cont, String label) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: cont,
        obscureText: label == 'Şifre',
        validator: ((value) => value == '' ? 'Bu alan boş bırakılamaz' : null),
        maxLength: 70,
        maxLines: 1,
        minLines: 1,
        decoration: InputDecoration(labelText: label, counterText: ''),
      ),
    );
  }

  Widget get buildPhone {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: DropdownX<String>(
              hint: 'Ülke Kodu',
              value: vm.dialCode,
              borderRadius: Dimens.radiusSmall.toLeftBorderRadius(),
              items: dialCodes.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) => vm.dialCode = value,
            ),
          ),
          Expanded(
            flex: 5,
            child: TextFormField(
              controller: vm.phoneCont,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              textInputAction: TextInputAction.next,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator:
                  Validators.phone('Geçerli Bir Telefon No Giriniz', true),
              decoration: InputDecoration(
                  label: const Text('Telefon'),
                  hintText: '5xx xxx xx xx',
                  counterText: '',
                  border: UnderlineInputBorder(
                      borderRadius: Dimens.radiusSmall.toRightBorderRadius()),
                  focusedBorder: UnderlineInputBorder(
                      borderRadius: Dimens.radiusSmall.toRightBorderRadius()),
                  errorBorder: UnderlineInputBorder(
                      borderRadius: Dimens.radiusSmall.toRightBorderRadius()),
                  focusedErrorBorder: UnderlineInputBorder(
                      borderRadius: Dimens.radiusSmall.toRightBorderRadius())),
            ),
          ),
        ],
      ),
    );
  }

  Widget registerButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: Hero(
            tag: 'button',
            child: ElevatedButton(
              onPressed: () {
                vm.register(context);
              },
              child: const Text('Kayıt Ol'),
            ),
          ))
        ],
      ),
    );
  }

  Widget info(BuildContext context) {
    TextStyle style = const TextStyle(color: Colors.black);
    TextStyle style2 = const TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Uygulamamızı kullanarak aşağıdaki sözleşmeleri kabul etmiş olursunuz.',
                    style: style,
                    maxLines: 2,
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      vm.navigate(context, 'privacy_policy.txt');
                    },
                    child: Text('Gizlilik Sözleşmesi',
                        style: style2, maxLines: 1)),
                Text(' ve ', style: style, maxLines: 1),
                InkWell(
                    onTap: () {
                      vm.navigate(context, 'terms_of_use.txt');
                    },
                    child:
                        Text('Kullanım Koşulları', style: style2, maxLines: 1)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Hesap Oluştur'),
    );
  }

  Widget loading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [Loading()],
    );
  }
}
