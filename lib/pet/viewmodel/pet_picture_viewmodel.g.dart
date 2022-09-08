// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_picture_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PetPictureViewModel on PetPictureViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'PetPictureViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$advertAtom =
      Atom(name: 'PetPictureViewModelBase.advert', context: context);

  @override
  PetAdvertModel? get advert {
    _$advertAtom.reportRead();
    return super.advert;
  }

  @override
  set advert(PetAdvertModel? value) {
    _$advertAtom.reportWrite(value, super.advert, () {
      super.advert = value;
    });
  }

  late final _$imageListAtom =
      Atom(name: 'PetPictureViewModelBase.imageList', context: context);

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
      AsyncAction('PetPictureViewModelBase.imagePick', context: context);

  @override
  Future<dynamic> imagePick() {
    return _$imagePickAsyncAction.run(() => super.imagePick());
  }

  late final _$setAdvertAsyncAction =
      AsyncAction('PetPictureViewModelBase.setAdvert', context: context);

  @override
  Future<dynamic> setAdvert(PetAdvertModel model) {
    return _$setAdvertAsyncAction.run(() => super.setAdvert(model));
  }

  late final _$downloadFileAsyncAction =
      AsyncAction('PetPictureViewModelBase.downloadFile', context: context);

  @override
  Future<File?> downloadFile(String url) {
    return _$downloadFileAsyncAction.run(() => super.downloadFile(url));
  }

  late final _$saveAdvertAsyncAction =
      AsyncAction('PetPictureViewModelBase.saveAdvert', context: context);

  @override
  Future<dynamic> saveAdvert(BuildContext _) {
    return _$saveAdvertAsyncAction.run(() => super.saveAdvert(_));
  }

  late final _$updateAdvertAsyncAction =
      AsyncAction('PetPictureViewModelBase.updateAdvert', context: context);

  @override
  Future<dynamic> updateAdvert(BuildContext _) {
    return _$updateAdvertAsyncAction.run(() => super.updateAdvert(_));
  }

  late final _$PetPictureViewModelBaseActionController =
      ActionController(name: 'PetPictureViewModelBase', context: context);

  @override
  void imageDelete(File e) {
    final _$actionInfo = _$PetPictureViewModelBaseActionController.startAction(
        name: 'PetPictureViewModelBase.imageDelete');
    try {
      return super.imageDelete(e);
    } finally {
      _$PetPictureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void error(BuildContext _) {
    final _$actionInfo = _$PetPictureViewModelBaseActionController.startAction(
        name: 'PetPictureViewModelBase.error');
    try {
      return super.error(_);
    } finally {
      _$PetPictureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void successfull(BuildContext context) {
    final _$actionInfo = _$PetPictureViewModelBaseActionController.startAction(
        name: 'PetPictureViewModelBase.successfull');
    try {
      return super.successfull(context);
    } finally {
      _$PetPictureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
advert: ${advert},
imageList: ${imageList}
    ''';
  }
}
