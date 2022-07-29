import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {

  ThemeData get theme => Theme.of(this);
  AppLocalizations get localization => AppLocalizations.of(this)!;
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Future<R?> push<R>(Widget page, {bool root = false}) => Navigator.of(this, rootNavigator: root).push(MaterialPageRoute(builder: (context) => page));

  Future<R?> pushNamed<R>(String routeName, {Object? arguments, bool root = false}) =>
      Navigator.of(this, rootNavigator: root).pushNamed(routeName, arguments: arguments);

  Future<R?> pushReplacementNamed<R>(String routeName, {Object? result, Object? arguments, bool root = false}) =>
      Navigator.of(this, rootNavigator: root).pushReplacementNamed(routeName, arguments: arguments, result: result);

  E arguments<E>() => ModalRoute.of(this)!.settings.arguments as E;

  Future<R?> pushReplacement<R>(Widget page, {bool root = false}) =>
      Navigator.of(this, rootNavigator: root).pushReplacement(MaterialPageRoute(builder: (context) => page));

  Future<R?> pushNamedAndRemoveUntil<R>(String routeName, {RoutePredicate? predicate, Object? arguments, bool root = false}) =>
      Navigator.of(this, rootNavigator: root).pushNamedAndRemoveUntil<R>(routeName, predicate ?? (route) => route.isFirst, arguments: arguments);

  void popUntil({RoutePredicate? predicate, bool root = false}) =>
      Navigator.of(this, rootNavigator: root).popUntil(predicate ?? (route) => route.isFirst);

  void pop<R>({bool root = false, R? result}) => Navigator.of(this, rootNavigator: root).pop(result);

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(String content, {Duration? duration}) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(content), duration: duration ?? const Duration(seconds: 1)));
}
