import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';

class ClassicTheme {
  static ThemeData myTheme() {
    const colorScheme = ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xfffaee4a),
        onPrimary: Colors.black87,
        secondary: Color(0xff121212),
        onSecondary: Color(0xffffffff),
        error: Colors.red,
        onError: Colors.black,
        background: Color(0xfffaee4a),
        onBackground: Colors.black87,
        surface: Color(0xff202020),
        onSurface: Color(0xffffffff));
    return ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.primary,
        dividerColor: colorScheme.onSurface,
        toggleableActiveColor: colorScheme.primary.withOpacity(.7),
        unselectedWidgetColor: colorScheme.onSurface,
        iconTheme: IconThemeData(color: colorScheme.onSurface.withOpacity(.7)),
        textTheme: _textTheme(colorScheme),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle:
              OverlayStyles.toAll(colorScheme.background, Brightness.dark),
          iconTheme: const IconThemeData(color: Colors.black),
          actionsIconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onBackground),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: colorScheme.primary,
            backgroundColor: colorScheme.surface,
            showSelectedLabels: false,
            showUnselectedLabels: false),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: colorScheme.onBackground,
            foregroundColor: colorScheme.onSurface),
        drawerTheme: DrawerThemeData(backgroundColor: colorScheme.onBackground),
        snackBarTheme: SnackBarThemeData(
            backgroundColor: colorScheme.surface,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: Dimens.radiusSmall.toBorderRadius())),
        dialogTheme: DialogTheme(
            backgroundColor: colorScheme.surface,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: colorScheme.onSurface),
            contentTextStyle: TextStyle(color: colorScheme.onSurface),
            shape: RoundedRectangleBorder(
                borderRadius: Dimens.radius.toBorderRadius())),
        listTileTheme: ListTileThemeData(
            tileColor: colorScheme.surface,
            style: ListTileStyle.drawer,
            contentPadding: const EdgeInsets.all(Dimens.paddingSmall),
            shape: RoundedRectangleBorder(
                borderRadius: Dimens.radiusSmall.toBorderRadius())),
        inputDecorationTheme: InputDecorationTheme(
            errorMaxLines: 1,
            labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(.8)),
            hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(.8)),
            filled: true,
            fillColor: colorScheme.surface,
            border: _inputBorder,
            focusedBorder: _inputBorder,
            errorBorder: _inputBorder,
            focusedErrorBorder: _inputBorder));
  }

  static InputBorder get _inputBorder => UnderlineInputBorder(
      borderRadius: Dimens.radiusSmall.toBorderRadius(),
      borderSide: const BorderSide(color: Colors.transparent));

  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
      button: TextStyle(color: colorScheme.onSurface),
      subtitle1: TextStyle(color: colorScheme.onSurface),
      bodyText1: TextStyle(color: colorScheme.onSurface, fontSize: 14),
      bodyText2: TextStyle(color: colorScheme.onSurface, fontSize: 12),
      caption: TextStyle(color: colorScheme.onSurface.withOpacity(.8)));
}
