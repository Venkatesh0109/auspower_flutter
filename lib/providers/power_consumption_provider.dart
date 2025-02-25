import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/models/energyanalysis_model.dart';
import 'package:flutter/material.dart';

class PowerConsumptionProvider extends ChangeNotifier {
  List campusData = [];
  List companyData = [];
  List buLists = [];
  List plantLists = [];
  List departmentLists = [];
  List equipmentLists = [];
  List meterLists = [];
  List powerReportFields = [];
  List ipAddress = [];
  List<Map<String, dynamic>> energyEnterList = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void getCampusList(List data) {
    campusData = data;
    // campusData =
    // [
    //   {"campus_name": "All"},
    //   ...data
    // ]; // Add at first index
    notifyListeners();
  }

  void getCompanyList(List data) {
    companyData = data;
    // companyData =
    // [
    //   {"company_name": "All"},
    //   ...data
    // ];
    notifyListeners();
  }

  void getBusinessList(List data) {
    buLists = data;
    // buLists =
    // [
    //   {"bu_name": "All"},
    //   ...data
    // ];
    notifyListeners();
  }

  void getPlantList(List data) {
    plantLists = data;
    // plantLists =
    // [
    //   {"plant_name": "All"},
    //   ...data
    // ];
    notifyListeners();
  }

  void getDepartmentList(List data) {
    departmentLists = data;
    // departmentLists =
    // [
    //   {"plant_department_name": "All"},
    //   ...data
    // ];
    notifyListeners();
  }

  void getEquipmentList(List data) {
    equipmentLists = data;
    // equipmentLists =
    // [
    //   {"equipment_group_name": "All"},
    //   ...data
    // ];
    notifyListeners();
  }
  void getIpAddres(List data) {
    ipAddress =
    [
      {"ip_address": "All"},
      ...data
    ];
    notifyListeners();
  }

  void getMeterList(List data, bool isAll) {
    // meterLists = data;
    if (isAll) {
      meterLists = [
        {"meter_name": "All"},
        ...data
      ];
    } else {
      meterLists = data;
    }

    notifyListeners();
  }

  void getPowerReportFields(List data) {
    powerReportFields = data;
    // powerReportFields = [
    //   {"field_name": "S.No"},
    //   ...data
    // ];
    // logger.e(data[0]);
    notifyListeners();
  }

  List<Map<String, dynamic>> dailyEntry = [
    {"source": "Energy Source"},
    {"source": "Consumption"},
  ];
  List<Map<String, dynamic>> monthlyEntry = [
    {"source": "Energy Source"},
    {"source": "Consumption(Provision)"},
    {"source": "Consumption(Final)"},
  ];
  List<Map<String, dynamic>> tableValues = [];

  void getEnergyEntryList(List<Map<String, dynamic>> data, bool isDaily) {
    logger.w(data);
    energyEnterList = data;
    notifyListeners();
  }

  EnergyAnalysisModel? _energyAnalysis;
  EnergyAnalysisModel? get energyAnalysis => _energyAnalysis;
  set energyAnalysis(EnergyAnalysisModel? val) {
    _energyAnalysis = val;
    notifyListeners();
  }

  void clear() {
    campusData = [];
    companyData = [];
    meterLists = [];
    buLists = [];
    plantLists = [];
    equipmentLists = [];
    departmentLists = [];
    powerReportFields = [];
    energyEnterList = [];
    energyAnalysis = null;
    notifyListeners();
  }
}
