// import 'dart:convert';

// class CompanyListModel {
//   final bool? iserror;
//   final String? message;
//   final List<CompanyListData>? companyListData;

//   CompanyListModel({
//     this.iserror,
//     this.message,
//     this.companyListData,
//   });

//   factory CompanyListModel.fromRawJson(String str) =>
//       CompanyListModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory CompanyListModel.fromJson(Map<String, dynamic> json) =>
//       CompanyListModel(
//         iserror: json["iserror"],
//         message: json["message"],
//         companyListData: json["data"] == null
//             ? []
//             : List<CompanyListData>.from(
//                 json["data"]!.map((x) => CompanyListData.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "iserror": iserror,
//         "message": message,
//         "data": companyListData == null
//             ? []
//             : List<dynamic>.from(companyListData!.map((x) => x.toJson())),
//       };
// }

// class CompanyListData {
//   final String? companyCode;
//   final String? companyName;
//   final String? buCode;
//   final String? buName;
//   final String? plantCode;
//   final String? plantName;
//   final String? campusName;
//   final String? plantDepartmentCode;
//   final String? plantDepartmentName;
//   final String? equipmentGroupCode;
//   final String? equipmentGroupName;
//   final String? equipmentCode;
//   final String? equipmentName;
//   final String? functionName;
//   final String? functionCode;
//   final String? meterCode;
//   final String? meterName;
//   final int? meterCount;
//   final int? pmMeterCount;
//   final int? powerId;
//   final int? companyId;
//   final int? buId;
//   final int? plantId;
//   final int? campusId;
//   final int? plantDepartmentId;
//   final int? equipmentGroupId;
//   final int? equipmentId;
//   final int? functionId;
//   final String? equipmentClassId;
//   final String? equipmentClassCode;
//   final int? meterId;
//   final int? designId;
//   final int? beamId;
//   final DateTime? dateTime;
//   final DateTime? dateTime1;
//   final DateTime? millDate;
//   final String? millShift;
//   final int? meterStatusCode;
//   final String? meterType;
//   final String? meterFormula;
//   final String? equipmentIds;
//   final String? vlnAvgThd;
//   final String? vlnAvg;
//   final String? rVolt;
//   final String? yVolt;
//   final String? bVolt;
//   final String? vllAvg;
//   final String? vllAvgThd;
//   final String? ryVolt;
//   final String? ybVolt;
//   final String? brVolt;
//   final String? rCurrent;
//   final String? yCurrent;
//   final String? bCurrent;
//   final String? tCurrent;
//   final String? tWatts;
//   final String? rWatts;
//   final String? yWatts;
//   final String? bWatts;
//   final String? tVar;
//   final String? rVar;
//   final String? yVar;
//   final String? bVar;
//   final String? tVoltampere;
//   final String? rVoltampere;
//   final String? yVoltampere;
//   final String? bVoltampere;
//   final double? avgPowerfactor;
//   final double? pmAvgPowerfactor;
//   final String? rPowerfactor;
//   final String? yPowerfactor;
//   final String? bPowerfactor;
//   final String? powerfactor;
//   final String? kvah;
//   final String? kw;
//   final String? kvar;
//   final String? powerFactor;
//   final dynamic kva;
//   final String? frequency;
//   final int? machineStatus;
//   final int? status;
//   final DateTime? createdOn;
//   final int? createdBy;
//   final DateTime? modifiedOn;
//   final dynamic modifiedBy;
//   final dynamic machineKWh;
//   final dynamic masterKwh;
//   final dynamic kWh;
//   final dynamic pmKwh;
//   final dynamic totalKWh;
//   final dynamic kwhMin;
//   final dynamic kwhMax;
//   final dynamic avgKWh;
//   final String? minDate;
//   final String? maxDate;
//   final String? minShift;
//   final String? maxShift;
//   final double? reverseMachineKWh;
//   final double? reverseMasterKwh;
//   final dynamic reverseKwh;
//   final String? ipAddress;
//   final String? slaveId;
//   final dynamic port;
//   final String? mac;
//   final dynamic kwh1;
//   final dynamic kwh2;
//   final dynamic kwh3;
//   final dynamic startKwh1;
//   final dynamic startKwh2;
//   final dynamic startKwh3;
//   final dynamic endKwh1;
//   final dynamic endKwh2;
//   final dynamic endKwh3;
//   final String? nocom;
//   final String? meterStatusDescription;
//   final dynamic nocomSCount;
//   final dynamic nocomNCount;
//   final dynamic pmNocomSCount;
//   final dynamic pmNocomNCount;
//   final dynamic equipmentKwh;
//   final dynamic units;
//   final dynamic commonKwh;
//   final dynamic pmEquipmentKwh;
//   final dynamic unitsPerTon;
//   final dynamic pmCommonKwh;
//   final dynamic calculatedKwh;
//   final String? tooltipKwh;
//   final String? formula;
//   final String? source;
//   final dynamic demand;
//   final double? dmPowerfactor;
//   final dynamic actualDemand;
//   final DateTime? dDateTime;
//   final dynamic maxDemand;
//   final dynamic maxPf;
//   final String? meter;
//   final String? modelName;
//   final String? modelMakeName;
//   final dynamic actualTon;
//   final String? runhour;
//   final String? rVoltThd;
//   final String? yVoltThd;
//   final String? bVoltThd;
//   final String? avgVoltThd;
//   final String? rCurrentThd;
//   final String? yCurrentThd;
//   final String? bCurrentThd;
//   final String? avgCurrentThd;
//   final String? ryVoltThd;
//   final String? ybVoltThd;
//   final String? brVoltThd;
//   final String? isPollMeter;
//   final String? machineKwhFactor;
//   final double? machineKWhValue;
//   final String? onLoadTime;
//   final String? idleTime;
//   final String? offTime;
//   final String? totalTime;
//   final dynamic onLoadKwh;
//   final dynamic offKwh;
//   final dynamic idleKwh;
//   final dynamic groupId;
//   final String? groupCode;
//   final String? groupName;

