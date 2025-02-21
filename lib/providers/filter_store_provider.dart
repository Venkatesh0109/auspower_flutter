import 'package:flutter/material.dart';

class FilterStoreProvider extends ChangeNotifier {
  Map? campus = {"campus_name": "All"};
  Map? company = {"company_name": "All"};
  Map? bu = {"bu_name": "All"};
  Map? plant = {"plant_name": "All"};
  Map? meter = {}; // ✅ Default "All"
  String? groupByName = "meter";
  Map? groupBy;

  List groupByLists = [
    {"groupBy": "Plant"},
    {"groupBy": "Department"},
    {"groupBy": "Equipment Group"},
    {"groupBy": "IOT Equipment"},
    {"groupBy": "Meter"},
  ];

  FilterStoreProvider() {
    groupBy = groupByLists[4]; // Default to "Meter"
    notifyListeners();
  }

  void setCampus(Map newCampus) {
    campus = newCampus;
    company = {"company_name": "All"};
    bu = {"bu_name": "All"};
    plant = {"plant_name": "All"};
    meter = {"meter_name": "All"};
    notifyListeners();
  }

  void setCompany(Map newCompany) {
    company = newCompany;
    bu = {"bu_name": "All"};
    plant = {"plant_name": "All"};
    meter = {"meter_name": "All"};
    notifyListeners();
  }

  void setBu(Map newBu) {
    bu = newBu;
    plant = {"plant_name": "All"};
    meter = {"meter_name": "All"};
    notifyListeners();
  }

  void setPlant(Map newPlant) {
    plant = newPlant;
    meter = {"meter_name": "All"};
    notifyListeners();
  }

  void setMeter(Map newMeter) {
    meter = newMeter;
    notifyListeners();
  }

  void setGroupBy(Map newGroupBy) {
    groupBy = newGroupBy;
    groupByName = newGroupBy["groupBy"] == "Plant"
        ? "plant"
        : newGroupBy["groupBy"] == "Department"
            ? "plant_department"
            : newGroupBy["groupBy"] == "Equipment Group"
                ? "equipment_group"
                : newGroupBy["groupBy"] == "IOT Equipment"
                    ? "equipment"
                    : "meter";
    notifyListeners();
  }
}
