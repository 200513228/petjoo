import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/modules/base/color_palette.dart';
import 'package:petjoo/modules/base/please_auth.dart';
import 'package:petjoo/modules/base/string_converters.dart';
import 'package:petjoo/modules/pet/model/pet_advert_animals.dart';
import 'package:petjoo/modules/pet/model/pet_advert_genders.dart';
import 'package:petjoo/modules/pet/model/pet_advert_habits.dart';
import 'package:petjoo/modules/pet/model/pet_advert_infertilities.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
import 'package:petjoo/modules/pet/model/pet_advert_sizes.dart';
import 'package:petjoo/modules/pet/model/pet_advert_toilets.dart';
import 'package:petjoo/modules/pet/model/pet_advert_types.dart';
import 'package:petjoo/modules/pet/model/pet_advert_vaccines.dart';
import 'package:petjoo/modules/pet/viewmodel/pet_detail_viewmodel.dart';
import 'package:petjoo/modules/user/model/current_user.dart';
import 'package:petjoo/product/constants/images.dart';

class PetDetailView extends StatelessWidget {
  final PetDetailViewModel vm = PetDetailViewModel();
  final PetAdvertModel model;
  PetDetailView({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.setModel(model);
    vm.userInfo(model.userId);
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(context),
      backgroundColor: colorPalette['primary'],
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(flex: 3, child: gallery(context)),
              Expanded(
                flex: 7,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: colorPalette['secondary'],
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        title(),
                        advertInfo,
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomBar(context)
      ],
    );
  }

