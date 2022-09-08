import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/base/num_extension.dart';
import 'package:petjoo/ui/dropdown_x.dart';
import 'package:petjoo/ui/loading.dart';
import 'package:petjoo/store/model/store_advert_deliveries.dart';
import 'package:petjoo/store/model/store_advert_model.dart';
import 'package:petjoo/store/model/store_advert_statuses.dart';
import 'package:petjoo/store/model/store_adverts_types.dart';
import 'package:petjoo/store/viewmodel/store_add_viewmodel.dart';
import 'package:petjoo/constants/dial_codes.dart';
import 'package:petjoo/constants/dimens.dart';
import 'package:petjoo/base/validators.dart';

class StoreAddView extends StatelessWidget {
  final StoreAdvertModel? model;
  final StoreAddViewModel vm = StoreAddViewModel();
  StoreAddView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model != null) vm.preEdit(model!);
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: vm.isLoading
            ? const Center(child: Loading())
            : Form(
                key: vm.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...advertTiles,
                      const SizedBox(height: 20),
                      ...storeTiles,
                      nextStepButton(context)
                    ],
                  ),
                ),
              ),
      );
    });
  }

  List<Widget> get advertTiles {
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          controller: vm.titleCont,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          maxLength: 30,
          validator: Validators.title('title_min3'.tr()),
          decoration: InputDecoration(
            counterText: '',
            label: Text('title'.tr()),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          controller: vm.descCont,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          maxLength: 500,
          maxLines: 5,
          validator: Validators.description('desc_min4'.tr()),
          decoration: InputDecoration(
            label: Text('description'.tr()),
          ),
        ),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: DropdownX<String>(
              value: vm.dialCode,
              borderRadius: Dimens.radiusSmall.toLeftBorderRadius(),
              validator: (value) => value?.isEmpty == true ? "" : null,
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
    ];
  }

  List<Widget> get storeTiles {
    return [
      Row(
        children: [
          Expanded(
            child: DropdownX<int>(
              value: vm.type,
              hint: 'category'.tr(),
              borderRadius: Dimens.radiusSmall.toLeftBorderRadius(),
              items: storeAdvertTypes.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(storeAdvertTypes[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.type = value,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: DropdownX<int>(
              value: vm.delivery,
              hint: 'delivery'.tr(),
              borderRadius: Dimens.radiusSmall.toRightBorderRadius(),
              items: storeAdvertDeliveries.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(storeAdvertDeliveries[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.delivery = value,
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: vm.priceCont,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[.0-9]'))
                ],
                textInputAction: TextInputAction.next,
                maxLength: 50,
                decoration: InputDecoration(
                  counterText: '',
                  prefixText: '₺',
                  label: Text('price'.tr()),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: DropdownX<int>(
                value: vm.status,
                hint: 'status'.tr(),
                borderRadius: Dimens.radiusSmall.toRightBorderRadius(),
                items: storeAdvertStatuses.keys
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(storeAdvertStatuses[e]!),
                        ))
                    .toList(),
                onChanged: (value) => vm.status = value,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: TextFormField(
          controller: vm.addressCont,
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
          maxLength: 50,
          maxLines: 4,
          decoration: InputDecoration(
            label: Text('address'.tr()),
          ),
        ),
      ),
    ];
  }

  Widget nextStepButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
                onPressed: () {
                  vm.nextStep(context);
                },
                child: Text('next_step'.tr())),
          ),
        )
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      centerTitle: true,
      title: Text(
          model != null ? 'edit_advert_title'.tr() : 'new_advert_title'.tr()),
    );
  }
}
