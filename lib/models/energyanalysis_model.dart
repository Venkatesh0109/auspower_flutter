import 'dart:convert';

class EnergyAnalysisModel {
  bool? iserror;
  String? message;
  List<Datum>? data;

  EnergyAnalysisModel({
    this.iserror,
    this.message,
    this.data,
  });

  factory EnergyAnalysisModel.fromRawJson(String str) =>
      EnergyAnalysisModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EnergyAnalysisModel.fromJson(Map<String, dynamic> json) {
    return EnergyAnalysisModel(
      iserror: json["iserror"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "iserror": iserror,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? companyCode;
  String? companyName;
  String? millShift;
  String? minShift;
  String? maxShift;
  DateTime? dateTime;
  DateTime? dateTime1;
  DateTime? millDate;
  DateTime? maxDate;
  DateTime? minDate;
  double? kWh;
  double? kwhMin;
  double? kwhMax;
  double? totalKWh;
  double? avgKWh;

  Datum({
    this.companyCode,
    this.companyName,
    this.dateTime,
    this.dateTime1,
    this.maxDate,
    this.minDate,
    this.kWh,
    this.kwhMin,
    this.kwhMax,
    this.millShift,
    this.minShift,
    this.maxShift,
    this.totalKWh,
    this.millDate,
    this.avgKWh,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      companyCode: json["company_code"],
      companyName: json["group_name"],
      millShift: json["mill_shift"],
      minShift: json["min_shift"],
      maxShift: json["max_shift"],
      dateTime:
          json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
      dateTime1: json["date_time1"] == null
          ? null
          : DateTime.parse(json["date_time1"]),
      millDate:
          json["mill_date"] == null ? null : DateTime.parse(json["mill_date"]),
      maxDate: json["max_date"] == null || json["max_date"] == ""
          ? null
          : DateTime.parse(json["max_date"]),
      minDate: json["min_date"] == null || json["max_date"] == ""
          ? null
          : DateTime.parse(json["min_date"]),
      kWh: json["kWh"]?.toDouble(),
      kwhMin: json["kwh_min"]?.toDouble(),
      kwhMax: json["kwh_max"]?.toDouble(),
      totalKWh: json["total_kWh"]?.toDouble(),
      avgKWh: json["avg_kWh"]?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        "company_code": companyCode,
        "group_name": companyName,
        "mill_shift": millShift,
        "max_shift": maxShift,
        "min_shift": minShift,
        "date_time": dateTime?.toIso8601String(),
        "date_time1": dateTime1?.toIso8601String(),
        "mill_date": millDate?.toIso8601String(),
        "max_date": maxDate?.toIso8601String(),
        "min_date": minDate?.toIso8601String(),
        "kWh": kWh,
        "kwh_min": kwhMin,
        "kwh_max": kwhMax,
        "total_kWh": totalKWh,
        "avg_kWh": avgKWh,
      };
}
