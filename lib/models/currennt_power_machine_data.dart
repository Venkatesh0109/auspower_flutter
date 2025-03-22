// To parse this JSON data, do
//
//     final currentPowerTableData = currentPowerTableDataFromJson(jsonString);

class CurrentPowerTableData {
  // String? companyCode;
  // String? companyName;
  // String? buCode;
  // String? buName;
  // String? plantCode;
  // String? plantName;
  // String? campusName;
  // String? plantDepartmentCode;
  // String? plantDepartmentName;
  // String? equipmentGroupCode;
  // String? equipmentGroupName;
  // String? equipmentCode;
  // String? equipmentName;
  // String? functionName;
  // String? functionCode;
  String? meterCode;
  String? meterName;
  // int? meterCount;
  // int? pmMeterCount;
  // int? powerId;
  // int? companyId;
  // int? buId;
  // int? plantId;
  // int? campusId;
  // int? plantDepartmentId;
  // int? equipmentGroupId;
  // int? equipmentId;
  // int? functionId;
  // String? equipmentClassId;
  // String? equipmentClassCode;
  // int? meterId;
  // int? designId;
  // int? beamId;
  DateTime? dateTime;
  // DateTime? dateTime1;
  // DateTime? millDate;
  // String? millShift;
  // int? meterStatusCode;
  String? meterType;
  // String? meterFormula;
  // String? equipmentIds;
  // dynamic vlnAvg;
  // dynamic rVolt;
  // dynamic yVolt;
  // dynamic bVolt;
  // dynamic vllAvg;
  // dynamic ryVolt;
  // dynamic ybVolt;
  // dynamic brVolt;
  // dynamic rCurrent;
  // dynamic yCurrent;
  // dynamic bCurrent;
  // dynamic tCurrent;
  // dynamic tWatts;
  // dynamic rWatts;
  // dynamic yWatts;
  // dynamic bWatts;
  // int? tVar;
  // int? rVar;
  // int? yVar;
  // int? bVar;
  dynamic tVoltampere;
  // int? rVoltampere;
  // int? yVoltampere;
  // int? bVoltampere;
  dynamic avgPowerfactor;
  // int? pmAvgPowerfactor;
  // dynamic rPowerfactor;
  // dynamic yPowerfactor;
  // dynamic bPowerfactor;
  // int? powerfactor;
  // int? kvah;
  dynamic kw;
  // int? kvar;
  // int? powerFactor;
  dynamic kva;
  // int? frequency;
  // int? machineStatus;
  // int? status;
  // DateTime? createdOn;
  // int? createdBy;
  // DateTime? modifiedOn;
  // int? modifiedBy;
  dynamic machineKWh;
  // dynamic masterKwh;
  dynamic kWh;
  // int? pmKwh;
  // int? totalKWh;
  // int? kwhMin;
  // int? kwhMax;
  // int? avgKWh;
  // String? minDate;
  // String? maxDate;
  // String? minShift;
  // String? maxShift;
  // int? reverseMachineKWh;
  // int? reverseMasterKwh;
  // int? reverseKwh;
  String? ipAddress;
  String? slaveId;
  // int? port;
  // String? mac;
  // int? kwh1;
  // int? kwh2;
  // int? kwh3;
  // dynamic startKwh1;
  // int? startKwh2;
  // int? startKwh3;
  // dynamic endKwh1;
  // int? endKwh2;
  // int? endKwh3;
  String? nocom;
  String? meterStatusDescription;
  // int? nocomSCount;
  // int? nocomNCount;
  // int? pmNocomSCount;
  // int? pmNocomNCount;
  // int? equipmentKwh;
  // int? units;
  // int? commonKwh;
  // int? pmEquipmentKwh;
  // int? unitsPerTon;
  // int? pmCommonKwh;
  // int? calculatedKwh;
  // String? tooltipKwh;
  // String? formula;
  // String? source;
  // int? demand;
  // int? dmPowerfactor;
  // int? actualDemand;
  // String? dDateTime;
  // int? maxDemand;
  // int? maxPf;
  // String? meter;
  // String? modelName;
  // String? modelMakeName;
  // int? actualTon;
  // String? runhour;
  // String? isPollMeter;
  // String? offTime;
  // String? idleTime;
  // String? onLoadTime;
  // String? totalTime;
  // int? onLoadKwh;
  // int? offKwh;
  // int? idleKwh;
  // int? groupId;
  // String? groupCode;
  // String? groupName;

