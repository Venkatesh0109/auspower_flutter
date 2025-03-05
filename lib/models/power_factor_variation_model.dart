import 'dart:convert';

import 'package:auspower_flutter/constants/keys.dart';

class PowerFactorVariationModel {
  final List<Powerfactor>? powerfactor;

  PowerFactorVariationModel({
    this.powerfactor,
  });

  factory PowerFactorVariationModel.fromRawJson(String str) =>
      PowerFactorVariationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PowerFactorVariationModel.fromJson(Map<String, dynamic> json) {
    // logger.w(json);
    return PowerFactorVariationModel(
      powerfactor: json["data"] == null
          ? []
          : List<Powerfactor>.from(json["data"]!.map((x) {
              return Powerfactor.fromJson(x);
            })),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": powerfactor == null
            ? []
            : List<dynamic>.from(powerfactor!.map((x) => x.toJson())),
      };
}

class Powerfactor {
  final int? above1;
  final int? between9;
  final int? above6;
  final int? below6;

  Powerfactor({
    this.above1,
    this.between9,
    this.above6,
    this.below6,
  });

  factory Powerfactor.fromRawJson(String str) =>
      Powerfactor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Powerfactor.fromJson(Map<String, dynamic> json) {
    return Powerfactor(
      above1: json["above_1"] ?? 0,
      between9: json["between_9"] ?? 0,
      above6: json["above_6"] ?? 0,
      below6: json["below_6"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "above_1": above1 ?? 0,
        "between_9": between9 ?? 0,
        "above_6": above6 ?? 0,
        "below_6": below6 ?? 0,
      };
}
