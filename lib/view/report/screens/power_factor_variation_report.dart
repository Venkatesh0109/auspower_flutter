import 'package:auspower_flutter/providers/analysis_provider.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PowerFactorVariationReport extends StatefulWidget {
  const PowerFactorVariationReport({super.key});

  @override
  State<PowerFactorVariationReport> createState() =>
      _PowerFactorVariationReportState();
}

class _PowerFactorVariationReportState
    extends State<PowerFactorVariationReport> {
  final List<Map<String, dynamic>> jsonData = [
    {
      "above_1": 204,
      "between_9": 4,
      "above_6": 2,
      "below_6": 126,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<AnalysisProvider>(builder: (context, value, child) {
      List<PFRangeData> pfRangeList = jsonData.expand((data) {
        return data.entries.map((entry) => PFRangeData(entry.key, entry.value));
      }).toList();

      final PFRangeDataSource dataSource = PFRangeDataSource(pfRangeList);

      return Scaffold(
        appBar: AppBar(
          title: const Text("Power Factor Report"),
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SfDataGrid(
          source: dataSource,
          columnWidthMode: ColumnWidthMode.auto,
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          horizontalScrollPhysics: const AlwaysScrollableScrollPhysics(),
          verticalScrollPhysics: const AlwaysScrollableScrollPhysics(),
          columns: [
            GridColumn(
              columnName: 'pfRange',
              columnWidthMode: ColumnWidthMode.fill,
              label: Container(
                color: Palette.primary,
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Text(
                  "PF Range",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GridColumn(
              columnName: 'noOfMeter',
              columnWidthMode: ColumnWidthMode.fill,
              label: Container(
                color: Palette.primary,
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Text(
                  "No of Meter's",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class PFRangeData {
  final String pfRange;
  final int noOfMeter;

  PFRangeData(this.pfRange, this.noOfMeter);
}

class PFRangeDataSource extends DataGridSource {
  List<DataGridRow> _dataGridRows = [];

  PFRangeDataSource(List<PFRangeData> pfRangeDataList) {
    _dataGridRows = pfRangeDataList
        .map<DataGridRow>((data) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'pfRange', value: data.pfRange),
              DataGridCell<int>(columnName: 'noOfMeter', value: data.noOfMeter),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataCell) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          alignment: Alignment.center,
          child: Text(
            dataCell.value.toString() == "above_1"
                ? ">1"
                : dataCell.value.toString() == "between_9"
                    ? ">0.9 and <=1"
                    : dataCell.value.toString() == "above_6"
                        ? ">0.6 and <=0.9"
                        : dataCell.value.toString() == "below_6"
                            ? "<0.6"
                            : dataCell.value.toString(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
    );
  }
}
