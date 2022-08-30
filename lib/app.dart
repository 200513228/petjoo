import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/modules/home/view/welcome_view.dart';
import 'package:petjoo/product/ui/themes/classic_theme.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    // return Consumer(builder: (context, ref, child) {
    //     final provider = ref.watch(settingsProvider);
    //     return MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       title: 'Petjoo',
    //       themeMode: provider.themeMode,
    //       theme: ClassicTheme.myTheme(),
    //       locale: provider.locale,
    //       supportedLocales: AppLocalizations.supportedLocales,
    //       localizationsDelegates: AppLocalizations.localizationsDelegates,
    //       home: WelcomeView(),
    //       // initialRoute: FirebaseAuth.instance.currentUser == null
    //       //     ? Routes.auth
    //       //     : Routes.navigation,
    //       onGenerateRoute: Routes.onGenerateRoute,
    //     );
    //   });

    // return EasyLocalization(
    //   path: 'assets/translations',
    //   supportedLocales: const [Locale('tr'), Locale('en'), Locale('de')],
    //   fallbackLocale: const Locale('tr'),
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: 'Petjoo',
    //     theme: ClassicTheme.myTheme(),
    //     locale: context.locale,
    //     supportedLocales: context.supportedLocales,
    //     localizationsDelegates: context.localizationDelegates,
    //     home: WelcomeView(),
    //   ),
    // );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Petjoo',
      theme: ClassicTheme.myTheme(),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      home: WelcomeView(),
    );
  }
}
