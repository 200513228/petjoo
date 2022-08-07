import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/dropdown_x.dart';
import 'package:petjoo/modules/store/model/store_advert_deliveries.dart';
import 'package:petjoo/modules/store/model/store_adverts_types.dart';
import 'package:petjoo/modules/store/viewmodel/store_add_viewmodel.dart';
import 'package:petjoo/product/constants/dial_codes.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/validators.dart';

class StoreAddView extends StatelessWidget {
  final StoreAddViewModel vm = StoreAddViewModel();
  StoreAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: buildFab(context),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: vm.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...advertTiles,
                const SizedBox(height: 20),
                ...storeTiles,
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
          maxLength: 50,
          validator: Validators.title('Başlık En Az 3 harfli olmalıdır.'),
          decoration: const InputDecoration(
            counterText: '',
            label: Text('Başlık'),
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
          validator:
              Validators.description('Açıklama En Az 4 harfli olmalıdır.'),
          decoration: const InputDecoration(
            label: Text('Açıklama'),
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
    ];
  }

  List<Widget> get storeTiles {
    return [
      Row(
        children: [
          Expanded(
            child: DropdownX<int>(
              value: vm.type,
              hint: 'Kategori',
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
              hint: 'Teslimat',
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
        child: TextFormField(
          controller: vm.priceCont,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[.0-9]'))
          ],
          textInputAction: TextInputAction.next,
          maxLength: 50,
          decoration: const InputDecoration(
            counterText: '',
            label: Text('Fiyat'),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: TextFormField(
          controller: vm.addressCont,
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
          maxLength: 500,
          maxLines: 4,
          decoration: const InputDecoration(
            label: Text('Adres'),
          ),
        ),
      ),
    ];
  }

  Widget buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        vm.nextStep(context);
      },
      child: const Icon(FontAwesomeIcons.photoFilm),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Yeni İlan'),
    );
  }
}
