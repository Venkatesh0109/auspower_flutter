// ignore_for_file: depend_on_referenced_packages

import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/firbase_option.dart';
import 'package:auspower_flutter/models/notification_model.dart';
import 'package:auspower_flutter/notification/push_notification.dart';
import 'package:auspower_flutter/repositories/sql_db_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import 'notification_handler.dart';
// import 'package:permission_handler/permission_handler.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final dateTime = DateTime.now();
  final formatter = DateFormat("dd-MM-yyyy hh:mm:ss");
  final formattedDateTime = formatter.format(dateTime);

  SqlDbRepository().createItem(
    NotificationModel(message.notification!.title.toString(),
        message.notification!.body.toString(), formattedDateTime.toString()),
  );
}

class NotificationService {
  static final firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static Future init() async {
    logger.i("message");
    WidgetsFlutterBinding.ensureInitialized();

    try {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    } catch (e) {
      logger.i("Firebase is already initialized");
    }
    logger.e("firebase");

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    logger.f("initialized");

    await localNotiInit();
    PushNotification.handleForegroundNotifications();
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    logger.e(message.data);
    logger.e(message.notification!.title);
    logger.e(message.notification!.body);
    // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);
    NotificationHandler.handle(remoteMessage: message);
    // final dateTime = DateTime.now();
    // final formatter = DateFormat("dd-MM-yyyy hh:mm:ss");
    // final formattedDateTime = formatter.format(dateTime);

    // Sqlite().createItem(
    //   NotificationModel(message.notification!.title.toString(),
    //       message.notification!.body.toString(), formattedDateTime.toString()),
    // );
  }

// initalize local notifications
  static Future localNotiInit() async {
    // PermissionStatus status = await Permission.notification.status;
    // if (status != PermissionStatus.granted) {
    //   await Permission.notification.request();
    // }
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            // onDidReceiveLocalNotification: (id, title, body, payload) {},
            );
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  // on tap local notification in foreground
  static void onNotificationTap(NotificationResponse notificationResponse) {
    NotificationHandler.handleTap();
  }

  // show a simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('high_importance_channel', "Auspower",
            channelDescription: "Auspower",
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // ID must match the value in the manifest
      'Auspower', // Name
      description: 'Auspower',
      importance: Importance.high,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await _flutterLocalNotificationsPlugin
        .show(id++, title, body, notificationDetails, payload: payload ?? '');
  }
}

int id = 0;
