import 'package:flutter/material.dart';

class SubscriptionProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isSubscribed = false;
  bool get isSubscribed => _isSubscribed;
  set isSubscribed(bool val) {
    _isSubscribed = val;
    notifyListeners();
  }
}
