import 'package:auspower_flutter/constants/keys.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'notification_service.dart';

class NotificationHandler {
  String? status;
  Map? payload;
  RemoteMessage? remoteMessage;
  NotificationHandler();

  NotificationHandler.handle({this.remoteMessage}) {
    // if (remoteMessage == null || remoteMessage?.data.isEmpty == true) return;
    if (remoteMessage == null) return;
    logger.e(remoteMessage?.data);

    Map data = remoteMessage?.data ?? {};
    // logger.e(data);

    if (data.isEmpty) return;
    // String payloadData = jsonEncode(remoteMessage?.data);
    NotificationService.showSimpleNotification(
      title: data['title'] ?? '',
      body: data['body'] ?? '',
    );
  }

  NotificationHandler.handleTap() {
    openScreen();
  }

  void openScreen() {
    // Get.to(const NotificationScreen());
  }
}
