import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/core/widgets/dropdown_x.dart';
import 'package:petjoo/domain/enums/advert/advert_type.dart';
import 'package:petjoo/domain/enums/advert/animal_gender.dart';
import 'package:petjoo/domain/enums/advert/animal_habits.dart';
import 'package:petjoo/domain/enums/advert/animal_size.dart';
import 'package:petjoo/domain/enums/advert/animals.dart';
import 'package:petjoo/domain/enums/advert/infertility.dart';
import 'package:petjoo/domain/enums/advert/toilet_training.dart';
import 'package:petjoo/domain/enums/advert/vaccine.dart';
import 'package:petjoo/presentation/animal_advert/view_model/advert_input_view_model.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/product/constants/dial_codes.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/constants/validators.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';
import 'package:petjoo/product/ui/widgets/subtitle.dart';

class AdvertInputView extends ConsumerStatefulWidget {
  final AdvertModel data;
  AdvertInputView(AdvertModel? data, {Key? key})
      : data = data ?? AdvertModel(userId: FirebaseAuth.instance.currentUser!.uid, date: DateTime.now()),
        super(key: key);

  @override
  ConsumerStateX<AdvertInputView> createState() => _AdvertInputViewState();
}

class _AdvertInputViewState extends ConsumerStateX<AdvertInputView> {
  late final advertInputViewModel = ChangeNotifierProvider((ref) => AdvertInputViewModel(context, widget.data, ref.read(userProvider).user));
  late final viewModel = ref.read(advertInputViewModel);
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toAll(theme.scaffoldBackgroundColor, Brightness.dark),
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.isEdit ? localization.editAdvert : localization.addAdvert),
        ),
        body: Form(
          key: viewModel.formKey,
          child: ListView(
            padding: const EdgeInsets.all(Dimens.padding),
            children: [
              ..._advertFeatures,
              ..._animalFeatures,
              const Separator(),
              ButtonX(
                  borderRadius: Dimens.radiusSmall.toBorderRadius(),
                  margin: const EdgeInsets.only(top: Dimens.padding),
                  padding: const EdgeInsets.all(Dimens.paddingSmall),
                  color: theme.colorScheme.secondary,
                  onTap: viewModel.save,
                  child: Text(
                    localization.next,
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> get _advertFeatures => [
        TextFormField(
          controller: viewModel.titleController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          maxLength: 50,
          validator: Validators.title(localization.titleError),
          decoration: InputDecoration(
            counterText: '',
            label: Text(localization.title),
          ),
        ),
        const Separator(),
        TextFormField(
          controller: viewModel.descriptionController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          maxLength: 500,
          maxLines: 5,
          validator: Validators.description(localization.descriptionError),
          decoration: InputDecoration(
            label: Text(localization.description),
          ),
        ),
        const Separator(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ValueListenableBuilder<String>(
                valueListenable: viewModel.dialCode,
                builder: (context, value, _) => DropdownX<String>(
                  value: value,
                  borderRadius: Dimens.radiusSmall.toLeftBorderRadius(),
                  validator: (value) => value?.isEmpty == true ? "" : null,
                  items: dialCodes.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {},
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: TextFormField(
                controller: viewModel.phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                textInputAction: TextInputAction.next,
                validator: Validators.phone(localization.phoneError, true),
                decoration: InputDecoration(
                    label: Text(localization.phone),
                    hintText: localization.phoneFormat,
                    counterText: '',
                    border: UnderlineInputBorder(borderRadius: Dimens.radiusSmall.toRightBorderRadius()),
                    focusedBorder: UnderlineInputBorder(borderRadius: Dimens.radiusSmall.toRightBorderRadius()),
                    errorBorder: UnderlineInputBorder(borderRadius: Dimens.radiusSmall.toRightBorderRadius()),
                    focusedErrorBorder: UnderlineInputBorder(borderRadius: Dimens.radiusSmall.toRightBorderRadius())),
              ),
            ),
          ],
        ),
        const Separator(),
        ValueListenableBuilder<AdvertType>(
            valueListenable: viewModel.status,
            builder: (context, value, _) => DropdownX<AdvertType>(
                  value: value,
                  hintValue: AdvertType.none,
                  hint: localization.advertType,
                  validator: (value) => value?.index == 0 ? "" : null,
                  items: AdvertType.values
                      .sublist(1)
                      .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(
                            status.toLocalizedString(context),
                          )))
                      .toList(),
                  onChanged: (value) => viewModel.status.value = value!,
                ))
      ];

  List<Widget> get _animalFeatures => [
        Subtitle(
          localization.animalFeatures,
          margin: const EdgeInsets.only(top: Dimens.paddingLarge, bottom: Dimens.paddingSmall),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: viewModel.ageController,
                keyboardType: TextInputType.number,
                maxLength: 2,
                textInputAction: TextInputAction.next,
                validator: Validators.number(localization.ageError, true),
                decoration: InputDecoration(
                  counterText: '',
                  label: Text(localization.age),
                ),
              ),
            ),
            const Separator(),
            Expanded(
              child: ValueListenableBuilder<Animals>(
                  valueListenable: viewModel.animalType,
                  builder: (context, value, _) => DropdownX<Animals>(
                        value: value,
                        hintValue: Animals.none,
                        hint: localization.type,
                        validator: (value) => value?.index == 0 ? "" : null,
                        items: Animals.values
                            .sublist(1)
                            .map((animal) => DropdownMenuItem(
                                value: animal,
                                child: Text(
                                  animal.toLocalizedString(context),
                                )))
                            .toList(),
                        onChanged: (value) => viewModel.animalType.value = value!,
                      )),
            ),
          ],
        ),
        const Separator(),
        Row(
          children: [
            Expanded(
              child: ValueListenableBuilder<AnimalGender>(
                  valueListenable: viewModel.animalGender,
                  builder: (context, value, _) => DropdownX<AnimalGender>(
                        value: value,
                        hintValue: AnimalGender.none,
                        hint: localization.gender,
                        validator: (value) => value?.index == 0 ? "" : null,
                        items: AnimalGender.values
                            .sublist(1)
                            .map((gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(
                                  gender.toLocalizedString(context),
                                )))
                            .toList(),
                        onChanged: (value) => viewModel.animalGender.value = value!,
                      )),
            ),
            const Separator(),
            Expanded(
              child: ValueListenableBuilder<AnimalSize>(
                  valueListenable: viewModel.animalSize,
                  builder: (context, value, _) => DropdownX<AnimalSize>(
                        value: value,
                        hintValue: AnimalSize.none,
                        hint: localization.size,
                        validator: (value) => value?.index == 0 ? "" : null,
                        items: AnimalSize.values
                            .sublist(1)
                            .map((size) => DropdownMenuItem(
                                value: size,
                                child: Text(
                                  size.toLocalizedString(context),
                                )))
                            .toList(),
                        onChanged: (value) => viewModel.animalSize.value = value!,
                      )),
            ),
          ],
        ),
        const Separator(),
        Row(
          children: [
            Expanded(
              child: ValueListenableBuilder<AnimalHabits>(
                  valueListenable: viewModel.animalHabit,
                  builder: (context, value, _) => DropdownX<AnimalHabits>(
                        value: value,
                        hintValue: AnimalHabits.none,
                        hint: localization.habit,
                        validator: (value) => value?.index == 0 ? "" : null,
                        items: AnimalHabits.values
                            .sublist(1)
                            .map((habit) => DropdownMenuItem(
                                value: habit,
                                child: Text(
                                  habit.toLocalizedString(context),
                                )))
                            .toList(),
                        onChanged: (value) => viewModel.animalHabit.value = value!,
                      )),
            ),
            const Separator(),
            Expanded(
              child: ValueListenableBuilder<Infertility>(
                  valueListenable: viewModel.infertility,
                  builder: (context, value, _) => DropdownX<Infertility>(
                        value: value,
                        hintValue: Infertility.none,
                        hint: localization.infertility,
                        validator: (value) => value?.index == 0 ? "" : null,
                        items: Infertility.values
                            .sublist(1)
                            .map((infertility) => DropdownMenuItem(
                                value: infertility,
                                child: Text(
                                  infertility.toLocalizedString(context),
                                )))
                            .toList(),
                        onChanged: (value) => viewModel.infertility.value = value!,
                      )),
            ),
          ],
        ),
        const Separator(),
        Row(
          children: [
            Expanded(
              child: ValueListenableBuilder<ToiletTraining>(
                  valueListenable: viewModel.toiletTraining,
                  builder: (context, value, _) => DropdownX<ToiletTraining>(
                        value: value,
                        hintValue: ToiletTraining.none,
                        hint: localization.toiletTraining,
                        validator: (value) => value?.index == 0 ? "" : null,
                        items: ToiletTraining.values
                            .sublist(1)
                            .map((toiletTraining) => DropdownMenuItem(
                                value: toiletTraining,
                                child: Text(
                                  toiletTraining.toLocalizedString(context),
                                )))
                            .toList(),
                        onChanged: (value) => viewModel.toiletTraining.value = value!,
                      )),
            ),
            const Separator(),
            Expanded(
              child: ValueListenableBuilder<Vaccine>(
                  valueListenable: viewModel.vaccine,
                  builder: (context, value, _) => DropdownX<Vaccine>(
                        value: value,
                        hintValue: Vaccine.none,
                        hint: localization.vaccine,
                        validator: (value) => value?.index == 0 ? "" : null,
                        items: Vaccine.values
                            .sublist(1)
                            .map((vaccine) => DropdownMenuItem(
                                value: vaccine,
                                child: Text(
                                  vaccine.toLocalizedString(context),
                                )))
                            .toList(),
                        onChanged: (value) => viewModel.vaccine.value = value!,
                      )),
            ),
          ],
        )
      ];
}
