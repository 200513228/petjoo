import '../../domain/enums/advert/advert_type.dart';
import '../../domain/enums/advert/animal_gender.dart';
import '../../domain/enums/advert/animal_habits.dart';
import '../../domain/enums/advert/animal_size.dart';
import '../../domain/enums/advert/animals.dart';
import '../../domain/enums/advert/infertility.dart';
import '../../domain/enums/advert/toilet_training.dart';
import '../../domain/enums/advert/vaccine.dart';

class AdvertFilterModel {
  final AdvertType advertType;
  final Animals animalType;
  final AnimalGender animalGender;
  final AnimalSize animalSize;
  final AnimalHabits animalHabit;
  final Infertility infertility;
  final ToiletTraining toiletTraining;
  final Vaccine vaccine;

  const AdvertFilterModel(
      {this.advertType = AdvertType.none,
      this.animalType = Animals.none,
      this.animalGender = AnimalGender.none,
      this.animalSize = AnimalSize.none,
      this.animalHabit = AnimalHabits.none,
      this.infertility = Infertility.none,
      this.toiletTraining = ToiletTraining.none,
      this.vaccine = Vaccine.none});
}
