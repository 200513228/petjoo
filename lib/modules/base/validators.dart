import 'package:petjoo/modules/base/string_converters.dart';

typedef ValidatorFunc = String? Function(String?);

class Validators {
  static ValidatorFunc email(String? error) =>
      (String? value) => value == null ||
              value.isEmpty ||
              !value.contains('@') ||
              value.split('@').length > 2
          ? error
          : null;

  static ValidatorFunc password(String? error) =>
      (String? value) => value == null || value.length < 6 ? error : null;

  static ValidatorFunc title(String? error) =>
      (String? value) => value == null || value.length < 3 ? error : null;

  static ValidatorFunc description(String? error) =>
      (String? value) => value == null || value.length < 4 ? error : null;

  static ValidatorFunc phone(String? error, [bool canBeEmpty = false]) =>
      (String? value) => ((value?.isEmpty == true && canBeEmpty)
              ? false
              : (value?.length != 10 || value?.isNumeric() == false))
          ? error
          : null;

  static ValidatorFunc number(String? error, [bool canBeEmpty = false]) =>
      (String? value) => ((value?.isEmpty == true && canBeEmpty)
              ? false
              : (value?.isNumeric() == false))
          ? error
          : null;
}
