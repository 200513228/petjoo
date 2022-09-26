import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  NotificationService._();

  static NotificationService? _instance;

  static bool isGo = false;
  static String? type;
  static String? docid;

  static NotificationService get instance =>
      _instance ?? (_instance = NotificationService._());

  initialize(BackgroundMessageHandler handler) {
    final firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.requestPermission();
    firebaseMessaging.subscribeToTopic("all");
    if (kDebugMode) firebaseMessaging.subscribeToTopic("debug");
    FirebaseMessaging.onBackgroundMessage(handler);
    firebaseMessaging.getInitialMessage().then((value) {
      if (value != null) {
        isGo = true;
        type = value.data['type'];
        docid = value.data['docid'];
      }
    });
  }

  Future<String?> get token =>
      FirebaseMessaging.instance.getToken().onError((error, stackTrace) => "");
}
