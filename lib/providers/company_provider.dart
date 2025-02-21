import 'package:auspower_flutter/models/branch_list_data.dart';
import 'package:auspower_flutter/models/company_list_model.dart';
import 'package:auspower_flutter/models/plant_list_data.dart';
import 'package:flutter/widgets.dart';

class CompanyProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  CompanyListModel? _companyList;
  CompanyListModel? get companyList => _companyList;
  set companyList(CompanyListModel? val) {
    _companyList = val;
    notifyListeners();
  }

  BranchListModel? _branchList;
  BranchListModel? get branchList => _branchList;
  set branchList(BranchListModel? val) {
    _branchList = val;
    notifyListeners();
  }
  PlantListModel? _plantList;
  PlantListModel? get plantList => _plantList;
  set plantList(PlantListModel? val) {
    _plantList = val;
    notifyListeners();
  }

  void clear(){
    _companyList = null;
    _branchList = null;
    _plantList = null;
    notifyListeners();
  }
}
