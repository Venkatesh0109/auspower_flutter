import 'package:auspower_flutter/models/notification_model.dart';
import 'package:flutter/widgets.dart';

class SqlDbProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  List<NotificationModel> _notificationList = [];
  List<NotificationModel> get notificationList => _notificationList;
  set notificationList(List<NotificationModel> val) {
    _notificationList = val;
    notifyListeners();
  }

  List<String> listId = [];
  void checkedBoxId(String id, bool isChecked) {
    if (isChecked == true) {
      listId.add(id);
    }
    if (isChecked == false) {
      listId.remove(id);
    }
    notifyListeners();
  }

  void clearList() {
    listId = [];
    notifyListeners();
  }
}
