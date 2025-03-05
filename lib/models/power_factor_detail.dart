import 'dart:convert';

class PowerFactorVariationDetailModel {
  final List<Powerfactordetail>? powerfactordetail;

  PowerFactorVariationDetailModel({
    this.powerfactordetail,
  });

  factory PowerFactorVariationDetailModel.fromRawJson(String str) =>
      PowerFactorVariationDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PowerFactorVariationDetailModel.fromJson(Map<String, dynamic> json) =>
      PowerFactorVariationDetailModel(
        powerfactordetail: json["data"] == null
            ? []
            : List<Powerfactordetail>.from(
                json["data"]!.map((x) => Powerfactordetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": powerfactordetail == null
            ? []
            : List<dynamic>.from(powerfactordetail!.map((x) => x.toJson())),
      };
}

class Powerfactordetail {
  final String? meterName;
  final double? avgPowerfactor;

  Powerfactordetail({
    this.meterName,
    this.avgPowerfactor,
  });

  factory Powerfactordetail.fromRawJson(String str) =>
      Powerfactordetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Powerfactordetail.fromJson(Map<String, dynamic> json) =>
      Powerfactordetail(
        meterName: json["meter_name"],
        avgPowerfactor: json["avg_powerfactor"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "meter_name": meterName,
        "avg_powerfactor": avgPowerfactor,
      };
}
