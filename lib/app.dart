import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/modules/home/view/welcome_view.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/ui/themes/classic_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'main.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) =>
      Consumer(builder: (context, ref, child) {
        final provider = ref.watch(settingsProvider);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Petjoo',
          themeMode: provider.themeMode,
          theme: ClassicTheme.light,
          locale: provider.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const WelcomeView(),
          // initialRoute: FirebaseAuth.instance.currentUser == null
          //     ? Routes.auth
          //     : Routes.navigation,
          onGenerateRoute: Routes.onGenerateRoute,
        );
      });
}
