import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/domain/enums/advert/advert_type.dart';
import 'package:petjoo/domain/enums/advert/animal_gender.dart';
import 'package:petjoo/domain/enums/advert/animal_habits.dart';
import 'package:petjoo/domain/enums/advert/animal_size.dart';
import 'package:petjoo/domain/enums/advert/animals.dart';
import 'package:petjoo/domain/enums/advert/infertility.dart';
import 'package:petjoo/domain/enums/advert/toilet_training.dart';
import 'package:petjoo/domain/enums/advert/vaccine.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/models/user_model.dart';
import 'package:petjoo/product/ui/dialogs/info_dialog.dart';

class AdvertInputViewModel extends PageNotifier {
  AdvertInputViewModel(BuildContext context, this.data, UserModel user) : super(context) {
    data.dialCode = user.dialCode;
    data.phone = user.phone;
  }
  final AdvertModel data;

  GlobalKey<FormState> formKey = GlobalKey();

  late final TextEditingController titleController = TextEditingController(text: data.title);
  late final TextEditingController descriptionController = TextEditingController(text: data.description);
  late final TextEditingController phoneController = TextEditingController(text: data.phone);
  late final TextEditingController ageController = TextEditingController(text: data.animalAge);
  late final ValueNotifier<AdvertType> status = ValueNotifier(data.type);
  late final ValueNotifier<Animals> animalType = ValueNotifier(data.animalType);
  late final ValueNotifier<AnimalGender> animalGender = ValueNotifier(data.animalGender);
  late final ValueNotifier<AnimalSize> animalSize = ValueNotifier(data.animalSize);
  late final ValueNotifier<AnimalHabits> animalHabit = ValueNotifier(data.animalHabit);
  late final ValueNotifier<Infertility> infertility = ValueNotifier(data.infertility);
  late final ValueNotifier<ToiletTraining> toiletTraining = ValueNotifier(data.toiletTraining);
  late final ValueNotifier<Vaccine> vaccine = ValueNotifier(data.vaccine);
  late final ValueNotifier<String> dialCode = ValueNotifier(data.dialCode);

  bool get isEdit => data.id != null;

  List<String> forbiddenWord = [
    "sati",
    "satı",
    "ucret",
    "ücret",
    "ass",
  ];

  void save() async {
    if (!formKey.currentState!.validate()) return;
    data.title = titleController.text;
    data.description = descriptionController.text;
    data.dialCode = dialCode.value;
    data.phone = phoneController.text;
    data.animalAge = ageController.text;
    data.type = status.value;
    data.animalType = animalType.value;
    data.animalGender = animalGender.value;
    data.animalSize = animalSize.value;
    data.animalHabit = animalHabit.value;
    data.infertility = infertility.value;
    data.toiletTraining = toiletTraining.value;
    data.vaccine = vaccine.value;

    bool isForbidden = false;
    for (String word in forbiddenWord) {
      if (data.description.toLowerCase().contains(word)) {
        !isForbidden ? isForbidden = true : null;
      }
    }

    isForbidden
        ? showDialog(
            context: context,
            builder: (context) => InfoDialog(
                  title: context.localization.information,
                  description: context.localization.postWillBeRemoved,
                )).then((value) => context.pushNamed(Routes.advertMapInput, arguments: data))
        : context.pushNamed(Routes.advertMapInput, arguments: data);
  }
}
