import 'package:auspower_flutter/firbase_option.dart';
import 'package:auspower_flutter/models/notification_model.dart';
import 'package:auspower_flutter/repositories/sql_db_repository.dart';
import 'package:auspower_flutter/view/authentication/screens/splash_screen.dart';
import 'package:auspower_flutter/view/table_report/detail_power_consumption.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auspower_flutter/constants/app_strings.dart';
import 'package:auspower_flutter/providers/info_provider.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:auspower_flutter/view/no_internet.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'constants/keys.dart';
import 'theme/theme_constants.dart';
import 'theme/theme_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// 🔹 Initialize Local Notifications Plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// 🔹 Define Android Notification Channel
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // ID
  'High Importance Notifications', // Name
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
  playSound: true,
  showBadge: true,
  enableVibration: true,
);

/// 🔹 Firebase Background Message Handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final dateTime = DateTime.now();
  final formattedDateTime = DateFormat("dd-MM-yyyy HH:mm:ss").format(dateTime);
  logger.f(message.notification!.title);
  logger.f(message.notification!.body);
  SqlDbRepository().createItem(
    NotificationModel(
      message.notification!.title ?? "",
      message.notification!.body ?? "",
      formattedDateTime,
    ),
  );
}

/// 🔹 Main Function
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// 🔸 Request Permissions for Notifications (iOS + Android)
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    announcement: false,
    carPlay: false,
    criticalAlert: true,
    provisional: false,
  );

  /// 🔸 Register Notification Channel for Android
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// 🔸 Set Foreground Notification Behavior (iOS)
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  /// 🔸 Initialize Local Notification Settings
  const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iOSSetting = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const settings =
      InitializationSettings(android: androidSetting, iOS: iOSSetting);

  flutterLocalNotificationsPlugin.initialize(
    settings,
    onDidReceiveNotificationResponse: (details) {
      onNotificationTap(details.payload ?? "");
    },
  );

  /// 🔸 Foreground Message Handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final dateTime = DateTime.now();
    final formattedDateTime =
        DateFormat("dd-MM-yyyy HH:mm:ss").format(dateTime);
    logger.f(message.notification!.title);
    logger.f(message.notification!.body);
    SqlDbRepository().createItem(
      NotificationModel(
        message.notification!.title ?? "",
        message.notification!.body ?? "",
        formattedDateTime,
      ),
    );
    _showNotification(message);
  });

  /// 🔸 Background Message Handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// 🔸 Token Refresh Listener
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    // print("🔥 FCM Token Refreshed: $newToken");
  });

  /// 🔸 Set Preferred Orientation & Run App
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(MultiProvider(providers: providers, child: const MyApp()));
  });
}

/// 🔹 Function to Show Notifications
void _showNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          sound: const RawResourceAndroidNotificationSound('custom_sound'),
          icon: '@mipmap/ic_launcher',
          styleInformation: const BigTextStyleInformation(''),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: 'custom_sound.caf', // 🔹 For iOS
        ),
      ),
    );
  }
}

/// 🔹 Main App Widget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeManager, InfoProvider>(
      builder: (context, themeManager, info, child) {
        return MaterialApp(
          key: mainKey,
          builder: (BuildContext context, Widget? child) => Stack(
            children: [
              if (child != null) child,
              if (!info.isHadInternet) const NoInternetScreen(),
            ],
          ),
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: lightTheme,
          home: const SplashScreen(),
          localizationsDelegates: const [
            MonthYearPickerLocalizations
                .delegate, // Required for month-year picker
          ],
          themeMode: themeManager.themeMode,
          scaffoldMessengerKey: snackbarKey,
        );
      },
    );
  }
}
