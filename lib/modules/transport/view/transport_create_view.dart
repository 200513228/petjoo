import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/modules/transport/viewmodel/transport_create_viewmodel.dart';
import 'package:petjoo/product/constants/validators.dart';
import 'package:petjoo/product/ui/themes/classic_theme.dart';

class TransportCreateView extends StatelessWidget {
  static final TransportCreateViewModel vm = TransportCreateViewModel();
  const TransportCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    vm.setAdvert();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text('transport_create'.tr()),
        centerTitle: true,
      ),
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
                      workHours(context),
                      nextStepButton(context),
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
          maxLength: 400,
          maxLines: 4,
          validator: Validators.description('desc_min4'.tr()),
          decoration: InputDecoration(
            label: Text('description'.tr()),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
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
                  label: Text('price_per_km'.tr()),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: TextFormField(
                enableIMEPersonalizedLearning: true,
                controller: vm.addressCont,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLength: 200,
                maxLines: 2,
                decoration: InputDecoration(
                    label: Text('address'.tr()), counterText: ''),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Observer(builder: (_) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => vm.isIntercity = !vm.isIntercity,
                  child: advertInfoCard('intercity'.tr(),
                      FontAwesomeIcons.earthAmericas, vm.isIntercity),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => vm.hasCage = !vm.hasCage,
                  child: advertInfoCard(
                      'cage'.tr(), FontAwesomeIcons.shieldDog, vm.hasCage),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => vm.hasCollar = !vm.hasCollar,
                  child: advertInfoCard(
                      'collar'.tr(), Icons.circle_outlined, vm.hasCollar),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => vm.canCatch = !vm.canCatch,
                  child: advertInfoCard('catch'.tr(),
                      FontAwesomeIcons.personRunning, vm.canCatch),
                ),
              )
            ],
          );
        }),
      ),
    ];
  }

  Widget advertInfoCard(String title, IconData icon, bool isTrue) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 7.5),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Column(
        children: [
          Text(title,
              maxLines: 1,
              style: const TextStyle(fontSize: 10, color: Colors.white54)),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              icon,
              size: 20,
              color: isTrue
                  ? Colors.white.withOpacity(.9)
                  : ClassicTheme.myTheme()
                      .colorScheme
                      .onSurface
                      .withOpacity(.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget workHours(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: () => vm.editHours(context),
              child: Row(
                children: [
                  Expanded(child: Text('edit_working_hours'.tr())),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget nextStepButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
                onPressed: () => vm.nextStep(context),
                child: Text('next_step'.tr())),
          ),
        )
      ],
    );
  }
}
