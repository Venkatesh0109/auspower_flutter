import 'package:flutter/material.dart';

class Navigation {
  void push(BuildContext context, PageRouteBuilder child) {
    Navigator.push(context, child);
  }

  void pushReplace(BuildContext context, PageRouteBuilder child) {
    Navigator.pushReplacement(context, child);
  }

  void pushRemoveUntil(BuildContext context, Widget child) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (ctx) => child,
      ),
      (route) => false, // Remove all routes
    );
  }
}
