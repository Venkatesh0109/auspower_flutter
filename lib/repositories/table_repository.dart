import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/models/currennt_power_machine_data.dart';
import 'package:auspower_flutter/models/top_connsumption_data.dart';
import 'package:auspower_flutter/view/dashboardscreen.dart';
import 'package:flutter/material.dart';
import 'package:auspower_flutter/models/response.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/services/api/api_services.dart';
import 'package:auspower_flutter/utilities/extensions/response_extension.dart';

class TableRepository {
  ///Prefix Url for the Authentication.

  ///Declare the [APIService] as [_api] with the [_prefixUrl] for the Authentication.

  Future<bool> gettableData(BuildContext context,
      {required Map<String,dynamic> params}) async {
    tableProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "current_power/", body: params);
    tableProvider.isLoading = false;

    if (response.hasError) return false;
    tableProvider.currentpowerTableData =
        CurrentPowerTableData().fromJsonList(response.data['data']);
    tableProvider.data =
        EmployeeDataSource(employeeData: tableProvider.currentpowerTableData);
    // String message = response.data['message'] ?? '';

    // if (message.isNotEmpty) showMessage(message);
    return true;
  }

  Future<bool> getGraphData(BuildContext context,
      {required String plantId}) async {
    tableProvider.isLoading = true;
    ResponseData response =
        await APIService().post(context, "current_power/", body: {
      "plant_id": plantId,
      "group_for": 'regular',
      "groupby": 'meter',
      "period_id": 'cur_shift',
      "limit_report_for": "exception",
      "limit_exception_for": "kwh",
      "limit_order_by": "desc",
      "limit_operation_value": "10",
    });
    tableProvider.isLoading = false;

    if (response.hasError) return false;
    tableProvider.topConsumptionGraphData =
        TopConsumptionnData().fromJsonList(response.data['data']);

    return true;
  }

  Future<bool> getPowerConsumptionData(BuildContext context,
      {required Map<String, dynamic> params}) async {
    tableProvider.isLoading = true;
    logger.f(params);

    ResponseData response =
        await APIService().post(context, "current_power/", body: params);
    tableProvider.isLoading = false;

    if (response.hasError) return false;
    // logger.f(response.data);
    tableProvider.detailPowerData(response.data["data"]);

    return true;
  }
}
