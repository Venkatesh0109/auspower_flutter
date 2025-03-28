import 'package:auspower_flutter/common/widgets/loaders.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/models/power_factor_variation_model.dart';
import 'package:auspower_flutter/providers/analysis_provider.dart';
import 'package:auspower_flutter/repositories/analysis_repository.dart';
import 'package:auspower_flutter/services/route/navigation.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/view/dashboardscreen.dart';
import 'package:auspower_flutter/view/homescreen/screen/power_consumption.dart';
import 'package:auspower_flutter/view/homescreen/widgets/report_widgets.dart';
import 'package:auspower_flutter/view/report/screens/power_factor_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PowerFactorVariationReport extends StatefulWidget {
  const PowerFactorVariationReport({super.key});

  @override
  State<PowerFactorVariationReport> createState() =>
      _PowerFactorVariationReportState();
}

String? fromDate;

class _PowerFactorVariationReportState
    extends State<PowerFactorVariationReport> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      DateTime now = DateTime.now();
      DateTime previousDate = now.subtract(const Duration(days: 1));
      fromDate = DateFormat("yyyy-MM-dd").format(previousDate);
      AnalysisRepository().getPowerFactorReport(context, fromDate.toString());
      setState(() {});
    });
    super.initState();
  }

  PowerFactorDataSource powerFactorDataSource =
      PowerFactorDataSource(powerFactorList: []);

  @override
  Widget build(BuildContext context) {
    return Consumer<AnalysisProvider>(builder: (context, value, child) {
      powerFactorDataSource = PowerFactorDataSource(
          powerFactorList: value.powerFactorData?.powerfactor ?? []);

      return Scaffold(
        appBar: AppBar(
          title: const Text("Power Factor Report"),
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios),
          ),
          // actions: [
          //   InkWell(
          //       onTap: () {
          //         AnalysisRepository()
          //             .getPowerFactorReport(context, fromDate.toString());
          //         fromDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.only(right: 12.0),
          //         child: Icon(Icons.refresh, color: Colors.white),
          //       ))
          // ],
        ),
        body: value.isLoading
            ? const Center(child: Loader())
            :
            // RefreshIndicator(
            // onRefresh: () async {
            //   DateTime now = DateTime.now();
            //   DateTime previousDate = now.subtract(Duration(days: 1));
            //   fromDate = DateFormat("yyyy-MM-dd").format(previousDate);
            //   AnalysisRepository()
            //       .getPowerFactorReport(context, fromDate.toString());
            // },
            // child:
            ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: DatePickerDialogs(
                      date: fromDate,
                      hint: "Select Date",
                      onPickDate: () async {
                        await pickDateSubractDay(context, (String? pickedDate) {
                          setState(() {
                            fromDate = pickedDate;
                            AnalysisRepository().getPowerFactorReport(
                                context, fromDate.toString());
                          });
                        });
                      },
                      onRemoveDate: () {
                        setState(() {
                          fromDate = null; // Clear the selected date
                        });
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: TextCustom(
                      "Summary :",
                      color: Palette.primary,
                      fontWeight: FontWeight.bold,
                      size: 18,
                    ),
                  ),
                  const HeightHalf(),
                  SfDataGrid(
                    source: powerFactorDataSource,
                    onCellTap: (DataGridCellTapDetails details) {
                      if (details.rowColumnIndex.rowIndex > 0) {
                        logger.i(details.rowColumnIndex.rowIndex);
                        int rowIndex = details.rowColumnIndex.rowIndex;

                        if (rowIndex > 0) {
                          List<String> keys = [
                            "above_1",
                            "between_9",
                            "above_6",
                            "below_6"
                          ];

                          if (rowIndex <= keys.length) {
                            String selectedKey =
                                keys[rowIndex - 1]; // Get corresponding key
                            AnalysisRepository()
                                .getPowerFactorReportDetail(
                                    context, selectedKey, fromDate.toString())
                                .then((v) {
                              Navigation().push(
                                  context,
                                  FadeRoute(
                                      page: const PowerFactorDetailScreen()));
                            });
                          }
                        }
                      }
                    },
                    columnWidthMode: ColumnWidthMode.auto,
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    horizontalScrollPhysics:
                        const AlwaysScrollableScrollPhysics(),
                    verticalScrollPhysics: const NeverScrollableScrollPhysics(),
                    columns: [
                      GridColumn(
                        columnName: 'pf_range',
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
                        columnName: 'no_of_meters',
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
                ],
                // ),
              ),
      );
    });
  }

  Future<void> pickDateSubractDay(
    BuildContext context,
    Function(String?) onDatePicked,
  ) async {
    DateTime now = DateTime.now();
    DateTime firstSelectableDate = DateTime(2000);
    DateTime lastSelectableDate = now.subtract(const Duration(days: 1));
    DateTime initialDate = fromDate != null
        ? DateFormat('yyyy-MM-dd').parse(fromDate!)
        : lastSelectableDate;

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate, // ✅ Always show last selected date
      firstDate: firstSelectableDate,
      lastDate: lastSelectableDate,
      selectableDayPredicate: (DateTime date) {
        if (date.day == now.day &&
            date.month == now.month &&
            date.year == now.year) {
          return false; // Disable today's date
        }
        return true; // Allow past dates
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      fromDate = formattedDate; // ✅ Store last selected date
      onDatePicked(formattedDate);
    }
  }
}

class PowerFactorDataSource extends DataGridSource {
  List<DataGridRow> _powerFactorRows = [];

  PowerFactorDataSource({required List<Powerfactor> powerFactorList}) {
    _powerFactorRows = _generateDataRows(powerFactorList);
  }

  List<DataGridRow> _generateDataRows(List<Powerfactor> powerFactorList) {
    List<DataGridRow> rows = [];
    if (powerFactorList.isNotEmpty) {
      final firstEntry = powerFactorList[0]; // Assuming only one object

      // Mapping JSON keys to readable "PF Range" labels
      rows.add(DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'pf_range', value: '>1'),
        DataGridCell<int>(columnName: 'no_of_meters', value: firstEntry.above1),
      ]));
      rows.add(DataGridRow(cells: [
        const DataGridCell<String>(
            columnName: 'pf_range', value: '>0.9 and <=1'),
        DataGridCell<int>(
            columnName: 'no_of_meters', value: firstEntry.between9),
      ]));
      rows.add(DataGridRow(cells: [
        const DataGridCell<String>(
            columnName: 'pf_range', value: '>0.6 and <=0.9'),
        DataGridCell<int>(columnName: 'no_of_meters', value: firstEntry.above6),
      ]));
      rows.add(DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'pf_range', value: '<0.6'),
        DataGridCell<int>(columnName: 'no_of_meters', value: firstEntry.below6),
      ]));
    }
    return rows;
  }

  @override
  List<DataGridRow> get rows => _powerFactorRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map((dataGridCell) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        alignment: Alignment.center,
        child: Text(
          dataGridCell.value.toString(),
          style: const TextStyle(fontSize: 14),
        ),
      );
    }).toList());
  }
}
