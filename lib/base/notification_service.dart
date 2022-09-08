import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  NotificationService._();

  static NotificationService? _instance;

  static NotificationService get instance => _instance ?? (_instance = NotificationService._());


  initialize(BackgroundMessageHandler handler) {
    final firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.requestPermission();
    firebaseMessaging.subscribeToTopic("all");
    if(kDebugMode) firebaseMessaging.subscribeToTopic("debug");
    FirebaseMessaging.onBackgroundMessage(handler);
  }

  Future<String?> get token => FirebaseMessaging.instance.getToken().onError((error, stackTrace) => "");
}
