import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/modules/base/color_palette.dart';
import 'package:petjoo/modules/base/please_auth.dart';
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
import 'package:petjoo/modules/base/images.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PetDetailView extends StatelessWidget {
  final PetDetailViewModel vm = PetDetailViewModel();
  final PetAdvertModel model;
  PetDetailView({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.setModel(model);
    vm.userInfo(model.userId);
    return Scaffold(
      appBar: buildAppBar(context),
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
        const SizedBox(height: 10),
        advertAdress,
        Row(
          children: [
            Expanded(
              child: advertInfoCard(
                  petAdvertAnimals[model.animalType] as String,
                  animalTypeToIcon(model.animalType),
                  Colors.orangeAccent,
                  'type'.tr()),
            ),
            Expanded(
              child: advertInfoCard(
                  petAdvertGenders[model.animalGender] as String,
                  genderToIcon(model.animalGender),
                  genderToColor(model.animalGender),
                  'gender'.tr()),
            ),
            Expanded(
              child: advertInfoCard(petAdvertSizes[model.animalSize] as String,
                  Icons.scale_rounded, Colors.cyanAccent, 'size'.tr()),
            ),
            Expanded(
              child: advertInfoCard(model.animalAge, Icons.cake_rounded,
                  Colors.yellowAccent, 'age'.tr()),
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
                  'habit'.tr()),
            ),
            Expanded(
              child: advertInfoCard(
                  petAdvertInfertilities[model.infertility] as String,
                  FontAwesomeIcons.neuter,
                  Colors.deepOrangeAccent,
                  'infertility'.tr()),
            ),
            Expanded(
              child: advertInfoCard(
                  petAdvertToilets[model.toiletTraining] as String,
                  FontAwesomeIcons.toilet,
                  Colors.greenAccent,
                  'toilet'.tr()),
            ),
            Expanded(
              child: advertInfoCard(petAdvertVaccines[model.vaccine] as String,
                  Icons.vaccines_rounded, Colors.purpleAccent, 'vaccine'.tr()),
            ),
          ],
        ),
        advertDesc,
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
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'description'.tr(),
                style: const TextStyle(fontSize: 15, color: Colors.white54),
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'address'.tr(),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white54),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              model.address,
                              maxLines: 5,
                              style: const TextStyle(fontSize: 16),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.location_on),
                          Text('Harita'),
                        ],
                      ),
                    ),
                  ),
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
                          model.isAdopted ? 'readopt'.tr() : 'adopted'.tr(),
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () async {
                          if (!model.isAdopted) {
                            await showDialog(
                                context: _,
                                builder: (context) => AlertDialog(
                                      title: Text('adoption_form'.tr()),
                                      content: Text('content_form'.tr()),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              launchUrlString(
                                                'https://firebasestorage.googleapis.com/v0/b/petjoo-129db.appspot.com/o/docs%2Fsahiplendirme%20formu.docx?alt=media&token=0d6d5ff7-812f-4274-beb9-75bf26f86b43',
                                                mode: LaunchMode
                                                    .externalApplication,
                                              );
                                            },
                                            child: Text('download_form'.tr())),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('close'.tr())),
                                      ],
                                    )).then(
                                (value) => vm.changeAdopt(!model.isAdopted, _));
                          } else {
                            vm.changeAdopt(!model.isAdopted, _);
                          }
                        },
                      ),
                    ),
                  if (vm.advert!.userId != CurrentUser.id)
                    Expanded(
                      child: FloatingActionButton.extended(
                        heroTag: null,
                        backgroundColor: Colors.black,
                        label: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            image(),
                            const SizedBox(width: 5),
                            Text(
                              vm.userName ?? 'user_not_found'.tr(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ],
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
                              : model.phone == ''
                                  ? null
                                  : vm.call();
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
                              : vm.userName == null
                                  ? null
                                  : vm.message(_);
                        },
                        child: Icon(
                          Icons.message_rounded,
                          color: vm.userName == null
                              ? Colors.grey
                              : Colors.orangeAccent,
                        ))
                  ],
          ],
        ),
      );
    });
  }

  Widget image() {
    return Container(
      width: 35,
      height: 35,
      decoration: const BoxDecoration(
          color: Colors.yellowAccent,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: vm.userImage == ''
            ? Image.asset(Images.noImage)
            : Image.network(
                vm.userImage,
                fit: BoxFit.cover,
              ),
      ),
    );
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
      child: Row(
        children: [
          Expanded(
            child: Text(
              model.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
                color: colorPalette['secondary'],
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Text(
              '${petAdvertTypes[model.type]}',
              maxLines: 1,
              style: TextStyle(fontSize: 16, color: typeToColor(model.type)),
            ),
          ),
        ],
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
              backgroundColor: Colors.black,
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.clear_rounded,
                    color: Colors.white,
                  )),
            ),
            backgroundColor: Colors.black,
            body: PageView(
              children: [
                if (model.images.isEmpty) Image.asset(Images.noImage),
                ...model.images.map((e) => GestureDetector(
                      child: Image.network(e),
                    )),
              ],
            )));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      centerTitle: true,
      title: Text('advert_details'.tr()),
      actions: [
        PopupMenuButton(
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            color: Colors.black,
            itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () => vm.publish(context),
                    child: Text(
                      'publish'.tr(),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: null,
                    child: Text(
                      'report'.tr(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ])
      ],
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
