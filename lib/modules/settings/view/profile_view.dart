import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/modules/base/num_extension.dart';
import 'package:petjoo/modules/base/dropdown_x.dart';
import 'package:petjoo/modules/base/loading.dart';
import 'package:petjoo/modules/settings/viewmodel/profile_viewmodel.dart';
import 'package:petjoo/modules/base/dial_codes.dart';
import 'package:petjoo/modules/base/dimens.dart';
import 'package:petjoo/modules/base/validators.dart';

class ProfileView extends StatelessWidget {
  final ProfileViewModel vm = ProfileViewModel();
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          title: Text('settings_profile'.tr()),
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
                    textField(vm.nameCont, 'name'.tr()),
                    textField(vm.surnameCont, 'surname'.tr()),
                    buildPhone,
                    saveButton(context),
                    deleteButton(context),
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
        obscureText: label == 'password'.tr(),
        validator: ((value) => value == '' ? 'register_valid'.tr() : null),
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
              hint: 'Dial Code',
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
            child: Text('save'.tr()),
          ))
        ],
      ),
    );
  }

  Widget deleteButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('profile_remove'.tr()),
                          content: Text('profile_remove_content'.tr()),
                          actions: [
                            TextButton(
                              onPressed: () {
                                vm.delete(context);
                              },
                              child: Text('profile_remove'.tr(),
                                  style: const TextStyle(color: Colors.red)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('close'.tr()),
                            )
                          ],
                        ));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: Text('profile_remove'.tr()),
            ),
          )
        ],
      ),
    );
  }
}