//   CompanyListData({
//     this.companyCode,
//     this.companyName,
//     this.buCode,
//     this.buName,
//     this.plantCode,
//     this.plantName,
//     this.campusName,
//     this.plantDepartmentCode,
//     this.plantDepartmentName,
//     this.equipmentGroupCode,
//     this.equipmentGroupName,
//     this.equipmentCode,
//     this.equipmentName,
//     this.functionName,
//     this.functionCode,
//     this.meterCode,
//     this.meterName,
//     this.meterCount,
//     this.pmMeterCount,
//     this.powerId,
//     this.companyId,
//     this.buId,
//     this.plantId,
//     this.campusId,
//     this.plantDepartmentId,
//     this.equipmentGroupId,
//     this.equipmentId,
//     this.functionId,
//     this.equipmentClassId,
//     this.equipmentClassCode,
//     this.meterId,
//     this.designId,
//     this.beamId,
//     this.dateTime,
//     this.dateTime1,
//     this.millDate,
//     this.millShift,
//     this.meterStatusCode,
//     this.meterType,
//     this.meterFormula,
//     this.equipmentIds,
//     this.vlnAvgThd,
//     this.vlnAvg,
//     this.rVolt,
//     this.yVolt,
//     this.bVolt,
//     this.vllAvg,
//     this.vllAvgThd,
//     this.ryVolt,
//     this.ybVolt,
//     this.brVolt,
//     this.rCurrent,
//     this.yCurrent,
//     this.bCurrent,
//     this.tCurrent,
//     this.tWatts,
//     this.rWatts,
//     this.yWatts,
//     this.bWatts,
//     this.tVar,
//     this.rVar,
//     this.yVar,
//     this.bVar,
//     this.tVoltampere,
//     this.rVoltampere,
//     this.yVoltampere,
//     this.bVoltampere,
//     this.avgPowerfactor,
//     this.pmAvgPowerfactor,
//     this.rPowerfactor,
//     this.yPowerfactor,
//     this.bPowerfactor,
//     this.powerfactor,
//     this.kvah,
//     this.kw,
//     this.kvar,
//     this.powerFactor,
//     this.kva,
//     this.frequency,
//     this.machineStatus,
//     this.status,
//     this.createdOn,
//     this.createdBy,
//     this.modifiedOn,
//     this.modifiedBy,
//     this.machineKWh,
//     this.masterKwh,
//     this.kWh,
//     this.pmKwh,
//     this.totalKWh,
//     this.kwhMin,
//     this.kwhMax,
//     this.avgKWh,
//     this.minDate,
//     this.maxDate,
//     this.minShift,
//     this.maxShift,
//     this.reverseMachineKWh,
//     this.reverseMasterKwh,
//     this.reverseKwh,
//     this.ipAddress,
//     this.slaveId,
//     this.port,
//     this.mac,
//     this.kwh1,
//     this.kwh2,
//     this.kwh3,
//     this.startKwh1,
//     this.startKwh2,
//     this.startKwh3,
//     this.endKwh1,
//     this.endKwh2,
//     this.endKwh3,
//     this.nocom,
//     this.meterStatusDescription,
//     this.nocomSCount,
//     this.nocomNCount,
//     this.pmNocomSCount,
//     this.pmNocomNCount,
//     this.equipmentKwh,
//     this.units,
//     this.commonKwh,
//     this.pmEquipmentKwh,
//     this.unitsPerTon,
//     this.pmCommonKwh,
//     this.calculatedKwh,
//     this.tooltipKwh,
//     this.formula,
//     this.source,
//     this.demand,
//     this.dmPowerfactor,
//     this.actualDemand,
//     this.dDateTime,
//     this.maxDemand,
//     this.maxPf,
//     this.meter,
//     this.modelName,
//     this.modelMakeName,
//     this.actualTon,
//     this.runhour,
//     this.rVoltThd,
//     this.yVoltThd,
//     this.bVoltThd,
//     this.avgVoltThd,
//     this.rCurrentThd,
//     this.yCurrentThd,
//     this.bCurrentThd,
//     this.avgCurrentThd,
//     this.ryVoltThd,
//     this.ybVoltThd,
//     this.brVoltThd,
//     this.isPollMeter,
//     this.machineKwhFactor,
//     this.machineKWhValue,
//     this.onLoadTime,
//     this.idleTime,
//     this.offTime,
//     this.totalTime,
//     this.onLoadKwh,
//     this.offKwh,
//     this.idleKwh,
//     this.groupId,
//     this.groupCode,
//     this.groupName,
//   });

