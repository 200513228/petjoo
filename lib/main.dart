import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/modules/home/service/dlink_service.dart';
import 'package:petjoo/product/providers/chat_provider.dart';
import 'package:petjoo/product/providers/settings_provider.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'product/providers/user_provider.dart';
import 'product/services/notification_service.dart';

final userProvider = ChangeNotifierProvider((ref) => UserProvider());
final settingsProvider = ChangeNotifierProvider((ref) => SettingsProvider());
final chatProvider = ChangeNotifierProvider((ref) => ChatProvider());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationService.instance.initialize(_firebaseMessagingBackgroundHandler);
  // DynamicLinkService.instance
  //     .initialize(await FirebaseDynamicLinks.instance.getInitialLink());
  DLinkService.instance(await FirebaseDynamicLinks.instance.getInitialLink());
  // await initHive();
  runApp(
    ProviderScope(
      child: EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [Locale('tr'), Locale('en'), Locale('de')],
        fallbackLocale: const Locale('tr'),
        child: const App(),
      ),
    ),
  );
}

// Future<void> initHive() async {
//   await Hive.initFlutter("petjoo");
//   await SettingsProvider.init();
// }

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
