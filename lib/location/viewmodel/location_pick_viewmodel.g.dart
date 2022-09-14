// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_pick_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocationPickViewModel on LocationPickViewModelBase, Store {
  late final _$locAtom =
      Atom(name: 'LocationPickViewModelBase.loc', context: context);

  @override
  GeoPoint get loc {
    _$locAtom.reportRead();
    return super.loc;
  }

  @override
  set loc(GeoPoint value) {
    _$locAtom.reportWrite(value, super.loc, () {
      super.loc = value;
    });
  }

  late final _$camPosAtom =
      Atom(name: 'LocationPickViewModelBase.camPos', context: context);

  @override
  CameraPosition get camPos {
    _$camPosAtom.reportRead();
    return super.camPos;
  }

  @override
  set camPos(CameraPosition value) {
    _$camPosAtom.reportWrite(value, super.camPos, () {
      super.camPos = value;
    });
  }

  late final _$LocationPickViewModelBaseActionController =
      ActionController(name: 'LocationPickViewModelBase', context: context);

  @override
  dynamic onCameraMove(dynamic xcamPos) {
    final _$actionInfo = _$LocationPickViewModelBaseActionController
        .startAction(name: 'LocationPickViewModelBase.onCameraMove');
    try {
      return super.onCameraMove(xcamPos);
    } finally {
      _$LocationPickViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onSave(BuildContext context) {
    final _$actionInfo = _$LocationPickViewModelBaseActionController
        .startAction(name: 'LocationPickViewModelBase.onSave');
    try {
      return super.onSave(context);
    } finally {
      _$LocationPickViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loc: ${loc},
camPos: ${camPos}
    ''';
  }
}
