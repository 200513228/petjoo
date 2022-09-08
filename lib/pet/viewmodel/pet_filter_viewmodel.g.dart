// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_filter_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PetFilterViewModel on PetFilterViewModelBase, Store {
  late final _$advertTypeAtom =
      Atom(name: 'PetFilterViewModelBase.advertType', context: context);

  @override
  int? get advertType {
    _$advertTypeAtom.reportRead();
    return super.advertType;
  }

  @override
  set advertType(int? value) {
    _$advertTypeAtom.reportWrite(value, super.advertType, () {
      super.advertType = value;
    });
  }

  late final _$animalTypeAtom =
      Atom(name: 'PetFilterViewModelBase.animalType', context: context);

  @override
  int? get animalType {
    _$animalTypeAtom.reportRead();
    return super.animalType;
  }

  @override
  set animalType(int? value) {
    _$animalTypeAtom.reportWrite(value, super.animalType, () {
      super.animalType = value;
    });
  }

  late final _$animalGenderAtom =
      Atom(name: 'PetFilterViewModelBase.animalGender', context: context);

  @override
  int? get animalGender {
    _$animalGenderAtom.reportRead();
    return super.animalGender;
  }

  @override
  set animalGender(int? value) {
    _$animalGenderAtom.reportWrite(value, super.animalGender, () {
      super.animalGender = value;
    });
  }

  late final _$animalHabitAtom =
      Atom(name: 'PetFilterViewModelBase.animalHabit', context: context);

  @override
  int? get animalHabit {
    _$animalHabitAtom.reportRead();
    return super.animalHabit;
  }

  @override
  set animalHabit(int? value) {
    _$animalHabitAtom.reportWrite(value, super.animalHabit, () {
      super.animalHabit = value;
    });
  }

  late final _$animalSizeAtom =
      Atom(name: 'PetFilterViewModelBase.animalSize', context: context);

  @override
  int? get animalSize {
    _$animalSizeAtom.reportRead();
    return super.animalSize;
  }

  @override
  set animalSize(int? value) {
    _$animalSizeAtom.reportWrite(value, super.animalSize, () {
      super.animalSize = value;
    });
  }

  late final _$vaccineAtom =
      Atom(name: 'PetFilterViewModelBase.vaccine', context: context);

  @override
  int? get vaccine {
    _$vaccineAtom.reportRead();
    return super.vaccine;
  }

  @override
  set vaccine(int? value) {
    _$vaccineAtom.reportWrite(value, super.vaccine, () {
      super.vaccine = value;
    });
  }

  late final _$infertilityAtom =
      Atom(name: 'PetFilterViewModelBase.infertility', context: context);

  @override
  int? get infertility {
    _$infertilityAtom.reportRead();
    return super.infertility;
  }

  @override
  set infertility(int? value) {
    _$infertilityAtom.reportWrite(value, super.infertility, () {
      super.infertility = value;
    });
  }

  late final _$toiletAtom =
      Atom(name: 'PetFilterViewModelBase.toilet', context: context);

  @override
  int? get toilet {
    _$toiletAtom.reportRead();
    return super.toilet;
  }

  @override
  set toilet(int? value) {
    _$toiletAtom.reportWrite(value, super.toilet, () {
      super.toilet = value;
    });
  }

  late final _$PetFilterViewModelBaseActionController =
      ActionController(name: 'PetFilterViewModelBase', context: context);

  @override
  void resetFilter(BuildContext context) {
    final _$actionInfo = _$PetFilterViewModelBaseActionController.startAction(
        name: 'PetFilterViewModelBase.resetFilter');
    try {
      return super.resetFilter(context);
    } finally {
      _$PetFilterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilter(BuildContext context) {
    final _$actionInfo = _$PetFilterViewModelBaseActionController.startAction(
        name: 'PetFilterViewModelBase.setFilter');
    try {
      return super.setFilter(context);
    } finally {
      _$PetFilterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrent() {
    final _$actionInfo = _$PetFilterViewModelBaseActionController.startAction(
        name: 'PetFilterViewModelBase.setCurrent');
    try {
      return super.setCurrent();
    } finally {
      _$PetFilterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
advertType: ${advertType},
animalType: ${animalType},
animalGender: ${animalGender},
animalHabit: ${animalHabit},
animalSize: ${animalSize},
vaccine: ${vaccine},
infertility: ${infertility},
toilet: ${toilet}
    ''';
  }
}
