import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';

@optionalTypeArgs
abstract class ConsumerStateX<T extends ConsumerStatefulWidget> extends ConsumerState<T> {
  ThemeData get theme => context.theme;
  AppLocalizations get localization => context.localization;
  MediaQueryData get mediaQuery => context.mediaQuery;
}
