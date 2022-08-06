// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_picture_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StorePictureViewModel on StorePictureViewModelBase, Store {
  late final _$advertAtom =
      Atom(name: 'StorePictureViewModelBase.advert', context: context);

  @override
  StoreAdvertModel? get advert {
    _$advertAtom.reportRead();
    return super.advert;
  }

  @override
  set advert(StoreAdvertModel? value) {
    _$advertAtom.reportWrite(value, super.advert, () {
      super.advert = value;
    });
  }

  late final _$imageListAtom =
      Atom(name: 'StorePictureViewModelBase.imageList', context: context);

  @override
  List<File> get imageList {
    _$imageListAtom.reportRead();
    return super.imageList;
  }

  @override
  set imageList(List<File> value) {
    _$imageListAtom.reportWrite(value, super.imageList, () {
      super.imageList = value;
    });
  }

  late final _$imagePickAsyncAction =
      AsyncAction('StorePictureViewModelBase.imagePick', context: context);

  @override
  Future<dynamic> imagePick() {
    return _$imagePickAsyncAction.run(() => super.imagePick());
  }

  late final _$saveAdvertAsyncAction =
      AsyncAction('StorePictureViewModelBase.saveAdvert', context: context);

  @override
  Future<dynamic> saveAdvert(BuildContext _) {
    return _$saveAdvertAsyncAction.run(() => super.saveAdvert(_));
  }

  late final _$StorePictureViewModelBaseActionController =
      ActionController(name: 'StorePictureViewModelBase', context: context);

  @override
  void setAdvert(StoreAdvertModel model) {
    final _$actionInfo = _$StorePictureViewModelBaseActionController
        .startAction(name: 'StorePictureViewModelBase.setAdvert');
    try {
      return super.setAdvert(model);
    } finally {
      _$StorePictureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void error(BuildContext _) {
    final _$actionInfo = _$StorePictureViewModelBaseActionController
        .startAction(name: 'StorePictureViewModelBase.error');
    try {
      return super.error(_);
    } finally {
      _$StorePictureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void successfull(BuildContext context) {
    final _$actionInfo = _$StorePictureViewModelBaseActionController
        .startAction(name: 'StorePictureViewModelBase.successfull');
    try {
      return super.successfull(context);
    } finally {
      _$StorePictureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
advert: ${advert},
imageList: ${imageList}
    ''';
  }
}
