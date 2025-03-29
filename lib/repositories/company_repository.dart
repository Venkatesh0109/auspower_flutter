import 'dart:convert';

import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/models/auth_user.dart';
import 'package:auspower_flutter/models/branch_list_data.dart';
import 'package:auspower_flutter/models/company_list_model.dart';
import 'package:auspower_flutter/models/plant_list_data.dart';
import 'package:auspower_flutter/models/response.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/services/api/api_services.dart';
import 'package:auspower_flutter/services/storage/storage_constants.dart';
import 'package:auspower_flutter/utilities/extensions/response_extension.dart';
import 'package:flutter/material.dart';

class CompanyRepository {
  Future<bool> getCompanyList(BuildContext context,
      {required String campusId}) async {
    String authDetails =
        await storage.read(key: StorageConstants.authCreds) ?? '';
    AuthUser user = AuthUser.fromJson(jsonDecode(authDetails));

    Map<String, dynamic> body = {
      "period_id": "cur_shift",
      'groupby': 'company',
      'group_for': 'regular',
      "report_for": 'cumulative',
      "campus_id": user.campusId.toString(),
    };

    companyProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "current_power/", body: body);
    logger.i(response.data);

    companyProvider.isLoading = false;
    if (response.hasError) return false;
    final jsonObj = response.data;
    companyProvider.companyList = CompanyListModel.fromJson(jsonObj);
    // String message = response.data['message'] ?? '';
    // if (message.isNotEmpty)
    //   showMessage(context: context, isError: true, responseMessage: message);
    return true;
  }
   

  Future<bool> getBranchList(
    BuildContext context, {
    required String campusId,
    required String companyId,
  }) async {
    String authDetails =
        await storage.read(key: StorageConstants.authCreds) ?? '';
    AuthUser user = AuthUser.fromJson(jsonDecode(authDetails));
    Map<String, dynamic> body = {
      "period_id": "cur_shift",
      'groupby': 'bu',
      'group_for': 'regular',
      "report_for": 'cumulative',
      "campus_id": user.campusId.toString(),
      "company_id": companyId
    };

    companyProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "current_power/", body: body);
    // logger.i(response.data);

    companyProvider.isLoading = false;
    if (response.hasError) return false;
    final jsonObj = response.data;
    companyProvider.branchList = BranchListModel.fromJson(jsonObj);

    // breakProvider.subCategoryData = SubCategoryModel.fromJson(jsonObj);
    // String message = response.data['message'] ?? '';
    // if (message.isNotEmpty)
    //   showMessage(context: context, isError: true, responseMessage: message);
    return true;
  }

  Future<bool> getPlantList(
    BuildContext context, {
    required String campusId,
    required String companyId,
    required String buId,
  }) async {
    Map<String, dynamic> body = {
      "period_id": "cur_shift",
      'groupby': 'plant',
      'group_for': 'regular',
      "report_for": 'cumulative',
      "campus_id": campusId,
      "company_id": companyId,
      "bu_id": buId
    };

    companyProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "current_power/", body: body);

    companyProvider.isLoading = false;
    if (response.hasError) return false;
    final jsonObj = response.data;
    companyProvider.plantList = PlantListModel.fromJson(jsonObj);
    // logger.i(response.data);

    // breakProvider.subCategoryData = SubCategoryModel.fromJson(jsonObj);
    // String message = response.data['message'] ?? '';
    // if (message.isNotEmpty)
    //   showMessage(context: context, isError: true, responseMessage: message);
    return true;
  }
}
