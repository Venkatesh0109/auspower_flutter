class PlantListModel {
  bool? iserror;
  String? message;
  List<PlantListData>? data;

  PlantListModel({this.iserror, this.message, this.data});

  PlantListModel.fromJson(Map<String, dynamic> json) {
    iserror = json['iserror'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PlantListData>[];
      json['data'].forEach((v) {
        data!.add(new PlantListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iserror'] = iserror;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlantListData {
  String? companyCode;
  String? companyName;
  String? buCode;
  String? buName;
  String? plantCode;
  String? plantName;
  String? campusName;
  String? plantDepartmentCode;
  String? plantDepartmentName;
  String? equipmentGroupCode;
  String? equipmentGroupName;
  String? equipmentCode;
  String? equipmentName;
  String? functionName;
  String? functionCode;
  String? meterCode;
  String? meterName;
  int? meterCount;
  int? pmMeterCount;
  int? powerId;
  int? companyId;
  int? buId;
  int? plantId;
  int? campusId;
  int? plantDepartmentId;
  int? equipmentGroupId;
  int? equipmentId;
  int? functionId;
  String? equipmentClassId;
  String? equipmentClassCode;
  int? meterId;
  int? designId;
  int? beamId;
  String? dateTime;
  String? dateTime1;
  String? millDate;
  String? millShift;
  int? meterStatusCode;
  String? meterType;
  String? meterFormula;
  String? equipmentIds;
  dynamic vlnAvg;
  dynamic rVolt;
  dynamic yVolt;
  dynamic bVolt;
  dynamic vllAvg;
  dynamic ryVolt;
  dynamic ybVolt;
  dynamic brVolt;
  dynamic rCurrent;
  dynamic yCurrent;
  dynamic bCurrent;
  dynamic tCurrent;
  dynamic tWatts;
  dynamic rWatts;
  dynamic yWatts;
  dynamic bWatts;
  dynamic tVar;
  dynamic rVar;
  dynamic yVar;
  dynamic bVar;
  dynamic tVoltampere;
  dynamic rVoltampere;
  dynamic yVoltampere;
  dynamic bVoltampere;
  dynamic avgPowerfactor;
  dynamic pmAvgPowerfactor;
  dynamic rPowerfactor;
  dynamic yPowerfactor;
  dynamic bPowerfactor;
  dynamic powerfactor;
  dynamic kvah;
  dynamic kw;
  dynamic kvar;
  dynamic powerFactor;
  dynamic kva;
  dynamic frequency;
  int? machineStatus;
  int? status;
  String? createdOn;
  int? createdBy;
  String? modifiedOn;
  int? modifiedBy;
  dynamic machineKWh;
  dynamic masterKwh;
  dynamic kWh;
  dynamic pmKwh;
  dynamic totalKWh;
  dynamic kwhMin;
  dynamic kwhMax;
  dynamic avgKWh;
  String? minDate;
  String? maxDate;
  String? minShift;
  String? maxShift;
  dynamic reverseMachineKWh;
  dynamic reverseMasterKwh;
  dynamic reverseKwh;
  String? ipAddress;
  String? slaveId;
  int? port;
  String? mac;
  dynamic kwh1;
  dynamic kwh2;
  dynamic kwh3;
  dynamic startKwh1;
  dynamic startKwh2;
  dynamic startKwh3;
  dynamic endKwh1;
  dynamic endKwh2;
  dynamic endKwh3;
  String? nocom;
  String? meterStatusDescription;
  int? nocomSCount;
  int? nocomNCount;
  int? pmNocomSCount;
  int? pmNocomNCount;
  dynamic equipmentKwh;
  dynamic commonKwh;
  dynamic pmEquipmentKwh;
  dynamic unitsPerTon;
  dynamic pmCommonKwh;
  dynamic calculatedKwh;
  String? tooltipKwh;
  String? formula;
  dynamic demand;
  dynamic dmPowerfactor;
  dynamic actualDemand;
  String? dDateTime;
  int? maxDemand;
  int? maxPf;
  String? meter;
  String? modelName;
  String? modelMakeName;
  dynamic actualTon;
  String? onLoadTime;
  String? idleTime;
  String? offTime;
  String? totalTime;
  dynamic onLoadKwh;
  dynamic offKwh;
  dynamic idleKwh;
  int? groupId;
  String? groupCode;
  String? groupName;

  PlantListData(
      {this.companyCode,
      this.companyName,
      this.buCode,
      this.buName,
      this.plantCode,
      this.plantName,
      this.campusName,
      this.plantDepartmentCode,
      this.plantDepartmentName,
      this.equipmentGroupCode,
      this.equipmentGroupName,
      this.equipmentCode,
      this.equipmentName,
      this.functionName,
      this.functionCode,
      this.meterCode,
      this.meterName,
      this.meterCount,
      this.pmMeterCount,
      this.powerId,
      this.companyId,
      this.buId,
      this.plantId,
      this.campusId,
      this.plantDepartmentId,
      this.equipmentGroupId,
      this.equipmentId,
      this.functionId,
      this.equipmentClassId,
      this.equipmentClassCode,
      this.meterId,
      this.designId,
      this.beamId,
      this.dateTime,
      this.dateTime1,
      this.millDate,
      this.millShift,
      this.meterStatusCode,
      this.meterType,
      this.meterFormula,
      this.equipmentIds,
      this.vlnAvg,
      this.rVolt,
      this.yVolt,
      this.bVolt,
      this.vllAvg,
      this.ryVolt,
      this.ybVolt,
      this.brVolt,
      this.rCurrent,
      this.yCurrent,
      this.bCurrent,
      this.tCurrent,
      this.tWatts,
      this.rWatts,
      this.yWatts,
      this.bWatts,
      this.tVar,
      this.rVar,
      this.yVar,
      this.bVar,
      this.tVoltampere,
      this.rVoltampere,
      this.yVoltampere,
      this.bVoltampere,
      this.avgPowerfactor,
      this.pmAvgPowerfactor,
      this.rPowerfactor,
      this.yPowerfactor,
      this.bPowerfactor,
      this.powerfactor,
      this.kvah,
      this.kw,
      this.kvar,
      this.powerFactor,
      this.kva,
      this.frequency,
      this.machineStatus,
      this.status,
      this.createdOn,
      this.createdBy,
      this.modifiedOn,
      this.modifiedBy,
      this.machineKWh,
      this.masterKwh,
      this.kWh,
      this.pmKwh,
      this.totalKWh,
      this.kwhMin,
      this.kwhMax,
      this.avgKWh,
      this.minDate,
      this.maxDate,
      this.minShift,
      this.maxShift,
      this.reverseMachineKWh,
      this.reverseMasterKwh,
      this.reverseKwh,
      this.ipAddress,
      this.slaveId,
      this.port,
      this.mac,
      this.kwh1,
      this.kwh2,
      this.kwh3,
      this.startKwh1,
      this.startKwh2,
      this.startKwh3,
      this.endKwh1,
      this.endKwh2,
      this.endKwh3,
      this.nocom,
      this.meterStatusDescription,
      this.nocomSCount,
      this.nocomNCount,
      this.pmNocomSCount,
      this.pmNocomNCount,
      this.equipmentKwh,
      this.commonKwh,
      this.pmEquipmentKwh,
      this.unitsPerTon,
      this.pmCommonKwh,
      this.calculatedKwh,
      this.tooltipKwh,
      this.formula,
      this.demand,
      this.dmPowerfactor,
      this.actualDemand,
      this.dDateTime,
      this.maxDemand,
      this.maxPf,
      this.meter,
      this.modelName,
      this.modelMakeName,
      this.actualTon,
      this.onLoadTime,
      this.idleTime,
      this.offTime,
      this.totalTime,
      this.onLoadKwh,
      this.offKwh,
      this.idleKwh,
      this.groupId,
      this.groupCode,
      this.groupName});

  PlantListData.fromJson(Map<String, dynamic> json) {
    companyCode = json['company_code'];
    companyName = json['company_name'];
    buCode = json['bu_code'];
    buName = json['bu_name'];
    plantCode = json['plant_code'];
    plantName = json['plant_name'];
    campusName = json['campus_name'];
    plantDepartmentCode = json['plant_department_code'];
    plantDepartmentName = json['plant_department_name'];
    equipmentGroupCode = json['equipment_group_code'];
    equipmentGroupName = json['equipment_group_name'];
    equipmentCode = json['equipment_code'];
    equipmentName = json['equipment_name'];
    functionName = json['function_name'];
    functionCode = json['function_code'];
    meterCode = json['meter_code'];
    meterName = json['meter_name'];
    meterCount = json['meter_count'];
    pmMeterCount = json['pm_meter_count'];
    powerId = json['power_id'];
    companyId = json['company_id'];
    buId = json['bu_id'];
    plantId = json['plant_id'];
    campusId = json['campus_id'];
    plantDepartmentId = json['plant_department_id'];
    equipmentGroupId = json['equipment_group_id'];
    equipmentId = json['equipment_id'];
    functionId = json['function_id'];
    equipmentClassId = json['equipment_class_id'];
    equipmentClassCode = json['equipment_class_code'];
    meterId = json['meter_id'];
    designId = json['design_id'];
    beamId = json['beam_id'];
    dateTime = json['date_time'];
    dateTime1 = json['date_time1'];
    millDate = json['mill_date'];
    millShift = json['mill_shift'];
    meterStatusCode = json['meter_status_code'];
    meterType = json['meter_type'];
    meterFormula = json['meter_formula'];
    equipmentIds = json['equipment_ids'];
    vlnAvg = json['vln_avg'];
    rVolt = json['r_volt'];
    yVolt = json['y_volt'];
    bVolt = json['b_volt'];
    vllAvg = json['vll_avg'];
    ryVolt = json['ry_volt'];
    ybVolt = json['yb_volt'];
    brVolt = json['br_volt'];
    rCurrent = json['r_current'];
    yCurrent = json['y_current'];
    bCurrent = json['b_current'];
    tCurrent = json['t_current'];
    tWatts = json['t_watts'];
    rWatts = json['r_watts'];
    yWatts = json['y_watts'];
    bWatts = json['b_watts'];
    tVar = json['t_var'];
    rVar = json['r_var'];
    yVar = json['y_var'];
    bVar = json['b_var'];
    tVoltampere = json['t_voltampere'];
    rVoltampere = json['r_voltampere'];
    yVoltampere = json['y_voltampere'];
    bVoltampere = json['b_voltampere'];
    avgPowerfactor = json['avg_powerfactor'];
    pmAvgPowerfactor = json['pm_avg_powerfactor'];
    rPowerfactor = json['r_powerfactor'];
    yPowerfactor = json['y_powerfactor'];
    bPowerfactor = json['b_powerfactor'];
    powerfactor = json['powerfactor'];
    kvah = json['kvah'];
    kw = json['kw'];
    kvar = json['kvar'];
    powerFactor = json['power_factor'];
    kva = json['kva'];
    frequency = json['frequency'];
    machineStatus = json['machine_status'];
    status = json['status'];
    createdOn = json['created_on'];
    createdBy = json['created_by'];
    modifiedOn = json['modified_on'];
    modifiedBy = json['modified_by'];
    machineKWh = json['machine_kWh'];
    masterKwh = json['master_kwh'];
    kWh = json['kWh'];
    pmKwh = json['pm_kwh'];
    totalKWh = json['total_kWh'];
    kwhMin = json['kwh_min'];
    kwhMax = json['kwh_max'];
    avgKWh = json['avg_kWh'];
    minDate = json['min_date'];
    maxDate = json['max_date'];
    minShift = json['min_shift'];
    maxShift = json['max_shift'];
    reverseMachineKWh = json['reverse_machine_kWh'];
    reverseMasterKwh = json['reverse_master_kwh'];
    reverseKwh = json['reverse_kwh'];
    ipAddress = json['ip_address'];
    slaveId = json['slave_id'];
    port = json['port'];
    mac = json['mac'];
    kwh1 = json['kwh_1'];
    kwh2 = json['kwh_2'];
    kwh3 = json['kwh_3'];
    startKwh1 = json['start_kwh_1'];
    startKwh2 = json['start_kwh_2'];
    startKwh3 = json['start_kwh_3'];
    endKwh1 = json['end_kwh_1'];
    endKwh2 = json['end_kwh_2'];
    endKwh3 = json['end_kwh_3'];
    nocom = json['nocom'];
    meterStatusDescription = json['meter_status_description'];
    nocomSCount = json['nocom_s_count'];
    nocomNCount = json['nocom_n_count'];
    pmNocomSCount = json['pm_nocom_s_count'];
    pmNocomNCount = json['pm_nocom_n_count'];
    equipmentKwh = json['equipment_kwh'];
    commonKwh = json['common_kwh'];
    pmEquipmentKwh = json['pm_equipment_kwh'];
    unitsPerTon = json['units_per_ton'];
    pmCommonKwh = json['pm_common_kwh'];
    calculatedKwh = json['calculated_kwh'];
    tooltipKwh = json['tooltip_kwh'];
    formula = json['formula'];
    demand = json['demand'];
    dmPowerfactor = json['dm_powerfactor'];
    actualDemand = json['actual_demand'];
    dDateTime = json['d_date_time'];
    maxDemand = json['max_demand'];
    maxPf = json['max_pf'];
    meter = json['meter'];
    modelName = json['model_name'];
    modelMakeName = json['model_make_name'];
    actualTon = json['actual_ton'];
    onLoadTime = json['on_load_time'];
    idleTime = json['idle_time'];
    offTime = json['off_time'];
    totalTime = json['total_time'];
    onLoadKwh = json['on_load_kwh'];
    offKwh = json['off_kwh'];
    idleKwh = json['idle_kwh'];
    groupId = json['group_id'];
    groupCode = json['group_code'];
    groupName = json['group_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_code'] = companyCode;
    data['company_name'] = companyName;
    data['bu_code'] = buCode;
    data['bu_name'] = buName;
    data['plant_code'] = plantCode;
    data['plant_name'] = plantName;
    data['campus_name'] = campusName;
    data['plant_department_code'] = plantDepartmentCode;
    data['plant_department_name'] = plantDepartmentName;
    data['equipment_group_code'] = equipmentGroupCode;
    data['equipment_group_name'] = equipmentGroupName;
    data['equipment_code'] = equipmentCode;
    data['equipment_name'] = equipmentName;
    data['function_name'] = functionName;
    data['function_code'] = functionCode;
    data['meter_code'] = meterCode;
    data['meter_name'] = meterName;
    data['meter_count'] = meterCount;
    data['pm_meter_count'] = pmMeterCount;
    data['power_id'] = powerId;
    data['company_id'] = companyId;
    data['bu_id'] = buId;
    data['plant_id'] = plantId;
    data['campus_id'] = campusId;
    data['plant_department_id'] = plantDepartmentId;
    data['equipment_group_id'] = equipmentGroupId;
    data['equipment_id'] = equipmentId;
    data['function_id'] = functionId;
    data['equipment_class_id'] = equipmentClassId;
    data['equipment_class_code'] = equipmentClassCode;
    data['meter_id'] = meterId;
    data['design_id'] = designId;
    data['beam_id'] = beamId;
    data['date_time'] = dateTime;
    data['date_time1'] = dateTime1;
    data['mill_date'] = millDate;
    data['mill_shift'] = millShift;
    data['meter_status_code'] = meterStatusCode;
    data['meter_type'] = meterType;
    data['meter_formula'] = meterFormula;
    data['equipment_ids'] = equipmentIds;
    data['vln_avg'] = vlnAvg;
    data['r_volt'] = rVolt;
    data['y_volt'] = yVolt;
    data['b_volt'] = bVolt;
    data['vll_avg'] = vllAvg;
    data['ry_volt'] = ryVolt;
    data['yb_volt'] = ybVolt;
    data['br_volt'] = brVolt;
    data['r_current'] = rCurrent;
    data['y_current'] = yCurrent;
    data['b_current'] = bCurrent;
    data['t_current'] = tCurrent;
    data['t_watts'] = tWatts;
    data['r_watts'] = rWatts;
    data['y_watts'] = yWatts;
    data['b_watts'] = bWatts;
    data['t_var'] = tVar;
    data['r_var'] = rVar;
    data['y_var'] = yVar;
    data['b_var'] = bVar;
    data['t_voltampere'] = tVoltampere;
    data['r_voltampere'] = rVoltampere;
    data['y_voltampere'] = yVoltampere;
    data['b_voltampere'] = bVoltampere;
    data['avg_powerfactor'] = avgPowerfactor;
    data['pm_avg_powerfactor'] = pmAvgPowerfactor;
    data['r_powerfactor'] = rPowerfactor;
    data['y_powerfactor'] = yPowerfactor;
    data['b_powerfactor'] = bPowerfactor;
    data['powerfactor'] = powerfactor;
    data['kvah'] = kvah;
    data['kw'] = kw;
    data['kvar'] = kvar;
    data['power_factor'] = powerFactor;
    data['kva'] = kva;
    data['frequency'] = frequency;
    data['machine_status'] = machineStatus;
    data['status'] = status;
    data['created_on'] = createdOn;
    data['created_by'] = createdBy;
    data['modified_on'] = modifiedOn;
    data['modified_by'] = modifiedBy;
    data['machine_kWh'] = machineKWh;
    data['master_kwh'] = masterKwh;
    data['kWh'] = kWh;
    data['pm_kwh'] = pmKwh;
    data['total_kWh'] = totalKWh;
    data['kwh_min'] = kwhMin;
    data['kwh_max'] = kwhMax;
    data['avg_kWh'] = avgKWh;
    data['min_date'] = minDate;
    data['max_date'] = maxDate;
    data['min_shift'] = minShift;
    data['max_shift'] = maxShift;
    data['reverse_machine_kWh'] = reverseMachineKWh;
    data['reverse_master_kwh'] = reverseMasterKwh;
    data['reverse_kwh'] = reverseKwh;
    data['ip_address'] = ipAddress;
    data['slave_id'] = slaveId;
    data['port'] = port;
    data['mac'] = mac;
    data['kwh_1'] = kwh1;
    data['kwh_2'] = kwh2;
    data['kwh_3'] = kwh3;
    data['start_kwh_1'] = startKwh1;
    data['start_kwh_2'] = startKwh2;
    data['start_kwh_3'] = startKwh3;
    data['end_kwh_1'] = endKwh1;
    data['end_kwh_2'] = endKwh2;
    data['end_kwh_3'] = endKwh3;
    data['nocom'] = nocom;
    data['meter_status_description'] = meterStatusDescription;
    data['nocom_s_count'] = nocomSCount;
    data['nocom_n_count'] = nocomNCount;
    data['pm_nocom_s_count'] = pmNocomSCount;
    data['pm_nocom_n_count'] = pmNocomNCount;
    data['equipment_kwh'] = equipmentKwh;
    data['common_kwh'] = commonKwh;
    data['pm_equipment_kwh'] = pmEquipmentKwh;
    data['units_per_ton'] = unitsPerTon;
    data['pm_common_kwh'] = pmCommonKwh;
    data['calculated_kwh'] = calculatedKwh;
    data['tooltip_kwh'] = tooltipKwh;
    data['formula'] = formula;
    data['demand'] = demand;
    data['dm_powerfactor'] = dmPowerfactor;
    data['actual_demand'] = actualDemand;
    data['d_date_time'] = dDateTime;
    data['max_demand'] = maxDemand;
    data['max_pf'] = maxPf;
    data['meter'] = meter;
    data['model_name'] = modelName;
    data['model_make_name'] = modelMakeName;
    data['actual_ton'] = actualTon;
    data['on_load_time'] = onLoadTime;
    data['idle_time'] = idleTime;
    data['off_time'] = offTime;
    data['total_time'] = totalTime;
    data['on_load_kwh'] = onLoadKwh;
    data['off_kwh'] = offKwh;
    data['idle_kwh'] = idleKwh;
    data['group_id'] = groupId;
    data['group_code'] = groupCode;
    data['group_name'] = groupName;
    return data;
  }
}
