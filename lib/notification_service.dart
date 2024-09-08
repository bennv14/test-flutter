import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  static NotificationService get instance => _instance;

  NotificationService._internal();

  late final Stream<RemoteMessage> onMessage;
  late final Stream<RemoteMessage> onMessageOpenedApp;

  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> init() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    onMessage = FirebaseMessaging.onMessage;
    onMessageOpenedApp = FirebaseMessaging.onMessageOpenedApp;

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) async {
        print("_onDidReceiveNotificationResponse");
      },
      onDidReceiveBackgroundNotificationResponse: (response) async {
        print("_onDidReceiveBackgroundNotificationResponse");
      },
    );

    onMessage.listen(display);
    onMessageOpenedApp.listen(_handleMessageOpenedApp);
  }

  //setup notification
  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  static final DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: (id, title, body, payload) async {},
  );

  static final InitializationSettings initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  static const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'channel id',
    'channel name',
    channelDescription: 'channel description',
    importance: Importance.max,
    priority: Priority.high,
  );

  static const DarwinNotificationDetails darwinNotificationDetails =
      DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  Future<String?> getFcmToken() async {
    return FirebaseMessaging.instance.getToken();
  }

  void display(RemoteMessage message) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    flutterLocalNotificationsPlugin.show(
      id,
      message.notification!.title,
      message.notification!.body,
      const NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      ),
      payload: jsonEncode(message.data),
    );
  }

  Future<void> _handleMessageOpenedApp(RemoteMessage message) async {
    print("handleMessageOpenedApp");
  }
}
