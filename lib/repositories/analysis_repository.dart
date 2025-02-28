import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/models/response.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/services/api/api_services.dart';
import 'package:auspower_flutter/utilities/extensions/response_extension.dart';
import 'package:flutter/material.dart';

class AnalysisRepository {
  Future<bool> getMeterResetReport(BuildContext context) async {
    Map<String, dynamic> params = {};
    if (authProvider.user?.employeeType == 'Operator' ||
        authProvider.user?.employeeType == 'Plant') {
      params.addAll({"plant_id": authProvider.user?.plantId});
    } else {
      params.addAll({"campus_id": authProvider.user?.campusId});
    }
    analysisProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "meter_reset_list/", body: params);
    powerProvider.isLoading = false;
    logger.i(response.data);

    if (response.hasError) return false;
    final jsonObj = response.data;
    // powerProvider.energyAnalysis = EnergyAnalysisModel.fromJson(jsonObj);
    return true;
  }

  Future<bool> getPowerFactorReport(BuildContext context,
      {required Map<String, dynamic> params}) async {
    // logger.f(params);
    analysisProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "pf_range_count/", body: params);
    powerProvider.isLoading = false;
    logger.i(response.data);

    if (response.hasError) return false;
    final jsonObj = response.data;
    // powerProvider.energyAnalysis = EnergyAnalysisModel.fromJson(jsonObj);
    return true;
  }
}
