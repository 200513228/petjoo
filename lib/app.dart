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

  // return Consumer(builder: (context, ref, child) {
  //   // final provider = ref.watch(settingsProvider);
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Petjoo',
  //     theme: ClassicTheme.myTheme(),
  //     locale: _.locale,
  //     supportedLocales: _.supportedLocales,
  //     localizationsDelegates: _.localizationDelegates,
  //     home: WelcomeView(),
  //     // initialRoute: FirebaseAuth.instance.currentUser == null
  //     //     ? Routes.auth
  //     //     : Routes.navigation,
  //     // onGenerateRoute: Routes.onGenerateRoute,
  //   );
  // });

}
