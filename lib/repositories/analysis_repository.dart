import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/models/meter_reset_model.dart';
import 'package:auspower_flutter/models/power_factor_detail.dart';
import 'package:auspower_flutter/models/power_factor_variation_model.dart';
import 'package:auspower_flutter/models/response.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/services/api/api_services.dart';
import 'package:flutter/material.dart';

class AnalysisRepository {
  Future<bool> getMeterResetReport(BuildContext context) async {
    Map<String, dynamic> params = {};
    if (authProvider.user?.employeeType == 'Operator' ||
        authProvider.user?.employeeType == 'Plant'
        &&
              authProvider.user?.isCampus == "no"
        ) {
      params.addAll({"plant_id": authProvider.user?.plantId});
    } else {
      authProvider.user?.campusId == 0
          ? {}
          : params.addAll({"campus_id": authProvider.user?.campusId});
    }
    logger.i(authProvider.user?.toJson());
    analysisProvider.isLoading = true;
    ResponseData response =
        await APIService().get(context, "meter_reset_list/", params: params);
    analysisProvider.isLoading = false;
    logger.e("message");
    // if (response.hasError) return false;
    final jsonObj = response.data;
    analysisProvider.meterResetData = MeterResetModel.fromJson(jsonObj);
    return true;
  }

  Future<bool> getPowerFactorReport(BuildContext context, String date) async {
    Map<String, dynamic> params = {};
    params.addAll({"method": "summary", "range": "", "date": date});
    logger.i(params);
    if (authProvider.user?.employeeType == 'Operator' ||
        authProvider.user?.employeeType == 'Plant'
        &&
              authProvider.user?.isCampus == "no"
        ) {
      params.addAll({"plant_id": authProvider.user?.plantId});
    } else {
      authProvider.user?.campusId == 0
          ? {}
          : params.addAll({"campus_id": authProvider.user?.campusId});
    }
    // logger.f(params);
    analysisProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "pf_range_counts/", body: params);
    analysisProvider.isLoading = false;

    // if (response.hasError) return false;
    // logger.f(response.data);
    final jsonObj = response.data;
    analysisProvider.powerFactorData =
        PowerFactorVariationModel.fromJson(jsonObj);
    // logger.i(analysisProvider.powerFactorData?.toJson());
    return true;
  }

  Future<bool> getPowerFactorReportDetail(
      BuildContext context, String range, String date) async {
    Map<String, dynamic> params = {};
    params.addAll({"method": "detail", "range": range, "date": date});

    if (authProvider.user?.employeeType == 'Operator' ||
        authProvider.user?.employeeType == 'Plant'
        &&
              authProvider.user?.isCampus == "no"
        ) {
      params.addAll({"plant_id": authProvider.user?.plantId});
    } else {
      authProvider.user?.campusId == 0
          ? {}
          : params.addAll({"campus_id": authProvider.user?.campusId});
    }
    analysisProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "pf_range_counts/", body: params);
    analysisProvider.isLoading = false;

    // if (response.hasError) return false;
    final jsonObj = response.data;
    analysisProvider.powerFactorDetailData =
        PowerFactorVariationDetailModel.fromJson(jsonObj);
    // logger.i(analysisProvider.powerFactorData?.toJson());
    return true;
  }
}
