import 'dart:convert';


class MeterResetModel {
  final List<Datum>? data;

  MeterResetModel({this.data});

  factory MeterResetModel.fromRawJson(String str) =>
      MeterResetModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MeterResetModel.fromJson(Map<String, dynamic> json) {
    return MeterResetModel(
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"].map((x) {

              return Datum.fromJson(x);
            })),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final String meterName;
  final double consumptionValue;
  final DateTime? resetDate;

  Datum({
    required this.meterName,
    required this.consumptionValue,
    this.resetDate,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      meterName: json["meter_name"] ?? "Unknown Meter", // Default value
      consumptionValue: json["consumption_value"] ?? 0, // Default to 0
      resetDate: json["reset_date"] != null
          ? DateTime.tryParse(json["reset_date"]) ?? DateTime.now()
          : null, // Handle parsing failure
    );
  }

  Map<String, dynamic> toJson() => {
        "meter_name": meterName,
        "consumption_value": consumptionValue,
        "reset_date": resetDate?.toIso8601String(),
      };
}