  CurrentPowerTableData({
    // this.companyCode,
    // this.companyName,
    // this.buCode,
    // this.buName,
    // this.plantCode,
    // this.plantName,
    // this.campusName,
    // this.plantDepartmentCode,
    // this.plantDepartmentName,
    // this.equipmentGroupCode,
    // this.equipmentGroupName,
    // this.equipmentCode,
    // this.equipmentName,
    // this.functionName,
    // this.functionCode,
    this.meterCode,
    this.meterName,
    // this.meterCount,
    // this.pmMeterCount,
    // this.powerId,
    // this.companyId,
    // this.buId,
    // this.plantId,
    // this.campusId,
    // this.plantDepartmentId,
    // this.equipmentGroupId,
    // this.equipmentId,
    // this.functionId,
    // this.equipmentClassId,
    // this.equipmentClassCode,
    // this.meterId,
    // this.designId,
    // this.beamId,
    this.dateTime,
    // this.dateTime1,
    // this.millDate,
    // this.millShift,
    // this.meterStatusCode,
    this.meterType,
    // this.meterFormula,
    // this.equipmentIds,
    // this.vlnAvg,
    // this.rVolt,
    // this.yVolt,
    // this.bVolt,
    // this.vllAvg,
    // this.ryVolt,
    // this.ybVolt,
    // this.brVolt,
    // this.rCurrent,
    // this.yCurrent,
    // this.bCurrent,
    // this.tCurrent,
    // this.tWatts,
    // this.rWatts,
    // this.yWatts,
    // this.bWatts,
    // this.tVar,
    // this.rVar,
    // this.yVar,
    // this.bVar,
    this.tVoltampere,
    // this.rVoltampere,
    // this.yVoltampere,
    // this.bVoltampere,
    this.avgPowerfactor,
    // this.pmAvgPowerfactor,
    // this.rPowerfactor,
    // this.yPowerfactor,
    // this.bPowerfactor,
    // this.powerfactor,
    // this.kvah,
    this.kw,
    // this.kvar,
    // this.powerFactor,
    this.kva,
    // this.frequency,
    // this.machineStatus,
    // this.status,
    // this.createdOn,
    // this.createdBy,
    // this.modifiedOn,
    // this.modifiedBy,
    this.machineKWh,
    // this.masterKwh,
    this.kWh,
    // this.pmKwh,
    // this.totalKWh,
    // this.kwhMin,
    // this.kwhMax,
    // this.avgKWh,
    // this.minDate,
    // this.maxDate,
    // this.minShift,
    // this.maxShift,
    // this.reverseMachineKWh,
    // this.reverseMasterKwh,
    // this.reverseKwh,
    this.ipAddress,
    this.slaveId,
    // this.port,
    // this.mac,
    // this.kwh1,
    // this.kwh2,
    // this.kwh3,
    // this.startKwh1,
    // this.startKwh2,
    // this.startKwh3,
    // this.endKwh1,
    // this.endKwh2,
    // this.endKwh3,
    this.nocom,
    this.meterStatusDescription,
    // this.nocomSCount,
    // this.nocomNCount,
    // this.pmNocomSCount,
    // this.pmNocomNCount,
    // this.equipmentKwh,
    // this.units,
    // this.commonKwh,
    // this.pmEquipmentKwh,
    // this.unitsPerTon,
    // this.pmCommonKwh,
    // this.calculatedKwh,
    // this.tooltipKwh,
    // this.formula,
    // this.source,
    // this.demand,
    // this.dmPowerfactor,
    // this.actualDemand,
    // this.dDateTime,
    // this.maxDemand,
    // this.maxPf,
    // this.meter,
    // this.modelName,
    // this.modelMakeName,
    // this.actualTon,
    // this.runhour,
    // this.isPollMeter,
    // this.offTime,
    // this.idleTime,
    // this.onLoadTime,
    // this.totalTime,
    // this.onLoadKwh,
    // this.offKwh,
    // this.idleKwh,
    // this.groupId,
    // this.groupCode,
    // this.groupName,
  });

