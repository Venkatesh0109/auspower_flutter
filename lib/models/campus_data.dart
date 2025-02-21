class CampusModel {
  bool? iserror;
  String? message;
  List<CampusModelData>? data;

  CampusModel({this.iserror, this.message, this.data});

  CampusModel.fromJson(Map<String, dynamic> json) {
    iserror = json['iserror'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CampusModelData>[];
      json['data'].forEach((v) {
        data!.add(new CampusModelData.fromJson(v));
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

class CampusModelData {
  int? campusId;
  int? companyId;
  int? buId;
  String? campusCode;
  String? campusName;
  String? status;
  String? createdOn;
  String? createdBy;
  String? modifiedOn;
  String? modifiedBy;
  int? demandMeterLimit;
  String? createdUser;
  String? modifiedUser;

  CampusModelData(
      {this.campusId,
      this.companyId,
      this.buId,
      this.campusCode,
      this.campusName,
      this.status,
      this.createdOn,
      this.createdBy,
      this.modifiedOn,
      this.modifiedBy,
      this.demandMeterLimit,
      this.createdUser,
      this.modifiedUser});

  CampusModelData.fromJson(Map<String, dynamic> json) {
    campusId = json['campus_id'];
    companyId = json['company_id'];
    buId = json['bu_id'];
    campusCode = json['campus_code'];
    campusName = json['campus_name'];
    status = json['status'];
    createdOn = json['created_on'];
    createdBy = json['created_by'];
    modifiedOn = json['modified_on'];
    modifiedBy = json['modified_by'];
    demandMeterLimit = json['demand_meter_limit'];
    createdUser = json['created_user'];
    modifiedUser = json['modified_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['campus_id'] = campusId;
    data['company_id'] = companyId;
    data['bu_id'] = buId;
    data['campus_code'] = campusCode;
    data['campus_name'] = campusName;
    data['status'] = status;
    data['created_on'] = createdOn;
    data['created_by'] = createdBy;
    data['modified_on'] = modifiedOn;
    data['modified_by'] = modifiedBy;
    data['demand_meter_limit'] = demandMeterLimit;
    data['created_user'] = createdUser;
    data['modified_user'] = modifiedUser;
    return data;
  }
}
