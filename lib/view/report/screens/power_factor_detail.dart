import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/models/power_factor_detail.dart';
import 'package:auspower_flutter/providers/analysis_provider.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PowerFactorDetailScreen extends StatefulWidget {
  const PowerFactorDetailScreen({super.key});

  @override
  State<PowerFactorDetailScreen> createState() =>
      _PowerFactorDetailScreenState();
}

class _PowerFactorDetailScreenState extends State<PowerFactorDetailScreen> {
  PowerFactorDetailSource powerFactorDetailSource =
      PowerFactorDetailSource(powerFactorList: []);
  @override
  Widget build(BuildContext context) {
    return Consumer<AnalysisProvider>(
      builder: (context, value, child) {
        powerFactorDetailSource = PowerFactorDetailSource(
            powerFactorList:
                value.powerFactorDetailData?.powerfactordetail ?? []);
        return Scaffold(
          appBar: AppBar(
              title: const Text("Power Factor Report Detail"),
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios),
              )),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: TextCustom(
                  "Detail :",
                  color: Palette.primary,
                  fontWeight: FontWeight.bold,
                  size: 18,
                ),
              ),
              const HeightHalf(),
              Expanded(
                child: SfDataGrid(
                  source: powerFactorDetailSource,
                  columnWidthMode: ColumnWidthMode.auto,
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  horizontalScrollPhysics:
                      const AlwaysScrollableScrollPhysics(),
                  verticalScrollPhysics: const AlwaysScrollableScrollPhysics(),
                  columns: [
                    GridColumn(
                      columnName: 'meter_name',
                      columnWidthMode: ColumnWidthMode.fill,
                      label: Container(
                        color: Palette.primary,
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text(
                          "Meter Name",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'avg_powerfactor',
                      columnWidthMode: ColumnWidthMode.fill,
                      label: Container(
                        color: Palette.primary,
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text(
                          "Power Factor",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PowerFactorDetailSource extends DataGridSource {
  List<DataGridRow> _powerFactorRows = [];

  PowerFactorDetailSource({required List<Powerfactordetail> powerFactorList}) {
    _powerFactorRows = powerFactorList.map((data) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'meter_name', value: data.meterName),
        DataGridCell<double>(
            columnName: 'avg_powerfactor', value: data.avgPowerfactor),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _powerFactorRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((e) {
        if (e.columnName == "meter_name") {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (e.value.toString().length > (constraints.maxWidth / 8)) {
                  return Marquee(
                    text: e.value.toString(),
                    style: const TextStyle(fontSize: 16),
                    scrollAxis: Axis.horizontal,
                    blankSpace: 20.0,
                    velocity: 30.0,
                    pauseAfterRound: const Duration(seconds: 1),
                    startPadding: 10.0,
                    accelerationDuration: const Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: const Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  );
                } else {
                  return Text(e.value.toString());
                }
              },
            ),
          );
        } else {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.center,
            child: Text(
              e.value.toString(),
              style: const TextStyle(fontSize: 14),
            ),
          );
        }
      }).toList(),
    );
  }
}
