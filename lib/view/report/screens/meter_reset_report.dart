import 'package:auspower_flutter/common/widgets/empty.dart';
import 'package:auspower_flutter/common/widgets/loaders.dart';
import 'package:auspower_flutter/models/meter_reset_model.dart';
import 'package:auspower_flutter/providers/analysis_provider.dart';
import 'package:auspower_flutter/repositories/analysis_repository.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MeterResetReportScreen extends StatefulWidget {
  const MeterResetReportScreen({super.key});

  @override
  State<MeterResetReportScreen> createState() => _MeterResetReportScreenState();
}

class _MeterResetReportScreenState extends State<MeterResetReportScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      AnalysisRepository().getMeterResetReport(context);
    });
    super.initState();
  }

  MeterResetDataSource meterResetDataSource =
      MeterResetDataSource(meterResetData: []);

  @override
  Widget build(BuildContext context) {
    return Consumer<AnalysisProvider>(builder: (context, value, child) {
      meterResetDataSource = MeterResetDataSource(
          meterResetData: value.meterResetData?.data ?? []);
      List<Datum> meterList = value.meterResetData?.data ?? [];
      return Scaffold(
        appBar: AppBar(
          title: const Text("Meter Reset Report"),
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: value.isLoading
            ? const Center(child: Loader())
            : meterList.isEmpty
                ? const EmptyScreen()
                : RefreshIndicator(
                    onRefresh: () async {
                      AnalysisRepository().getMeterResetReport(context);
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: SfDataGrid(
                            source: meterResetDataSource,
                            columnWidthMode: ColumnWidthMode.none,
                            gridLinesVisibility: GridLinesVisibility.both,
                            headerGridLinesVisibility: GridLinesVisibility.both,
                            horizontalScrollPhysics:
                                const AlwaysScrollableScrollPhysics(),
                            verticalScrollPhysics:
                                const AlwaysScrollableScrollPhysics(),
                            columns: [
                              GridColumn(
                                columnName: 'meter_name',
                                width: 200,
                                columnWidthMode: ColumnWidthMode.auto,
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
                                columnName: 'consumption_value',
                                width: 200,
                                columnWidthMode: ColumnWidthMode.auto,
                                label: Container(
                                  color: Palette.primary,
                                  padding: const EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Consumption Value",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              GridColumn(
                                columnName: 'reset_date',
                                width: 200,
                                columnWidthMode: ColumnWidthMode.auto,
                                label: Container(
                                  color: Palette.primary,
                                  padding: const EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Last Reset Date",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      );
    });
  }
}

class MeterResetDataSource extends DataGridSource {
  MeterResetDataSource({required List<Datum> meterResetData}) {
    _meterResetData = meterResetData.asMap().entries.map<DataGridRow>((entry) {
      Datum e = entry.value;
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'Meter Name', value: e.meterName),
        DataGridCell<double>(
            columnName: 'Consumption Value', value: e.consumptionValue),
        DataGridCell<DateTime>(
            columnName: 'Last Reset Date', value: e.resetDate),
      ]);
    }).toList();
  }

  List<DataGridRow> _meterResetData = [];

  @override
  List<DataGridRow> get rows => _meterResetData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == "Meter Name") {
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
