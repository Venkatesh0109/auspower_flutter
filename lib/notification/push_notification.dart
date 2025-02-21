import 'package:firebase_messaging/firebase_messaging.dart';

import 'notification_handler.dart';

class PushNotification {
  static handleForegroundNotifications() async {
    // to handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // final dateTime = DateTime.now();
      // final formatter = DateFormat("dd-MM-yyyy hh:mm:ss");
      // final formattedDateTime = formatter.format(dateTime);

      // Sqlite().createItem(
      //   NotificationModel(
      //       message.notification!.title.toString(),
      //       message.notification!.body.toString(),
      //       formattedDateTime.toString()),
      // );
      NotificationHandler.handle(remoteMessage: message);
    });
  }

  static handleTerminatedState() async {
    // for handling in terminated state
    final RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      Future.delayed(const Duration(seconds: 1), () {});
    }
  }

  static onBackgroundNotificationTapped() {
    // on background notification tapped
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        //Background Notification Tapped
        // router.pushNamed('order',
        //     pathParameters: {'id': message.data['order_id']});
      }
    });
  }

  void onBackgroundMessage() {}
}
