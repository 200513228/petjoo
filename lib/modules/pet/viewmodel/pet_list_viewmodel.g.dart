// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PetListViewModel on PetListViewModelBase, Store {
  late final _$advertListAtom =
      Atom(name: 'PetListViewModelBase.advertList', context: context);

  @override
  List<PetAdvertModel> get advertList {
    _$advertListAtom.reportRead();
    return super.advertList;
  }

  @override
  set advertList(List<PetAdvertModel> value) {
    _$advertListAtom.reportWrite(value, super.advertList, () {
      super.advertList = value;
    });
  }

  late final _$getAdvertsAsyncAction =
      AsyncAction('PetListViewModelBase.getAdverts', context: context);

  @override
  Future<dynamic> getAdverts() {
    return _$getAdvertsAsyncAction.run(() => super.getAdverts());
  }

  late final _$PetListViewModelBaseActionController =
      ActionController(name: 'PetListViewModelBase', context: context);

  @override
  void pickAdvert(PetAdvertModel model, BuildContext _) {
    final _$actionInfo = _$PetListViewModelBaseActionController.startAction(
        name: 'PetListViewModelBase.pickAdvert');
    try {
      return super.pickAdvert(model, _);
    } finally {
      _$PetListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
advertList: ${advertList}
    ''';
  }
}
