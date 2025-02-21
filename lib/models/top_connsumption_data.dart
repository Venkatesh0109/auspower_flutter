class TopConsumptionnData {
  String? meterName;
  double? kWh;

  TopConsumptionnData({
    this.meterName,
    this.kWh,
  });

  factory TopConsumptionnData.fromJson(Map<String, dynamic> json) =>
      TopConsumptionnData(
        meterName: json["meter_name"],
        kWh: json["kWh"],
      );

  Map<String, dynamic> toJson() => {
        "meter_name": meterName,
        "kWh": kWh,
      };
  List<TopConsumptionnData> fromJsonList(List data) {
    return data.map((e) => TopConsumptionnData.fromJson(e)).toList();
  }
}