  factory CurrentPowerTableData.fromJson(Map<String, dynamic> json) =>
      CurrentPowerTableData(
        // companyCode: json["company_code"],
        // companyName: json["company_name"],
        // buCode: json["bu_code"],
        // buName: json["bu_name"],
        // plantCode: json["plant_code"],
        // plantName: json["plant_name"],
        // campusName: json["campus_name"],
        // plantDepartmentCode: json["plant_department_code"],
        // plantDepartmentName: json["plant_department_name"],
        // equipmentGroupCode: json["equipment_group_code"],
        // equipmentGroupName: json["equipment_group_name"],
        // equipmentCode: json["equipment_code"],
        // equipmentName: json["equipment_name"],
        // functionName: json["function_name"],
        // functionCode: json["function_code"],
        meterCode: json["meter_code"],
        meterName: json["meter_name"],
        // meterCount: json["meter_count"],
        // pmMeterCount: json["pm_meter_count"],
        // powerId: json["power_id"],
        // companyId: json["company_id"],
        // buId: json["bu_id"],
        // plantId: json["plant_id"],
        // campusId: json["campus_id"],
        // plantDepartmentId: json["plant_department_id"],
        // equipmentGroupId: json["equipment_group_id"],
        // equipmentId: json["equipment_id"],
        // functionId: json["function_id"],
        // equipmentClassId: json["equipment_class_id"],
        // equipmentClassCode: json["equipment_class_code"],
        // meterId: json["meter_id"],
        // designId: json["design_id"],
        // beamId: json["beam_id"],
        dateTime: json["date_time"] == null
            ? null
            : DateTime.parse(json["date_time"]),
        // dateTime1: json["date_time1"] == null ? null : DateTime.parse(json["date_time1"]),
        // millDate: json["mill_date"] == null ? null : DateTime.parse(json["mill_date"]),
        // millShift: json["mill_shift"],
        // meterStatusCode: json["meter_status_code"],
        meterType: json["meter_type"],
        // meterFormula: json["meter_formula"],
        // equipmentIds: json["equipment_ids"],
        // vlnAvg: json["vln_avg"]?.toDouble(),
        // rVolt: json["r_volt"]?.toDouble(),
        // yVolt: json["y_volt"]?.toDouble(),
        // bVolt: json["b_volt"]?.toDouble(),
        // vllAvg: json["vll_avg"]?.toDouble(),
        // ryVolt: json["ry_volt"]?.toDouble(),
        // ybVolt: json["yb_volt"]?.toDouble(),
        // brVolt: json["br_volt"]?.toDouble(),
        // rCurrent: json["r_current"]?.toDouble(),
        // yCurrent: json["y_current"]?.toDouble(),
        // bCurrent: json["b_current"]?.toDouble(),
        // tCurrent: json["t_current"]?.toDouble(),
        // tWatts: json["t_watts"]?.toDouble(),
        // rWatts: json["r_watts"]?.toDouble(),
        // yWatts: json["y_watts"]?.toDouble(),
        // bWatts: json["b_watts"]?.toDouble(),
        // tVar: json["t_var"],
        // rVar: json["r_var"],
        // yVar: json["y_var"],
        // bVar: json["b_var"],
        tVoltampere: json["t_voltampere"],
        // rVoltampere: json["r_voltampere"],
        // yVoltampere: json["y_voltampere"],
        // bVoltampere: json["b_voltampere"],
        avgPowerfactor: json["avg_powerfactor"],
        // pmAvgPowerfactor: json["pm_avg_powerfactor"],
        // rPowerfactor: json["r_powerfactor"]?.toDouble(),
        // yPowerfactor: json["y_powerfactor"]?.toDouble(),
        // bPowerfactor: json["b_powerfactor"]?.toDouble(),
        // powerfactor: json["powerfactor"],
        // kvah: json["kvah"],
        kw: json["kw"],
        // kvar: json["kvar"],
        // powerFactor: json["power_factor"],
        kva: json["kva"],
        // frequency: json["frequency"],
        // machineStatus: json["machine_status"],
        // status: json["status"],
        // createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
        // createdBy: json["created_by"],
        // modifiedOn: json["modified_on"] == null ? null : DateTime.parse(json["modified_on"]),
        // modifiedBy: json["modified_by"],
        machineKWh: json["machine_kWh"]?.toDouble(),
        // masterKwh: json["master_kwh"]?.toDouble(),
        kWh: json["kWh"],
        // pmKwh: json["pm_kwh"],
        // totalKWh: json["total_kWh"],
        // kwhMin: json["kwh_min"],
        // kwhMax: json["kwh_max"],
        // avgKWh: json["avg_kWh"],
        // minDate: json["min_date"],
        // maxDate: json["max_date"],
        // minShift: json["min_shift"],
        // maxShift: json["max_shift"],
        // reverseMachineKWh: json["reverse_machine_kWh"],
        // reverseMasterKwh: json["reverse_master_kwh"],
        // reverseKwh: json["reverse_kwh"],
        ipAddress: json["ip_address"],
        slaveId: json["slave_id"],
        // port: json["port"],
        // mac: json["mac"],
        // kwh1: json["kwh_1"],
        // kwh2: json["kwh_2"],
        // kwh3: json["kwh_3"],
        // startKwh1: json["start_kwh_1"]?.toDouble(),
        // startKwh2: json["start_kwh_2"],
        // startKwh3: json["start_kwh_3"],
        // endKwh1: json["end_kwh_1"]?.toDouble(),
        // endKwh2: json["end_kwh_2"],
        // endKwh3: json["end_kwh_3"],
        nocom: json["nocom"],
        meterStatusDescription: json["meter_status_description"],
        // nocomSCount: json["nocom_s_count"],
        // nocomNCount: json["nocom_n_count"],
        // pmNocomSCount: json["pm_nocom_s_count"],
        // pmNocomNCount: json["pm_nocom_n_count"],
        // equipmentKwh: json["equipment_kwh"],
        // units: json["units"],
        // commonKwh: json["common_kwh"],
        // pmEquipmentKwh: json["pm_equipment_kwh"],
        // unitsPerTon: json["units_per_ton"],
        // pmCommonKwh: json["pm_common_kwh"],
        // calculatedKwh: json["calculated_kwh"],
        // tooltipKwh: json["tooltip_kwh"],
        // formula: json["formula"],
        // source: json["source"],
        // demand: json["demand"],
        // dmPowerfactor: json["dm_powerfactor"],
        // actualDemand: json["actual_demand"],
        // dDateTime: json["d_date_time"],
        // maxDemand: json["max_demand"],
        // maxPf: json["max_pf"],
        // meter: json["meter"],
        // modelName: json["model_name"],
        // modelMakeName: json["model_make_name"],
        // actualTon: json["actual_ton"],
        // runhour: json["runhour"],
        // isPollMeter: json["is_poll_meter"],
        // offTime: json["off_time"],
        // idleTime: json["idle_time"],
        // onLoadTime: json["on_load_time"],
        // totalTime: json["total_time"],
        // onLoadKwh: json["on_load_kwh"],
        // offKwh: json["off_kwh"],
        // idleKwh: json["idle_kwh"],
        // groupId: json["group_id"],
        // groupCode: json["group_code"],
        // groupName: json["group_name"],
      );

