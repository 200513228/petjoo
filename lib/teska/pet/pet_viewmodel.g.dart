// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PetViewModel on PetViewModelBase, Store {
  late final _$advertsAtom =
      Atom(name: 'PetViewModelBase.adverts', context: context);

  @override
  List<PetAdvertModel> get adverts {
    _$advertsAtom.reportRead();
    return super.adverts;
  }

  @override
  set adverts(List<PetAdvertModel> value) {
    _$advertsAtom.reportWrite(value, super.adverts, () {
      super.adverts = value;
    });
  }

  late final _$getAdvertsAsyncAction =
      AsyncAction('PetViewModelBase.getAdverts', context: context);

  @override
  Future<dynamic> getAdverts() {
    return _$getAdvertsAsyncAction.run(() => super.getAdverts());
  }

  @override
  String toString() {
    return '''
adverts: ${adverts}
    ''';
  }
}
