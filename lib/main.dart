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

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true,
    showBadge: true,
    enableVibration: true);

//firebase background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp();
  logger.e(message.notification!);
  final dateTime = DateTime.now();
  final formatter = DateFormat("dd-MM-yyyy hh:mm:ss");
  final formattedDateTime = formatter.format(dateTime);

  SqlDbRepository().createItem(
    NotificationModel(message.notification!.title.toString(),
        message.notification!.body.toString(), formattedDateTime.toString()),
  );
  // NotificationHandler.handle(remoteMessage: message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NotificationService.init();

  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    logger.i("Firebase is already initialized");
  }

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    carPlay: false,
    criticalAlert: true,
    provisional: false,
  );
  // Firebase local notification plugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  // logger.w("Notification sound set: ${channel.sound}");
  // Firebase messaging
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iOSSetting = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const setting =
      InitializationSettings(android: androidSetting, iOS: iOSSetting);

  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) {
      logger.e(message.notification!);

      final dateTime = DateTime.now();
      final formatter = DateFormat("dd-MM-yyyy hh:mm:ss");
      final formattedDateTime = formatter.format(dateTime);

      SqlDbRepository().createItem(
        NotificationModel(
            message.notification!.title.toString(),
            message.notification!.body.toString(),
            formattedDateTime.toString()),
      );
      // NotificationHandler.handle(remoteMessage: message);
      try {
        RemoteNotification? notification = message.notification;

        // AppleNotification? apple = message.notification?.apple;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              iOS: const DarwinNotificationDetails(
                presentAlert: true, // Alert will be shown
                presentBadge: true, // Badge will be updated
                presentSound: true, // Custom sound enabled
                // sound: 'custom_sound.caf', // iOS specific custom sound file
                interruptionLevel:
                    InterruptionLevel.active, // Optional: Interrupt the user
              ),
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                // sound: RawResourceAndroidNotificationSound(''),
                playSound: true,
                enableVibration: true,
                icon: '@mipmap/ic_launcher', // Corrected icon reference
                styleInformation: const BigTextStyleInformation(''),
              ),
            ),
          );
        }
      } catch (e) {
        print("firebase error:$e");
      }
      print("foreground message invoked");
    },
  );

  FirebaseMessaging.instance.onTokenRefresh.listen((event) {
    print("refreshed Token:$event");
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  flutterLocalNotificationsPlugin.initialize(
    setting,
    onDidReceiveNotificationResponse: (details) {
      onNotificationTap(details.payload ?? "");
    },
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]).then(
      (_) => runApp(MultiProvider(providers: providers, child: const MyApp())));
  // CustomDateTime().getOffSet();
  // runApp(MultiProvider(providers: providers, child: const MyApp()));
}

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
          builder: (BuildContext context, Widget? child) => Stack(children: [
            if (child != null) child,
            if (!info.isHadInternet) const NoInternetScreen(),
          ]),
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: lightTheme,
          home: const SplashScreen(),
          localizationsDelegates: const [
            MonthYearPickerLocalizations
                .delegate, // Required for month-year picker
          ],
          // darkTheme: darkTheme,
          themeMode: themeManager.themeMode,
          scaffoldMessengerKey: snackbarKey,
        );
      },
    );
  }
}
