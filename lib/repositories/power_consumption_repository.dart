import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/models/energyanalysis_model.dart';
import 'package:flutter/material.dart';
import 'package:auspower_flutter/models/response.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/services/api/api_services.dart';
import 'package:auspower_flutter/utilities/extensions/response_extension.dart';

class PowerConsumptionRepository {
  ///Prefix Url for the Authentication.

  ///Declare the [APIService] as [_api] with the [_prefixUrl] for the Authentication.

  Future<bool> getCampusData(BuildContext context) async {
    powerProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "get_campus_list/", body: {
      "campus_id":
          authProvider.user?.campusId == 0 ? "" : authProvider.user?.campusId,
    });
    powerProvider.isLoading = false;

    if (response.hasError) return false;
    // logger.i(response.data["data"]);
    powerProvider.getCampusList(response.data['data']);

    return true;
  }

  Future<bool> getCompanyData(BuildContext context, String campusId) async {
    powerProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "companyLists/", body: {
      "campus_id": campusId,
    });
    powerProvider.isLoading = false;

    if (response.hasError) return false;
    // logger.e(re);

    powerProvider.getCompanyList(response.data['companyLists']);

    return true;
  }

  Future<bool> getBusinessData(BuildContext context,
      {required String campusId, required String companyId}) async {
    powerProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "business_unit_Lists/", body: {
      "campus_id": campusId,
      "company_id": companyId,
    });
    powerProvider.isLoading = false;

    if (response.hasError) return false;
    // logger.e(response.data);

    powerProvider.getBusinessList(response.data['business_unit_Lists']);

    return true;
  }

  Future<bool> getPlantData(BuildContext context,
      {required Map<String, String> data}) async {
    powerProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "plant_Lists/", body: data);
    powerProvider.isLoading = false;

    if (response.hasError) return false;

    powerProvider.getPlantList(response.data['plant_Lists']);

    return true;
  }

  Future<bool> getDepartmentData(BuildContext context,
      {required Map<String, String> data}) async {
    logger.e(data);

    powerProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "get_department_name/", body: data);
    powerProvider.isLoading = false;

    if (response.hasError) return false;

    powerProvider.getDepartmentList(response.data['data']);

    return true;
  }

  Future<bool> getEquipmentData(BuildContext context,
      {required String companyId}) async {
    powerProvider.isLoading = true;
    ResponseData response = await APIService().post(
        context, "get_equipment_group_name/",
        body: {"company_id": companyId});
    powerProvider.isLoading = false;

    if (response.hasError) return false;

    powerProvider.getEquipmentList(response.data['data']);

    return true;
  }

  Future<bool> getMeterData(BuildContext context,
      {required Map<String, String> data, required bool isAll}) async {
    logger.e(data);

    powerProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "get_meter_list/", body: data);
    powerProvider.isLoading = false;

    if (response.hasError) return false;
    // logger.e(response.data);

    powerProvider.getMeterList(response.data['data'], isAll);

    return true;
  }

  Future<bool> getPowerReportData(BuildContext context) async {
    powerProvider.isLoading = true;
    ResponseData response = await APIService().post(
        context, "get_power_report_fields/",
        body: {"plant_id": authProvider.user?.plantId, "report_id": "7"});
    powerProvider.isLoading = false;
    // logger.i({"plant_id": authProvider.user?.plantId, "report_id": "7"});

    if (response.hasError) return false;

    powerProvider.getPowerReportFields(response.data['data']);

    return true;
  }

  Future<bool> getEnergyEntry(BuildContext context,
      {required Map<String, dynamic> params, required bool isDaily}) async {
    // logger.f(params);

    powerProvider.isLoading = true;
    ResponseData response = await APIService()
        .post(context, "get_source_entry_data_dtl/", body: params);
    powerProvider.isLoading = false;

    if (response.hasError) return false;
    List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(response.data['data']);
    // logger.w(data);

    powerProvider.getEnergyEntryList(data, isDaily);

    return true;
  }

  Future<bool> getEnergyAnalysis(BuildContext context,
      {required Map<String, dynamic> params}) async {
    logger.f(params);
    powerProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "current_power/", body: params);
    powerProvider.isLoading = false;
    // logger.i(response.data);
    logger.i(response.isError);
    logger.i(response.statusCode);

    if (response.hasError) return false;
    final jsonObj = response.data;
    powerProvider.energyAnalysis = EnergyAnalysisModel.fromJson(jsonObj);
    return true;
  }

  Future<bool> getEnergyAnalysisChart(BuildContext context,
      {required Map<String, dynamic> params}) async {
    logger.w(params);
    // powerProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "current_power/", body: params);
    // powerProvider.isLoading = false;
    if (response.hasError) return false;
    final jsonObj = response.data;
    // logger.i(response.data["data"]);
    powerProvider.energyAnalysis = EnergyAnalysisModel.fromJson(jsonObj);
    return true;
  }

  Future<bool> getIpaddress(BuildContext context,
      {required String plantId}) async {
    // logger.f(plantId);
    // powerProvider.isLoading = true;
    ResponseData response = await APIService()
        .post(context, "communication_status/", body: {"plant_id": plantId});
    // powerProvider.isLoading = false;
    if (response.hasError) return false;
    // final jsonObj = response.data;
    // logger.i(response.data);
    powerProvider.getIpAddres(response.data['data']);

    // powerProvider.energyAnalysis = EnergyAnalysisModel.fromJson(jsonObj);
    return true;
  }

  Future<bool> saveEnergyEntry(BuildContext context,
      {required Map<String, dynamic> params}) async {
    logger.f(params);
    powerProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "save_src_entry_data/", body: params);
    powerProvider.isLoading = false;
    logger.i(response.data);

    if (response.hasError) return false;
    final jsonObj = response.data;
    powerProvider.energyAnalysis = EnergyAnalysisModel.fromJson(jsonObj);
    return true;
  }
}