//   factory CompanyListData.fromRawJson(String str) =>
//       CompanyListData.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory CompanyListData.fromJson(Map<String, dynamic> json) =>
//       CompanyListData(
//         companyCode: json["company_code"],
//         companyName: json["company_name"],
//         buCode: json["bu_code"],
//         buName: json["bu_name"],
//         plantCode: json["plant_code"],
//         plantName: json["plant_name"],
//         campusName: json["campus_name"],
//         plantDepartmentCode: json["plant_department_code"],
//         plantDepartmentName: json["plant_department_name"],
//         equipmentGroupCode: json["equipment_group_code"],
//         equipmentGroupName: json["equipment_group_name"],
//         equipmentCode: json["equipment_code"],
//         equipmentName: json["equipment_name"],
//         functionName: json["function_name"],
//         functionCode: json["function_code"],
//         meterCode: json["meter_code"],
//         meterName: json["meter_name"],
//         meterCount: json["meter_count"],
//         pmMeterCount: json["pm_meter_count"],
//         powerId: json["power_id"],
//         companyId: json["company_id"],
//         buId: json["bu_id"],
//         plantId: json["plant_id"],
//         campusId: json["campus_id"],
//         plantDepartmentId: json["plant_department_id"],
//         equipmentGroupId: json["equipment_group_id"],
//         equipmentId: json["equipment_id"],
//         functionId: json["function_id"],
//         equipmentClassId: json["equipment_class_id"],
//         equipmentClassCode: json["equipment_class_code"],
//         meterId: json["meter_id"],
//         designId: json["design_id"],
//         beamId: json["beam_id"],
//         dateTime: json["date_time"] == null
//             ? null
//             : DateTime.parse(json["date_time"]),
//         dateTime1: json["date_time1"] == null
//             ? null
//             : DateTime.parse(json["date_time1"]),
//         millDate: json["mill_date"] == null
//             ? null
//             : DateTime.parse(json["mill_date"]),
//         millShift: json["mill_shift"],
//         meterStatusCode: json["meter_status_code"],
//         meterType: json["meter_type"],
//         meterFormula: json["meter_formula"],
//         equipmentIds: json["equipment_ids"],
//         vlnAvgThd: json["vln_avg_thd"],
//         vlnAvg: json["vln_avg"],
//         rVolt: json["r_volt"],
//         yVolt: json["y_volt"],
//         bVolt: json["b_volt"],
//         vllAvg: json["vll_avg"],
//         vllAvgThd: json["vll_avg_thd"],
//         ryVolt: json["ry_volt"],
//         ybVolt: json["yb_volt"],
//         brVolt: json["br_volt"],
//         rCurrent: json["r_current"],
//         yCurrent: json["y_current"],
//         bCurrent: json["b_current"],
//         tCurrent: json["t_current"],
//         tWatts: json["t_watts"],
//         rWatts: json["r_watts"],
//         yWatts: json["y_watts"],
//         bWatts: json["b_watts"],
//         tVar: json["t_var"],
//         rVar: json["r_var"],
//         yVar: json["y_var"],
//         bVar: json["b_var"],
//         tVoltampere: json["t_voltampere"],
//         rVoltampere: json["r_voltampere"],
//         yVoltampere: json["y_voltampere"],
//         bVoltampere: json["b_voltampere"],
//         avgPowerfactor: json["avg_powerfactor"]?.toDouble(),
//         pmAvgPowerfactor: json["pm_avg_powerfactor"]?.toDouble(),
//         rPowerfactor: json["r_powerfactor"],
//         yPowerfactor: json["y_powerfactor"],
//         bPowerfactor: json["b_powerfactor"],
//         powerfactor: json["powerfactor"],
//         kvah: json["kvah"],
//         kw: json["kw"],
//         kvar: json["kvar"],
//         powerFactor: json["power_factor"],
//         kva: json["kva"],
//         frequency: json["frequency"],
//         machineStatus: json["machine_status"],
//         status: json["status"],
//         createdOn: json["created_on"] == null
//             ? null
//             : DateTime.parse(json["created_on"]),
//         createdBy: json["created_by"],
//         modifiedOn: json["modified_on"] == null
//             ? null
//             : DateTime.parse(json["modified_on"]),
//         modifiedBy: json["modified_by"],
//         machineKWh: json["machine_kWh"],
//         masterKwh: json["master_kwh"],
//         kWh: json["kWh"],
//         pmKwh: json["pm_kwh"],
//         totalKWh: json["total_kWh"],
//         kwhMin: json["kwh_min"],
//         kwhMax: json["kwh_max"],
//         avgKWh: json["avg_kWh"],
//         minDate: json["min_date"],
//         maxDate: json["max_date"],
//         minShift: json["min_shift"],
//         maxShift: json["max_shift"],
//         reverseMachineKWh: json["reverse_machine_kWh"],
//         reverseMasterKwh: json["reverse_master_kwh"],
//         reverseKwh: json["reverse_kwh"],
//         ipAddress: json["ip_address"],
//         slaveId: json["slave_id"],
//         port: json["port"],
//         mac: json["mac"],
//         kwh1: json["kwh_1"],
//         kwh2: json["kwh_2"],
//         kwh3: json["kwh_3"],
//         startKwh1: json["start_kwh_1"],
//         startKwh2: json["start_kwh_2"],
//         startKwh3: json["start_kwh_3"],
//         endKwh1: json["end_kwh_1"],
//         endKwh2: json["end_kwh_2"],
//         endKwh3: json["end_kwh_3"],
//         nocom: json["nocom"],
//         meterStatusDescription: json["meter_status_description"],
//         nocomSCount: json["nocom_s_count"],
//         nocomNCount: json["nocom_n_count"],
//         pmNocomSCount: json["pm_nocom_s_count"],
//         pmNocomNCount: json["pm_nocom_n_count"],
//         equipmentKwh: json["equipment_kwh"],
//         units: json["units"],
//         commonKwh: json["common_kwh"],
//         pmEquipmentKwh: json["pm_equipment_kwh"],
//         unitsPerTon: json["units_per_ton"],
//         pmCommonKwh: json["pm_common_kwh"],
//         calculatedKwh: json["calculated_kwh"],
//         tooltipKwh: json["tooltip_kwh"],
//         formula: json["formula"],
//         source: json["source"],
//         demand: json["demand"],
//         dmPowerfactor: json["dm_powerfactor"]?.toDouble(),
//         actualDemand: json["actual_demand"],
//         dDateTime: json["d_date_time"] == null
//             ? null
//             : DateTime.parse(json["d_date_time"]),
//         maxDemand: json["max_demand"],
//         maxPf: json["max_pf"],
//         meter: json["meter"],
//         modelName: json["model_name"],
//         modelMakeName: json["model_make_name"],
//         actualTon: json["actual_ton"],
//         runhour: json["runhour"],
//         rVoltThd: json["r_volt_thd"],
//         yVoltThd: json["y_volt_thd"],
//         bVoltThd: json["b_volt_thd"],
//         avgVoltThd: json["avg_volt_thd"],
//         rCurrentThd: json["r_current_thd"],
//         yCurrentThd: json["y_current_thd"],
//         bCurrentThd: json["b_current_thd"],
//         avgCurrentThd: json["avg_current_thd"],
//         ryVoltThd: json["ry_volt_thd"],
//         ybVoltThd: json["yb_volt_thd"],
//         brVoltThd: json["br_volt_thd"],
//         isPollMeter: json["is_poll_meter"],
//         machineKwhFactor: json["machine_kwh_factor"],
//         machineKWhValue: json["machine_kWh_value"],
//         onLoadTime: json["on_load_time"],
//         idleTime: json["idle_time"],
//         offTime: json["off_time"],
//         totalTime: json["total_time"],
//         onLoadKwh: json["on_load_kwh"],
//         offKwh: json["off_kwh"],
//         idleKwh: json["idle_kwh"],
//         groupId: json["group_id"],
//         groupCode: json["group_code"],
//         groupName: json["group_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "company_code": companyCode,
//         "company_name": companyName,
//         "bu_code": buCode,
//         "bu_name": buName,
//         "plant_code": plantCode,
//         "plant_name": plantName,
//         "campus_name": campusName,
//         "plant_department_code": plantDepartmentCode,
//         "plant_department_name": plantDepartmentName,
//         "equipment_group_code": equipmentGroupCode,
//         "equipment_group_name": equipmentGroupName,
//         "equipment_code": equipmentCode,
//         "equipment_name": equipmentName,
//         "function_name": functionName,
//         "function_code": functionCode,
//         "meter_code": meterCode,
//         "meter_name": meterName,
//         "meter_count": meterCount,
//         "pm_meter_count": pmMeterCount,
//         "power_id": powerId,
//         "company_id": companyId,
//         "bu_id": buId,
//         "plant_id": plantId,
//         "campus_id": campusId,
//         "plant_department_id": plantDepartmentId,
//         "equipment_group_id": equipmentGroupId,
//         "equipment_id": equipmentId,
//         "function_id": functionId,
//         "equipment_class_id": equipmentClassId,
//         "equipment_class_code": equipmentClassCode,
//         "meter_id": meterId,
//         "design_id": designId,
//         "beam_id": beamId,
//         "date_time": dateTime?.toIso8601String(),
//         "date_time1": dateTime1?.toIso8601String(),
//         "mill_date": millDate?.toIso8601String(),
//         "mill_shift": millShift,
//         "meter_status_code": meterStatusCode,
//         "meter_type": meterType,
//         "meter_formula": meterFormula,
//         "equipment_ids": equipmentIds,
//         "vln_avg_thd": vlnAvgThd,
//         "vln_avg": vlnAvg,
//         "r_volt": rVolt,
//         "y_volt": yVolt,
//         "b_volt": bVolt,
//         "vll_avg": vllAvg,
//         "vll_avg_thd": vllAvgThd,
//         "ry_volt": ryVolt,
//         "yb_volt": ybVolt,
//         "br_volt": brVolt,
//         "r_current": rCurrent,
//         "y_current": yCurrent,
//         "b_current": bCurrent,
//         "t_current": tCurrent,
//         "t_watts": tWatts,
//         "r_watts": rWatts,
//         "y_watts": yWatts,
//         "b_watts": bWatts,
//         "t_var": tVar,
//         "r_var": rVar,
//         "y_var": yVar,
//         "b_var": bVar,
//         "t_voltampere": tVoltampere,
//         "r_voltampere": rVoltampere,
//         "y_voltampere": yVoltampere,
//         "b_voltampere": bVoltampere,
//         "avg_powerfactor": avgPowerfactor,
//         "pm_avg_powerfactor": pmAvgPowerfactor,
//         "r_powerfactor": rPowerfactor,
//         "y_powerfactor": yPowerfactor,
//         "b_powerfactor": bPowerfactor,
//         "powerfactor": powerfactor,
//         "kvah": kvah,
//         "kw": kw,
//         "kvar": kvar,
//         "power_factor": powerFactor,
//         "kva": kva,
//         "frequency": frequency,
//         "machine_status": machineStatus,
//         "status": status,
//         "created_on": createdOn?.toIso8601String(),
//         "created_by": createdBy,
//         "modified_on": modifiedOn?.toIso8601String(),
//         "modified_by": modifiedBy,
//         "machine_kWh": machineKWh,
//         "master_kwh": masterKwh,
//         "kWh": kWh,
//         "pm_kwh": pmKwh,
//         "total_kWh": totalKWh,
//         "kwh_min": kwhMin,
//         "kwh_max": kwhMax,
//         "avg_kWh": avgKWh,
//         "min_date": minDate,
//         "max_date": maxDate,
//         "min_shift": minShift,
//         "max_shift": maxShift,
//         "reverse_machine_kWh": reverseMachineKWh,
//         "reverse_master_kwh": reverseMasterKwh,
//         "reverse_kwh": reverseKwh,
//         "ip_address": ipAddress,
//         "slave_id": slaveId,
//         "port": port,
//         "mac": mac,
//         "kwh_1": kwh1,
//         "kwh_2": kwh2,
//         "kwh_3": kwh3,
//         "start_kwh_1": startKwh1,
//         "start_kwh_2": startKwh2,
//         "start_kwh_3": startKwh3,
//         "end_kwh_1": endKwh1,
//         "end_kwh_2": endKwh2,
//         "end_kwh_3": endKwh3,
//         "nocom": nocom,
//         "meter_status_description": meterStatusDescription,
//         "nocom_s_count": nocomSCount,
//         "nocom_n_count": nocomNCount,
//         "pm_nocom_s_count": pmNocomSCount,
//         "pm_nocom_n_count": pmNocomNCount,
//         "equipment_kwh": equipmentKwh,
//         "units": units,
//         "common_kwh": commonKwh,
//         "pm_equipment_kwh": pmEquipmentKwh,
//         "units_per_ton": unitsPerTon,
//         "pm_common_kwh": pmCommonKwh,
//         "calculated_kwh": calculatedKwh,
//         "tooltip_kwh": tooltipKwh,
//         "formula": formula,
//         "source": source,
//         "demand": demand,
//         "dm_powerfactor": dmPowerfactor,
//         "actual_demand": actualDemand,
//         "d_date_time": dDateTime?.toIso8601String(),
//         "max_demand": maxDemand,
//         "max_pf": maxPf,
//         "meter": meter,
//         "model_name": modelName,
//         "model_make_name": modelMakeName,
//         "actual_ton": actualTon,
//         "runhour": runhour,
//         "r_volt_thd": rVoltThd,
//         "y_volt_thd": yVoltThd,
//         "b_volt_thd": bVoltThd,
//         "avg_volt_thd": avgVoltThd,
//         "r_current_thd": rCurrentThd,
//         "y_current_thd": yCurrentThd,
//         "b_current_thd": bCurrentThd,
//         "avg_current_thd": avgCurrentThd,
//         "ry_volt_thd": ryVoltThd,
//         "yb_volt_thd": ybVoltThd,
//         "br_volt_thd": brVoltThd,
//         "is_poll_meter": isPollMeter,
//         "machine_kwh_factor": machineKwhFactor,
//         "machine_kWh_value": machineKWhValue,
//         "on_load_time": onLoadTime,
//         "idle_time": idleTime,
//         "off_time": offTime,
//         "total_time": totalTime,
//         "on_load_kwh": onLoadKwh,
//         "off_kwh": offKwh,
//         "idle_kwh": idleKwh,
//         "group_id": groupId,
//         "group_code": groupCode,
//         "group_name": groupName,
//       };
// }

