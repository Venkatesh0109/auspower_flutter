import 'dart:math';

import 'package:auspower_flutter/models/top_connsumption_data.dart';
import 'package:auspower_flutter/providers/table_provider.dart';
import 'package:auspower_flutter/view/homescreen/screen/company_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MeterDataChart extends StatefulWidget {
  const MeterDataChart({super.key});

  @override
  State<MeterDataChart> createState() => _MeterDataChartState();
}

class _MeterDataChartState extends State<MeterDataChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Function to generate bold random colors
  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255, // Full opacity
      random.nextInt(128) + 128, // Random red, minimum 128 for boldness
      random.nextInt(128) + 128, // Random green, minimum 128 for boldness
      random.nextInt(128) + 128, // Random blue, minimum 128 for boldness
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TableProvider>(
      builder: (context, value, child) {
        List<TopConsumptionnData> chartdata =
            List.from(value.topConsumptionGraphData)
              ..sort((a, b) {
                if (a.kWh == null && b.kWh == null) return 0;
                if (a.kWh == null) return -1;
                if (b.kWh == null) return 1;
                return a.kWh!.compareTo(b.kWh!);
              });

        return Scaffold(
          appBar: CommonAppBar(
            title: "Top Consumption",
            leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: chartdata.length * 54,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    isVisible: true,
                    maximumLabelWidth: 70,
                    labelRotation: 60,
                    arrangeByIndex: true, // Arrange categories properly
                    // labelRotation: 74, // Rotate labels for better readability
                    labelStyle: const TextStyle(
                        fontSize: 8, fontWeight: FontWeight.bold),
                    maximumLabels:
                        chartdata.length, // Ensure all labels are considered
                    majorGridLines:
                        const MajorGridLines(width: 0), // Remove grid lines
                    labelIntersectAction:
                        AxisLabelIntersectAction.none, // Avoid overlapping
                  ),
                  primaryYAxis: const NumericAxis(
                    labelFormat: '{value}',
                    labelAlignment: LabelAlignment.end,
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    animationDuration: 500,
                    header: '',
                    format: 'point.x: point.y kWh',
                    textStyle: const TextStyle(color: Colors.white),
                    color: Colors.black,
                  ),
                  series: [
                    BarSeries<TopConsumptionnData, String>(
                      dataSource: chartdata,
                      xValueMapper: (TopConsumptionnData meterData, _) =>
                          meterData.meterName,
                      yValueMapper: (TopConsumptionnData meterData, _) =>
                          meterData.kWh,
                      pointColorMapper: (TopConsumptionnData meterData, _) =>
                          getRandomColor(),
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        // alignment: ChartAlignment.values,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      animationDuration: 1000,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                    ),
                  ],
                  plotAreaBorderWidth: 0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
