class PetFilterModel {
  int advertType = 0;
  int animalType = 0;
  int animalGender = 0;
  int animalHabit = 0;
  int animalSize = 0;
  int vaccine = 0;
  int infertility = 0;
  int toiletTraining = 0;

  PetFilterModel.filter({
    required this.advertType,
    required this.animalType,
    required this.animalSize,
    required this.animalGender,
    required this.animalHabit,
    required this.vaccine,
    required this.infertility,
    required this.toiletTraining,
  });
}
