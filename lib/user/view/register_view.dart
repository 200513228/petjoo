import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/base/num_extension.dart';
import 'package:petjoo/ui/dropdown_x.dart';
import 'package:petjoo/ui/loading.dart';
import 'package:petjoo/user/viewmodel/register_viewmodel.dart';
import 'package:petjoo/constants/dial_codes.dart';
import 'package:petjoo/constants/dimens.dart';
import 'package:petjoo/base/validators.dart';

class RegisterView extends StatelessWidget {
  final RegisterViewModel vm = RegisterViewModel();
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
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
              textField(vm.emailCont, 'email'.tr()),
              textField(vm.nameCont, 'name'.tr()),
              textField(vm.surNameCont, 'surname'.tr()),
              buildPhone,
              passField,
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
          validator: ((value) => value == '' ? 'register_valid'.tr() : null),
          maxLength: 70,
          maxLines: 1,
          minLines: 1,
          decoration: InputDecoration(labelText: label, counterText: ''),
        ));
  }

  Widget get passField {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: vm.passCont,
        obscureText: vm.obscPass,
        validator: ((value) => value == '' ? 'register_valid'.tr() : null),
        maxLength: 70,
        maxLines: 1,
        minLines: 1,
        decoration: InputDecoration(
            labelText: 'password'.tr(),
            counterText: '',
            suffixIcon: IconButton(
              onPressed: vm.changeObsc,
              icon: const Icon(Icons.password, color: Colors.white),
            )),
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
              hint: 'Dial Code',
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
              validator: Validators.phone('register_phone_valid'.tr(), true),
              decoration: InputDecoration(
                  label: Text('phone'.tr()),
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
              child: Text('register_title'.tr()),
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
                    'register_info'.tr(),
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
                    child:
                        Text('privacypolicy'.tr(), style: style2, maxLines: 1)),
                Text(' ${'and'.tr()} ', style: style, maxLines: 1),
                InkWell(
                    onTap: () {
                      vm.navigate(context, 'terms_of_use.txt');
                    },
                    child: Text('termsofuse'.tr(), style: style2, maxLines: 1)),
              ],
            ),
          ),
        ],
      ),
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
      title: Text('register_title'.tr()),
    );
  }

  Widget loading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [Loading()],
    );
  }
}
