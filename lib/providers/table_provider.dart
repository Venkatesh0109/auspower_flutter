import 'package:auspower_flutter/models/currennt_power_machine_data.dart';
import 'package:auspower_flutter/models/top_connsumption_data.dart';
import 'package:auspower_flutter/view/dashboardscreen.dart';
import 'package:flutter/material.dart';

class TableProvider extends ChangeNotifier {
  List<dynamic> detailedPowerConsumptionList = [];

  void detailPowerData(List<dynamic> data) {
    detailedPowerConsumptionList = data;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  List<CurrentPowerTableData> _currentpowerTableData = [];
  List<CurrentPowerTableData> get currentpowerTableData =>
      _currentpowerTableData;
  set currentpowerTableData(List<CurrentPowerTableData> val) {
    _currentpowerTableData = val;
    notifyListeners();
  }

  List<TopConsumptionnData> _topConsumptionGraphData = [];
  List<TopConsumptionnData> get topConsumptionGraphData =>
      _topConsumptionGraphData;
  set topConsumptionGraphData(List<TopConsumptionnData> val) {
    _topConsumptionGraphData = val;
    notifyListeners();
  }

  EmployeeDataSource? _data;
  EmployeeDataSource? get data => _data;
  set data(EmployeeDataSource? val) {
    _data = val;
    notifyListeners();
  }

  void clear() {
    currentpowerTableData = [];
    topConsumptionGraphData = [];
    data = null;
    notifyListeners();
  }
}