import 'dart:convert';

class CompanyListModel {
  final bool? iserror;
  final String? message;
  final List<CompanyListData>? companyListData;

  CompanyListModel({
    this.iserror,
    this.message,
    this.companyListData,
  });

  factory CompanyListModel.fromRawJson(String str) =>
      CompanyListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyListModel.fromJson(Map<String, dynamic> json) =>
      CompanyListModel(
        iserror: json["iserror"],
        message: json["message"],
        companyListData: json["data"] == null
            ? []
            : List<CompanyListData>.from(
                json["data"]!.map((x) => CompanyListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "iserror": iserror,
        "message": message,
        "data": companyListData == null
            ? []
            : List<dynamic>.from(companyListData!.map((x) => x.toJson())),
      };
}

class CompanyListData {
  final String? companyCode;
  final String? companyName;
  final int? pmMeterCount;
  final int? companyId;
  final int? campusId;
  final dynamic pmNocomSCount;
  final dynamic pmNocomNCount;
  final dynamic pmEquipmentKwh;
  final dynamic pmCommonKwh;
  final dynamic onLoadKwh;
  final dynamic offKwh;
  final dynamic idleKwh;

  CompanyListData({
    this.companyCode,
    this.companyName,
    this.pmMeterCount,
    this.companyId,
    this.campusId,
    this.pmNocomSCount,
    this.pmNocomNCount,
    this.pmEquipmentKwh,
    this.pmCommonKwh,
    this.onLoadKwh,
    this.offKwh,
    this.idleKwh,
  });

  factory CompanyListData.fromRawJson(String str) =>
      CompanyListData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyListData.fromJson(Map<String, dynamic> json) =>
      CompanyListData(
        companyCode: json["company_code"],
        companyName: json["company_name"],
        pmMeterCount: json["pm_meter_count"],
        companyId: json["company_id"],
        campusId: json["campus_id"],
        pmNocomSCount: json["pm_nocom_s_count"],
        pmNocomNCount: json["pm_nocom_n_count"],
        pmEquipmentKwh: json["pm_equipment_kwh"],
        pmCommonKwh: json["pm_common_kwh"],
        onLoadKwh: json["on_load_kwh"],
        offKwh: json["off_kwh"],
        idleKwh: json["idle_kwh"],
      );

  Map<String, dynamic> toJson() => {
        "company_code": companyCode,
        "company_name": companyName,
        "pm_meter_count": pmMeterCount,
        "company_id": companyId,
        "campus_id": campusId,
        "pm_nocom_s_count": pmNocomSCount,
        "pm_nocom_n_count": pmNocomNCount,
        "pm_equipment_kwh": pmEquipmentKwh,
        "pm_common_kwh": pmCommonKwh,
        "on_load_kwh": onLoadKwh,
        "off_kwh": offKwh,
        "idle_kwh": idleKwh,
      };
}