  Widget get advertInfo {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: advertInfoCard(
                  petAdvertAnimals[model.animalType] as String,
                  animalTypeToIcon(model.animalType),
                  Colors.orangeAccent,
                  'Tür'),
            ),
            Expanded(
              child: advertInfoCard(
                  petAdvertGenders[model.animalGender] as String,
                  genderToIcon(model.animalGender),
                  genderToColor(model.animalGender),
                  'Cins'),
            ),
            Expanded(
              child: advertInfoCard(petAdvertSizes[model.animalSize] as String,
                  Icons.scale_rounded, Colors.cyanAccent, 'Boyut'),
            ),
            Expanded(
              child: advertInfoCard(model.animalAge, Icons.cake_rounded,
                  Colors.yellowAccent, 'Yaş'),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: advertInfoCard(
                  petAdvertHabits[model.animalHabit] as String,
                  Icons.heart_broken_rounded,
                  Colors.pinkAccent,
                  'Huy'),
            ),
            Expanded(
              child: advertInfoCard(
                  petAdvertInfertilities[model.infertility] as String,
                  FontAwesomeIcons.neuter,
                  Colors.deepOrangeAccent,
                  'Kısırlık'),
            ),
            Expanded(
              child: advertInfoCard(
                  petAdvertToilets[model.animalSize] as String,
                  FontAwesomeIcons.toilet,
                  Colors.greenAccent,
                  'Tuvalet Eğt.'),
            ),
            Expanded(
              child: advertInfoCard(petAdvertVaccines[model.vaccine] as String,
                  Icons.vaccines_rounded, Colors.purpleAccent, 'Aşı'),
            ),
          ],
        ),
        advertDesc,
        advertAdress,
      ],
    );
  }

  Widget advertInfoCard(String text, IconData icon, Color color, String title) {
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
              style: const TextStyle(fontSize: 11, color: Colors.white54)),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(icon, size: 20, color: color),
          ),
          Text(text, maxLines: 1, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget get advertDesc {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.black),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Açıklama',
                style: TextStyle(fontSize: 15, color: Colors.white54),
              ),
            ),
            const SizedBox(height: 5),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  model.description,
                  style: const TextStyle(fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }

  Widget get advertAdress {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.black),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Adres',
                      style: TextStyle(fontSize: 15, color: Colors.white54),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        model.address,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 16),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.black),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      dateToString(model.date),
                      style:
                          const TextStyle(fontSize: 15, color: Colors.white54),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${petAdvertTypes[model.type]}',
                        style: TextStyle(
                            fontSize: 16, color: typeToColor(model.type)),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomBar(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xff202020),
          border: Border(
            top: BorderSide(width: .5, color: Colors.white),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: bottomContent(context));
  }

  Widget bottomContent(BuildContext _) {
    return Observer(builder: (_) {
      return SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  if (vm.advert!.userId == CurrentUser.id)
                    Expanded(
                      child: FloatingActionButton.extended(
                        heroTag: null,
                        backgroundColor: Colors.grey.shade800,
                        label: Text(
                          model.isAdopted
                              ? 'Sahiplendirme Formu'
                              : 'Sahiplendirildi Mi?',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22),
                        ),
                        onPressed: () {
                          if (!model.isAdopted) {
                            vm.changeAdopt(!model.isAdopted, _);
                          } else {}
                        },
                      ),
                    ),
                  if (vm.advert!.userId != CurrentUser.id)
                    Expanded(
                      child: FloatingActionButton.extended(
                        heroTag: null,
                        backgroundColor: Colors.black,
                        label: Text(
                          vm.userName ?? 'Kullanıcı Bulunamadı',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        onPressed: null,
                      ),
                    ),
                ],
              ),
            ),
            ...CurrentUser.id == model.userId
                ? [
                    const SizedBox(width: 10),
                    FloatingActionButton(
                        elevation: 0,
                        onPressed: () => vm.delete(_),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        )),
                    const SizedBox(width: 10),
                    FloatingActionButton(
                        heroTag: null,
                        onPressed: () => vm.editModel(model, _),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.orangeAccent,
                        ))
                  ]
                : [
                    const SizedBox(width: 10),
                    FloatingActionButton(
                        elevation: model.phone == '' ? 0 : null,
                        onPressed: () {
                          CurrentUser.id == ''
                              ? showDialog(
                                  context: _,
                                  builder: (context) => const PleaseAuth())
                              : null;
                          model.phone == '' ? null : vm.call();
                        },
                        child: Icon(
                          Icons.call_rounded,
                          color: model.phone == ''
                              ? Colors.grey
                              : Colors.greenAccent,
                        )),
                    const SizedBox(width: 10),
                    FloatingActionButton(
                        heroTag: null,
                        onPressed: () {
                          CurrentUser.id == ''
                              ? showDialog(
                                  context: _,
                                  builder: (context) => const PleaseAuth())
                              : null;
                          model.phone == '' ? null : vm.message(_);
                        },
                        child: const Icon(
                          Icons.message_rounded,
                          color: Colors.orangeAccent,
                        ))
                  ],
          ],
        ),
      );
    });
  }

  Widget title() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: colorPalette['primary'],
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(15))),
      child: Text(
        model.title,
        style: const TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget gallery(BuildContext context) {
    return Stack(
      children: [
        PageView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            if (model.images.isEmpty) Image.asset(Images.noImage),
            ...model.images.map(
              (e) => GestureDetector(
                onTap: () => fullScreen(context),
                child: Image.network(e, fit: BoxFit.fitWidth),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void fullScreen(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.yellow.shade600,
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.clear_rounded)),
            ),
            backgroundColor: Colors.transparent,
            body: PageView(
              children: [
                if (model.images.isEmpty) Image.asset(Images.noImage),
                ...model.images.map((e) => GestureDetector(
                      child: Image.network(e),
                    )),
              ],
            )));
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('İlan Detayları'),
    );
  }

  Color typeToColor(int type) {
    switch (type) {
      case 0:
        return Colors.orangeAccent;
      case 1:
        return Colors.redAccent;
      case 2:
        return Colors.redAccent;
      case 3:
        return Colors.blueAccent;
      case 4:
        return Colors.greenAccent;
      case 5:
        return Colors.orangeAccent;
      case 6:
        return Colors.orangeAccent;
      case 7:
        return Colors.blueAccent;
      default:
        return Colors.orangeAccent;
    }
  }

  Color genderToColor(int type) {
    switch (type) {
      case 0:
        return Colors.greenAccent;
      case 1:
        return Colors.blueAccent;
      case 2:
        return Colors.pinkAccent;
      default:
        return Colors.greenAccent;
    }
  }

  IconData genderToIcon(int status) {
    switch (status) {
      case 0:
        return Icons.question_mark;
      case 1:
        return Icons.male_rounded;
      case 2:
        return Icons.female_rounded;
      default:
        return Icons.male_rounded;
    }
  }

  IconData animalTypeToIcon(int status) {
    switch (status) {
      case 0:
        return Icons.more_horiz_rounded;
      case 1:
        return Icons.more_horiz_rounded;
      case 2:
        return FontAwesomeIcons.dog;
      case 3:
        return FontAwesomeIcons.cat;
      case 4:
        return FontAwesomeIcons.kiwiBird;
      case 5:
        return FontAwesomeIcons.fish;
      case 6:
        return FontAwesomeIcons.bug;
      default:
        return Icons.more_horiz_rounded;
    }
  }
}
