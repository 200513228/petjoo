import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petjoo/home/service/dlink_service.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'base/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DLinkService.instance(await FirebaseDynamicLinks.instance.getInitialLink());
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationService.instance.initialize(_firebaseMessagingBackgroundHandler);

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('tr'), Locale('en'), Locale('de')],
      fallbackLocale: const Locale('tr'),
      child: const App(),
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
