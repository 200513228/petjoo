// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_filter_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BlogFilterViewModel on BlogFilterViewModelBase, Store {
  late final _$typeAtom =
      Atom(name: 'BlogFilterViewModelBase.type', context: context);

  @override
  int? get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(int? value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  @override
  String toString() {
    return '''
type: ${type}
    ''';
  }
}
