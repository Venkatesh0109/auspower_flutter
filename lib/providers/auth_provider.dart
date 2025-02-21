import 'package:flutter/material.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/models/auth_user.dart';
import 'package:auspower_flutter/services/storage/storage_constants.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  bool _googleLoading = false;
  bool get googleLoading => _googleLoading;
  set googleLoading(bool val) {
    _googleLoading = val;
    notifyListeners();
  }

  AuthUser? _user;
  AuthUser? get user => _user;
  set user(AuthUser? val) {
    _user = val;
    notifyListeners();
  }

  String _token = '';
  String get token => _token;
  set token(String val) {
    _token = val;
    storage.write(key: StorageConstants.accessToken, value: val);
    notifyListeners();
  }

  void clear() {
    user = null;
    token = '';
    notifyListeners();
  }
}
