import 'package:auspower_flutter/models/meter_reset_model.dart';
import 'package:auspower_flutter/models/power_factor_detail.dart';
import 'package:auspower_flutter/models/power_factor_variation_model.dart';
import 'package:flutter/material.dart';

class AnalysisProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  MeterResetModel? _meterResetData;
  MeterResetModel? get meterResetData => _meterResetData;
  set meterResetData(MeterResetModel? val) {
    _meterResetData = val;
    notifyListeners();
  }

  PowerFactorVariationModel? _powerFactorData;
  PowerFactorVariationModel? get powerFactorData => _powerFactorData;
  set powerFactorData(PowerFactorVariationModel? val) {
    _powerFactorData = val;
    notifyListeners();
  }

  PowerFactorVariationDetailModel? _powerFactorDetailData;
  PowerFactorVariationDetailModel? get powerFactorDetailData =>
      _powerFactorDetailData;
  set powerFactorDetailData(PowerFactorVariationDetailModel? val) {
    _powerFactorDetailData = val;
    notifyListeners();
  }

  void clear() {
    meterResetData = null;
    powerFactorData = null;
    notifyListeners();
  }
}
