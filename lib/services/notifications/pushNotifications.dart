import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../helper/GetStorageHelper.dart';

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initializeLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        print(response);
      },
    );
  }

  static Future<void> handleMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    if (message != null) {
      print("Body : ${message.notification?.body ?? ""}");
      print("Payload ${message.data}");
      print("Title : ${message.notification?.title ?? ""}");
      return;
    }
    showNotification(message);
  }

  static void firebaseInitial() {
    FirebaseMessaging.onMessage.listen((event) {
      if (kDebugMode) {
        print("Payload ${event.data}");
        print("Title : ${event.notification?.title ?? ""}");
        print("Body : ${event.notification?.body ?? ""}");
      }
      showNotification(event);
    });
  }

  static Future<void> showNotification(RemoteMessage message) async {
    var androidChannelSpecifics = const AndroidNotificationDetails(
      'raipur_homes',
      'Raipur Homes',
      channelDescription: "Description",
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title.toString() ?? "",
      message.notification?.body.toString() ?? "",
      platformChannelSpecifics,
    );
  }

  static Future init() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted authorization");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional authorization");
    } else {
      print("User denied permission");
    }

    final token = await _firebaseMessaging.getToken();
    print("device_token_raipurHomes: $token");
    box.write('device_token_raipurHomes', token);

    FirebaseMessaging.onBackgroundMessage(handleMessage);
  }

  static void isTokenRefreshed() async {
    _firebaseMessaging.onTokenRefresh.listen((token) {
      print("device_token_raipurHomes : $token");
      box.write('device_token_raipurHomes', token);
    });
  }
}
