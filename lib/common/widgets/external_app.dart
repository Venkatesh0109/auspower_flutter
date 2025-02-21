// ignore_for_file: deprecated_member_use

import 'package:url_launcher/url_launcher.dart';

class ExternalApp {
  static String mapUrl(String latitude, String longitude) =>
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

  ///Opens External app if exists or open in browser
  Future<void> openExternalApp(String url) async {
    try {
      bool launched = await launch(url,
          forceSafariVC: false); // Launch the app if installed!

      if (!launched) {
        launch(url); // Launch web view if app is not installed!
      }
    } catch (e) {
      launch(url); // Launch web view if app is not installed!
    }
  }
}
