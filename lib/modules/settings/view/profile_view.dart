import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/dropdown_x.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/modules/settings/viewmodel/profile_viewmodel.dart';
import 'package:petjoo/product/constants/dial_codes.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/validators.dart';

class ProfileView extends StatelessWidget {
  final ProfileViewModel vm = ProfileViewModel();
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profil'),
          centerTitle: true,
        ),
        body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return Observer(builder: (_) {
      return vm.isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Loading()],
            )
          : Container(
              margin: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    textField(vm.nameCont, 'İsim'),
                    textField(vm.surnameCont, 'Soyisim'),
                    buildPhone,
                    saveButton(context),
                  ],
                ),
              ),
            );
    });
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
              onChanged: (value) => vm.dialCode = value ?? '+90',
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

  Widget saveButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
            onPressed: () {
              vm.save(context);
            },
            child: const Text('Kaydet'),
          ))
        ],
      ),
    );
  }
}
