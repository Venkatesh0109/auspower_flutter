import 'package:auspower_flutter/common/widgets/loaders.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/models/energyanalysis_model.dart';
import 'package:auspower_flutter/providers/filter_store_provider.dart';
import 'package:auspower_flutter/providers/power_consumption_provider.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/repositories/power_consumption_repository.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/utilities/date_format.dart';
import 'package:auspower_flutter/utilities/extensions/context_extention.dart';
import 'package:auspower_flutter/view/energy_analysis/widgets/filter_energy_analysis.dart';
import 'package:auspower_flutter/view/homescreen/screen/company_screen.dart';
import 'package:auspower_flutter/view/homescreen/screen/power_consumption.dart';
import 'package:auspower_flutter/view/homescreen/widgets/report_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

EnergyAnalysisGridSource dataSource = EnergyAnalysisGridSource([]);

class EnergyAnalysisScreen extends StatefulWidget {
  const EnergyAnalysisScreen({super.key});

  @override
  State<EnergyAnalysisScreen> createState() => _EnergyAnalysisScreenState();
}

class _EnergyAnalysisScreenState extends State<EnergyAnalysisScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      filterProvider.setCampus({"campus_name": "All"});
      filterProvider.setCompany({"company_name": "All"});
      filterProvider.setBu({"bu_name": "All"});
      filterProvider.setPlant({"plant_name": "All"});
      filterProvider.setMeter(
          {"meter_name": powerProvider.energyAnalysis?.data?[0].companyName});
      filterProvider.setGroupBy({"groupBy": "Meter"});
      PowerConsumptionRepository().getCampusData(context);
      DateTime now = DateTime.now();
      DateTime startOfMonth = DateTime(now.year, now.month, 1);
      fromDate = DateFormat("dd-MM-yyyy").format(startOfMonth);
      toDate = DateFormat("dd-MM-yyyy").format(now);

      PowerConsumptionRepository().getEnergyAnalysis(context, params: {
        "group_for": "regular",
        "report_for": "detail",
        "period_id": "cur_shift",
        "groupby": "meter",
        "plant_id": "0",
        "company_id": "0",
        "meter_id": "1",
        // "is_minmax": "yes"
      });
      PowerConsumptionRepository().getEnergyAnalysisChart(context, params: {
        "group_for": "regular",
        "report_for": "cumulative",
        "period_id": "cur_shift",
        "groupby": "meter",
        "plant_id": "0",
        "company_id": "0",
        "meter_id": "1",
        "is_minmax": "yes"
      }).then((value) {
        dataSource =
            EnergyAnalysisGridSource(powerProvider.energyAnalysis?.data ?? []);
      });
    });
    setState(() {
      selectedIndex = 0;
    });
    super.initState();
  }

  Map selectedEnergy = {};
  int? selectedIndex;

  String? fromDate;
  String? toDate;

  @override
  Widget build(BuildContext context) {
    return Consumer2<FilterStoreProvider, PowerConsumptionProvider>(
      builder: (context, filter, value, child) {
        List<Datum> chartData = value.energyAnalysis?.data ?? [];
// Assuming chartData is a list of Datum objects
        // Assuming chartData is a list of Datum objects
        List<Datum> filteredData = chartData
            .where((data) =>
                data.kWh != null &&
                data.kWh! > 0) // Ensure kWh is non-null and greater than 0
            .toList();

        return Scaffold(
          appBar: CommonAppBar(
            title: "Energy Analysis",
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios),
            ),
            action: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: InkWell(
                  onTap: () => commonDialog(
                      context,
                      FilterGraph(
                          periodId:
                              selectedEnergy["period_id"] ?? "cur_shift")),
                  child:
                      const Icon(Icons.settings_suggest, color: Colors.white)),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              Map<String, dynamic> params = {
                "group_for": "regular",
                "report_for": "detail",
                "period_id": selectedEnergy["period_id"] ?? "cur_shift",
                "groupby": "meter",
                "plant_id": "0",
                "company_id": "0",
                "meter_id": filter.meter?["meter_id"] ?? "1",
                // "plant_id": widget.companyData.plantId,
                // "company_id": widget.companyData.companyId,
                // "meter_id": widget.companyData.meterId,
              };
              if (selectedEnergy["name"] == 'Custom') {
                params.addAll({"from_date": fromDate, "to_date": toDate});
              }
              PowerConsumptionRepository()
                  .getEnergyAnalysis(context, params: params);

              PowerConsumptionRepository()
                  .getEnergyAnalysisChart(context, params: {
                "group_for": "regular",
                "report_for": "cumulative",
                "period_id": selectedEnergy["period_id"] ?? "cur_shift",
                "groupby": "meter",
                "plant_id": "0",
                "company_id": "0",
                "meter_id": filter.meter?["meter_id"] ?? "1",
                "is_minmax": "yes"
              }).then((value) {
                dataSource = EnergyAnalysisGridSource(
                    powerProvider.energyAnalysis?.data ?? []);
              });
            },
            child: ListView(
              children: [
                const HeightFull(),
                SizedBox(
                  height: 54,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: detailsTopBar.length,
                    itemBuilder: (context, index) {
                      bool isSelected = selectedIndex == index;

                      return InkWell(
                        splashColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            selectedEnergy = detailsTopBar[index];
                            Map<String, dynamic> params = {
                              "group_for": "regular",
                              "report_for": "detail",
                              "period_id": selectedEnergy["period_id"],
                              "groupby": "meter",
                              "plant_id": "0",
                              "company_id": "0",
                              "meter_id": filter.meter?["meter_id"] ?? "1",
                              // "plant_id": widget.companyData.plantId,
                              // "company_id": widget.companyData.companyId,
                              // "meter_id": widget.companyData.meterId,
                            };
                            if (selectedEnergy["name"] == 'Custom') {
                              params.addAll(
                                  {"from_date": fromDate, "to_date": toDate});
                            }
                            // logger.w(params);
                            PowerConsumptionRepository()
                                .getEnergyAnalysis(context, params: params)
                                .then((v) {
                              PowerConsumptionRepository()
                                  .getEnergyAnalysisChart(context, params: {
                                "group_for": "regular",
                                "report_for": "cumulative",
                                "period_id":
                                    selectedEnergy["period_id"] ?? "cur_shift",
                                "groupby": "meter",
                                "plant_id": "0",
                                "company_id": "0",
                                "meter_id": filter.meter?["meter_id"] ?? "1",
                                "is_minmax": "yes"
                              }).then((value1) {
                                dataSource = EnergyAnalysisGridSource(
                                    value.energyAnalysis?.data ?? []);
                              });
                            });
                          });
                        },
                        child: Center(
                          child: Stack(
                            alignment: const Alignment(.5, -.6),
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: 14,
                                  left: index == 0 ? 14 : 0,
                                ),
                                padding: index == 0
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12)
                                    : const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isSelected ? Palette.primary : null,
                                  borderRadius: BorderRadius.circular(36),
                                  border: Border.all(
                                      color: isSelected
                                          ? Colors.transparent
                                          : Colors.grey),
                                ),
                                child: TextCustom(
                                  detailsTopBar[index]["name"],
                                  fontWeight:
                                      isSelected ? FontWeight.w600 : null,
                                  color: isSelected
                                      ? Palette.pureWhite
                                      : Palette.dark,
                                ),
                              ),
                              index != 0
                                  ? const SizedBox()
                                  : Container(
                                      height: 12,
                                      width: 12,
                                      decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (selectedEnergy["name"] == 'Custom')
                  Column(
                    children: [
                      const HeightFull(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: DatePickerDialogs(
                                date: fromDate,
                                hint: "Select From Date",
                                onPickDate: () async {
                                  await pickDate(context, (String? pickedDate) {
                                    setState(() {
                                      fromDate = pickedDate;
                                      Map<String, dynamic> params = {
                                        "group_for": "regular",
                                        "report_for": "detail",
                                        "period_id":
                                            selectedEnergy["period_id"],
                                        "groupby": "meter",
                                        "plant_id": "0",
                                        "company_id": "0",
                                        "meter_id":
                                            filter.meter?["meter_id"] ?? "1",
                                        "from_date": fromDate,
                                        "to_date": toDate
                                      };

                                      PowerConsumptionRepository()
                                          .getEnergyAnalysis(context,
                                              params: params)
                                          .then((e) {
                                        dataSource = EnergyAnalysisGridSource(
                                            powerProvider
                                                    .energyAnalysis?.data ??
                                                []);
                                      });
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
                            const WidthFull(),
                            Expanded(
                              child: DatePickerDialogs(
                                date: toDate,
                                hint: "Select To Date",
                                onPickDate: () async {
                                  await pickDate(context, (String? pickedDate) {
                                    setState(() {
                                      toDate = pickedDate;
                                      Map<String, dynamic> params = {
                                        "group_for": "regular",
                                        "report_for": "detail",
                                        "period_id":
                                            selectedEnergy["period_id"],
                                        "groupby": "meter",
                                        "plant_id": "0",
                                        "company_id": "0",
                                        "meter_id":
                                            filter.meter?["meter_id"] ?? "1",
                                        "from_date": fromDate,
                                        "to_date": toDate
                                      };

                                      PowerConsumptionRepository()
                                          .getEnergyAnalysis(context,
                                              params: params)
                                          .then((e) {
                                        dataSource = EnergyAnalysisGridSource(
                                            powerProvider
                                                    .energyAnalysis?.data ??
                                                []);
                                      });
                                    });
                                  });
                                },
                                onRemoveDate: () {
                                  setState(() {
                                    toDate = null; // Clear the selected date
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const HeightFull(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    scrollDirection:
                        Axis.horizontal, // Enable horizontal scrolling
                    child: SizedBox(
                      width: filteredData.length <= 5
                          ? context.widthFull()
                          : filteredData.length * 80,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          height:
                              context.heightFull() - 220, // Adjust dynamically
                          child: value.isLoading
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Loader()],
                                )
                              : SfCartesianChart(
                                  isTransposed: true,
                                  primaryXAxis: const CategoryAxis(
                                    isVisible: true,
                                    labelRotation: 45,
                                    majorGridLines: MajorGridLines(width: 0),
                                    labelIntersectAction:
                                        AxisLabelIntersectAction.none,
                                    maximumLabelWidth:
                                        80, // Prevent labels from overlapping
                                  ),
                                  primaryYAxis: const NumericAxis(
                                    labelFormat: '{value}',
                                    majorGridLines: MajorGridLines(width: 0),
                                  ),
                                  tooltipBehavior: TooltipBehavior(
                                    enable: true,
                                    animationDuration: 500,
                                    header: '',
                                    format:
                                        'Date: point.x\nkWh: point.y\nShift: point.customShift',
                                    textStyle:
                                        const TextStyle(color: Colors.white),
                                    color: Colors.black,
                                  ),
                                  series: [
                                    BarSeries<Datum, String>(
                                      dataSource: filteredData,
                                      xValueMapper: (Datum meterData, _) =>
                                          '${DateFormat('yyyy-MM-dd').format(meterData.millDate ?? DateTime.now())} & ${meterData.millShift}',
                                      yValueMapper: (Datum meterData, _) =>
                                          meterData.kWh,
                                      spacing:
                                          0.3, // Add space between bars (0.1 - 1.0)
                                      width:
                                          0.6, // Reduce bar width for better spacing
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                        isVisible: true,
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                      ),
                                    ),
                                  ],
                                  plotAreaBorderWidth: 0,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                const HeightFull(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextCustom("Variation Analysis",
                          fontWeight: FontWeight.w600, size: 16),
                      const HeightFull(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: context.heightFull(),
                        child: SfDataGrid(
                            source: dataSource,
                            columnWidthMode: ColumnWidthMode.fill,
                            gridLinesVisibility: GridLinesVisibility.both,
                            headerGridLinesVisibility:
                                GridLinesVisibility.vertical,
                            horizontalScrollPhysics:
                                const AlwaysScrollableScrollPhysics(),
                            verticalScrollPhysics:
                                const NeverScrollableScrollPhysics(),
                            columns: [
                              GridColumn(
                                columnWidthMode: ColumnWidthMode.auto,
                                columnName: 'group_name',
                                label: _buildHeaderCell("Meter Name"),
                              ),
                              GridColumn(
                                columnWidthMode: ColumnWidthMode.auto,
                                width: 200,
                                columnName: 'min_date',
                                label: _buildHeaderCell("Minimum Date & Shift"),
                              ),
                              GridColumn(
                                columnWidthMode: ColumnWidthMode.auto,
                                width: 200,
                                columnName: 'kwh_min',
                                label: _buildHeaderCell("Minimum Value"),
                              ),
                              GridColumn(
                                columnWidthMode: ColumnWidthMode.auto,
                                width: 200,
                                columnName: 'max_date',
                                label: _buildHeaderCell("Maximum Date & Shift"),
                              ),
                              GridColumn(
                                columnWidthMode: ColumnWidthMode.auto,
                                columnName: 'kwh_max',
                                width: 200,
                                label: _buildHeaderCell("Maximum Value"),
                              ),
                              GridColumn(
                                columnWidthMode: ColumnWidthMode.auto,
                                columnName: 'total_kWh',
                                label: _buildHeaderCell("Total"),
                              ),
                              GridColumn(
                                columnWidthMode: ColumnWidthMode.auto,
                                columnName: 'avg_kWh',
                                label: _buildHeaderCell("Average"),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      color: Palette.primary,
      alignment: Alignment.center,
      child: Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class EnergyAnalysisGridSource extends DataGridSource {
  List<DataGridRow> _dataGridRows = [];

  EnergyAnalysisGridSource(List<Datum> energyData) {
    _dataGridRows = energyData.map((data) {
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'group_name', value: data.companyName ?? ""),
        DataGridCell<String>(
            columnName: 'min_date',
            value:
                "${FormatDate().getFormatedDateNew("${data.minDate?.toString()}")} & ${data.minShift?.toString()}"),
        DataGridCell<double>(columnName: 'kwh_min', value: data.kwhMin ?? 0.0),
        DataGridCell<String>(
            columnName: 'max_date',
            value:
                "${FormatDate().getFormatedDateNew("${data.maxDate?.toString()}")} & ${data.maxShift?.toString()}"),
        DataGridCell<double>(columnName: 'kwh_max', value: data.kwhMax ?? 0.0),
        DataGridCell<double>(
            columnName: 'total_kWh', value: data.totalKWh ?? 0.0),
        DataGridCell<double>(columnName: 'avg_kWh', value: data.avgKWh ?? 0.02),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child:
              Text(cell.value.toString(), style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
    );
  }
}
