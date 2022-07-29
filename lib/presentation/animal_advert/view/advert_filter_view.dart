import 'package:flutter/material.dart';
import 'package:petjoo/core/base/state/state_x.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/core/widgets/dropdown_x.dart';
import 'package:petjoo/product/constants/dimens.dart';

import '../../../domain/enums/advert/advert_type.dart';
import '../../../domain/enums/advert/animal_gender.dart';
import '../../../domain/enums/advert/animal_habits.dart';
import '../../../domain/enums/advert/animal_size.dart';
import '../../../domain/enums/advert/animals.dart';
import '../../../domain/enums/advert/infertility.dart';
import '../../../domain/enums/advert/toilet_training.dart';
import '../../../domain/enums/advert/vaccine.dart';
import '../../../product/models/advert_filter_model.dart';
import '../../../product/ui/widgets/separator.dart';

class AdvertFilterView extends StatefulWidget {
  final AdvertFilterModel data;

  const AdvertFilterView({Key? key, required this.data}) : super(key: key);

  @override
  State<AdvertFilterView> createState() => _AdvertFilterViewState();
}

class _AdvertFilterViewState extends StateX<AdvertFilterView> {
  late final ValueNotifier<AdvertType> advertType = ValueNotifier(widget.data.advertType);
  late final ValueNotifier<Animals> animalType = ValueNotifier(widget.data.animalType);
  late final ValueNotifier<AnimalGender> animalGender = ValueNotifier(widget.data.animalGender);
  late final ValueNotifier<AnimalSize> animalSize = ValueNotifier(widget.data.animalSize);
  late final ValueNotifier<AnimalHabits> animalHabit = ValueNotifier(widget.data.animalHabit);
  late final ValueNotifier<Infertility> infertility = ValueNotifier(widget.data.infertility);
  late final ValueNotifier<ToiletTraining> toiletTraining = ValueNotifier(widget.data.toiletTraining);
  late final ValueNotifier<Vaccine> vaccine = ValueNotifier(widget.data.vaccine);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: Dimens.radius.toTopBorderRadius()),
      child: Column(
        children: [
          AppBar(
            title: Text(localization.filter),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(Dimens.padding),
              children: [
                ValueListenableBuilder<AdvertType>(
                    valueListenable: advertType,
                    builder: (context, value, _) => DropdownX<AdvertType>(
                          value: value,
                          hintValue: AdvertType.none,
                          hint: localization.advertType,
                          items: AdvertType.values
                              .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(
                                    type.toLocalizedString(context),
                                  )))
                              .toList(),
                          onChanged: (value) => advertType.value = value!,
                        )),
                const Separator(),
                ValueListenableBuilder<Animals>(
                    valueListenable: animalType,
                    builder: (context, value, _) => DropdownX<Animals>(
                          value: value,
                          hintValue: Animals.none,
                          hint: localization.type,
                          items: Animals.values
                              .map((animal) => DropdownMenuItem(
                                  value: animal,
                                  child: Text(
                                    animal.toLocalizedString(context),
                                  )))
                              .toList(),
                          onChanged: (value) => animalType.value = value!,
                        )),
                const Separator(),
                ValueListenableBuilder<AnimalGender>(
                    valueListenable: animalGender,
                    builder: (context, value, _) => DropdownX<AnimalGender>(
                          value: value,
                          hintValue: AnimalGender.none,
                          hint: localization.gender,
                          items: AnimalGender.values
                              .map((gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(
                                    gender.toLocalizedString(context),
                                  )))
                              .toList(),
                          onChanged: (value) => animalGender.value = value!,
                        )),
                const Separator(),
                ValueListenableBuilder<AnimalSize>(
                    valueListenable: animalSize,
                    builder: (context, value, _) => DropdownX<AnimalSize>(
                          value: value,
                          hintValue: AnimalSize.none,
                          hint: localization.size,
                          items: AnimalSize.values
                              .map((size) => DropdownMenuItem(
                                  value: size,
                                  child: Text(
                                    size.toLocalizedString(context),
                                  )))
                              .toList(),
                          onChanged: (value) => animalSize.value = value!,
                        )),
                const Separator(),
                ValueListenableBuilder<AnimalHabits>(
                    valueListenable: animalHabit,
                    builder: (context, value, _) => DropdownX<AnimalHabits>(
                          value: value,
                          hintValue: AnimalHabits.none,
                          hint: localization.habit,
                          items: AnimalHabits.values
                              .map((habit) => DropdownMenuItem(
                                  value: habit,
                                  child: Text(
                                    habit.toLocalizedString(context),
                                  )))
                              .toList(),
                          onChanged: (value) => animalHabit.value = value!,
                        )),
                const Separator(),
                ValueListenableBuilder<Infertility>(
                    valueListenable: infertility,
                    builder: (context, value, _) => DropdownX<Infertility>(
                          value: value,
                          hintValue: Infertility.none,
                          hint: localization.infertility,
                          items: Infertility.values
                              .map((infertility) => DropdownMenuItem(
                                  value: infertility,
                                  child: Text(
                                    infertility.toLocalizedString(context),
                                  )))
                              .toList(),
                          onChanged: (value) => infertility.value = value!,
                        )),
                const Separator(),
                ValueListenableBuilder<ToiletTraining>(
                    valueListenable: toiletTraining,
                    builder: (context, value, _) => DropdownX<ToiletTraining>(
                          value: value,
                          hintValue: ToiletTraining.none,
                          hint: localization.toiletTraining,
                          items: ToiletTraining.values
                              .map((toiletTraining) => DropdownMenuItem(
                                  value: toiletTraining,
                                  child: Text(
                                    toiletTraining.toLocalizedString(context),
                                  )))
                              .toList(),
                          onChanged: (value) => toiletTraining.value = value!,
                        )),
                const Separator(),
                ValueListenableBuilder<Vaccine>(
                    valueListenable: vaccine,
                    builder: (context, value, _) => DropdownX<Vaccine>(
                          value: value,
                          hintValue: Vaccine.none,
                          hint: localization.vaccine,
                          items: Vaccine.values
                              .map((vaccine) => DropdownMenuItem(
                                  value: vaccine,
                                  child: Text(
                                    vaccine.toLocalizedString(context),
                                  )))
                              .toList(),
                          onChanged: (value) => vaccine.value = value!,
                        )),
              ],
            ),
          ),
          bottom(),
        ],
      ),
    );
  }

  bottom() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.padding, vertical: Dimens.paddingSmallX),
        child: Row(
          children: [
            Expanded(
                child: ButtonX(
                    borderRadius: Dimens.radiusSmall.toBorderRadius(),
                    padding: const EdgeInsets.all(Dimens.paddingSmall),
                    color: Colors.redAccent,
                    onTap: reset,
                    child: Text(
                      localization.reset,
                      style: TextStyle(color: theme.scaffoldBackgroundColor),
                    ))),
            const Separator(),
            Expanded(
                child: ButtonX(
                    borderRadius: Dimens.radiusSmall.toBorderRadius(),
                    padding: const EdgeInsets.all(Dimens.paddingSmall),
                    color: theme.colorScheme.secondary,
                    onTap: apply,
                    child: Text(
                      localization.apply,
                      style: TextStyle(color: theme.scaffoldBackgroundColor),
                    )))
          ],
        ),
      );

  void reset() => context.pop(result: const AdvertFilterModel());

  void apply() => context.pop(
      result: AdvertFilterModel(
          advertType: advertType.value,
          animalType: animalType.value,
          animalGender: animalGender.value,
          animalSize: animalSize.value,
          animalHabit: animalHabit.value,
          infertility: infertility.value,
          toiletTraining: toiletTraining.value,
          vaccine: vaccine.value));
}