  Map<String, dynamic> toJson() => {
        // "company_code": companyCode,
        // "company_name": companyName,
        // "bu_code": buCode,
        // "bu_name": buName,
        // "plant_code": plantCode,
        // "plant_name": plantName,
        // "campus_name": campusName,
        // "plant_department_code": plantDepartmentCode,
        // "plant_department_name": plantDepartmentName,
        // "equipment_group_code": equipmentGroupCode,
        // "equipment_group_name": equipmentGroupName,
        // "equipment_code": equipmentCode,
        // "equipment_name": equipmentName,
        // "function_name": functionName,
        // "function_code": functionCode,
        "meter_code": meterCode,
        "meter_name": meterName,
        // "meter_count": meterCount,
        // "pm_meter_count": pmMeterCount,
        // "power_id": powerId,
        // "company_id": companyId,
        // "bu_id": buId,
        // "plant_id": plantId,
        // "campus_id": campusId,
        // "plant_department_id": plantDepartmentId,
        // "equipment_group_id": equipmentGroupId,
        // "equipment_id": equipmentId,
        // "function_id": functionId,
        // "equipment_class_id": equipmentClassId,
        // "equipment_class_code": equipmentClassCode,
        // "meter_id": meterId,
        // "design_id": designId,
        // "beam_id": beamId,
        "date_time": dateTime?.toIso8601String(),
        // "date_time1": dateTime1?.toIso8601String(),
        // "mill_date": millDate?.toIso8601String(),
        // "mill_shift": millShift,
        // "meter_status_code": meterStatusCode,
        "meter_type": meterType,
        // "meter_formula": meterFormula,
        // "equipment_ids": equipmentIds,
        // "vln_avg": vlnAvg,
        // "r_volt": rVolt,
        // "y_volt": yVolt,
        // "b_volt": bVolt,
        // "vll_avg": vllAvg,
        // "ry_volt": ryVolt,
        // "yb_volt": ybVolt,
        // "br_volt": brVolt,
        // "r_current": rCurrent,
        // "y_current": yCurrent,
        // "b_current": bCurrent,
        // "t_current": tCurrent,
        // "t_watts": tWatts,
        // "r_watts": rWatts,
        // "y_watts": yWatts,
        // "b_watts": bWatts,
        // "t_var": tVar,
        // "r_var": rVar,
        // "y_var": yVar,
        // "b_var": bVar,
        "t_voltampere": tVoltampere,
        // "r_voltampere": rVoltampere,
        // "y_voltampere": yVoltampere,
        // "b_voltampere": bVoltampere,
        "avg_powerfactor": avgPowerfactor,
        // "pm_avg_powerfactor": pmAvgPowerfactor,
        // "r_powerfactor": rPowerfactor,
        // "y_powerfactor": yPowerfactor,
        // "b_powerfactor": bPowerfactor,
        // "powerfactor": powerfactor,
        // "kvah": kvah,
        "kw": kw,
        // "kvar": kvar,
        // "power_factor": powerFactor,
        "kva": kva,
        // "frequency": frequency,
        // "machine_status": machineStatus,
        // "status": status,
        // "created_on": createdOn?.toIso8601String(),
        // "created_by": createdBy,
        // "modified_on": modifiedOn?.toIso8601String(),
        // "modified_by": modifiedBy,
        "machine_kWh": machineKWh,
        // "master_kwh": masterKwh,
        "kWh": kWh,
        // "pm_kwh": pmKwh,
        // "total_kWh": totalKWh,
        // "kwh_min": kwhMin,
        // "kwh_max": kwhMax,
        // "avg_kWh": avgKWh,
        // "min_date": minDate,
        // "max_date": maxDate,
        // "min_shift": minShift,
        // "max_shift": maxShift,
        // "reverse_machine_kWh": reverseMachineKWh,
        // "reverse_master_kwh": reverseMasterKwh,
        // "reverse_kwh": reverseKwh,
        "ip_address": ipAddress,
        "slave_id": slaveId,
        // "port": port,
        // "mac": mac,
        // "kwh_1": kwh1,
        // "kwh_2": kwh2,
        // "kwh_3": kwh3,
        // "start_kwh_1": startKwh1,
        // "start_kwh_2": startKwh2,
        // "start_kwh_3": startKwh3,
        // "end_kwh_1": endKwh1,
        // "end_kwh_2": endKwh2,
        // "end_kwh_3": endKwh3,
        "nocom": nocom,
        "meter_status_description": meterStatusDescription,
        // "nocom_s_count": nocomSCount,
        // "nocom_n_count": nocomNCount,
        // "pm_nocom_s_count": pmNocomSCount,
        // "pm_nocom_n_count": pmNocomNCount,
        // "equipment_kwh": equipmentKwh,
        // "units": units,
        // "common_kwh": commonKwh,
        // "pm_equipment_kwh": pmEquipmentKwh,
        // "units_per_ton": unitsPerTon,
        // "pm_common_kwh": pmCommonKwh,
        // "calculated_kwh": calculatedKwh,
        // "tooltip_kwh": tooltipKwh,
        // "formula": formula,
        // "source": source,
        // "demand": demand,
        // "dm_powerfactor": dmPowerfactor,
        // "actual_demand": actualDemand,
        // "d_date_time": dDateTime,
        // "max_demand": maxDemand,
        // "max_pf": maxPf,
        // "meter": meter,
        // "model_name": modelName,
        // "model_make_name": modelMakeName,
        // "actual_ton": actualTon,
        // "runhour": runhour,
        // "is_poll_meter": isPollMeter,
        // "off_time": offTime,
        // "idle_time": idleTime,
        // "on_load_time": onLoadTime,
        // "total_time": totalTime,
        // "on_load_kwh": onLoadKwh,
        // "off_kwh": offKwh,
        // "idle_kwh": idleKwh,
        // "group_id": groupId,
        // "group_code": groupCode,
        // "group_name": groupName,
      };
  List<CurrentPowerTableData> fromJsonList(List data) {
    return data.map((e) => CurrentPowerTableData.fromJson(e)).toList();
  }
}
