import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';

class CustomDateTime {
  static int offset = 0;
  DateTime get now {
    if (offset == 0) return DateTime.now();
    return DateTime.now().add(Duration(milliseconds: offset));
  }

  Future<void> getOffSet() async {
    offset = await NTP.getNtpOffset(
        localTime: DateTime.now(), lookUpAddress: "time.google.com");
  }

  List<AppLifecycleState> appLifecycleState = [];
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appLifecycleState.add(state);
    if (appLifecycleState.length == 2 &&
        appLifecycleState[appLifecycleState.length - 1] !=
            AppLifecycleState.resumed &&
        state != AppLifecycleState.resumed) {
      return;
    }
    getOffSet();
  }
}
