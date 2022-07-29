import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/enums/languages.dart';

class SettingsProvider with ChangeNotifier {
  static late final Box<dynamic> _box;

  ThemeMode get themeMode => ThemeMode.values[_box.get("theme_mode", defaultValue: 0)];
  Languages get language => Languages.values[_box.get("language", defaultValue: 0)];


  Locale? get locale {
    switch (language) {
      case Languages.english:
        return const Locale('en');
      case Languages.german:
        return const Locale('de');
      case Languages.turkish:
        return const Locale('tr');
      default:
        return null;
    }
  }

  static Future<void> init() async => _box = await Hive.openBox("settings");

  void changeThemeMode(ThemeMode? mode) => _update("theme_mode", mode!.index);

  void changeLanguage(Languages? language) => _update("language", language!.index);

  void _update(String key, dynamic value) {
    _box.put(key, value);
    notifyListeners();
  }

  void clear() => _box.clear();
}
