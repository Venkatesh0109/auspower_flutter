import 'dart:convert';

import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/common/widgets/text_fields.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/providers/auth_provider.dart';
import 'package:auspower_flutter/providers/power_consumption_provider.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/repositories/power_consumption_repository.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/utilities/date_format.dart';
import 'package:auspower_flutter/utilities/extensions/context_extention.dart';
import 'package:auspower_flutter/utilities/message.dart';
import 'package:auspower_flutter/view/homescreen/widgets/report_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EnergyEntryScreen extends StatefulWidget {
  const EnergyEntryScreen({super.key, this.campusId});
  final String? campusId;

  @override
  State<EnergyEntryScreen> createState() => _EnergyEntryScreenState();
}

class _EnergyEntryScreenState extends State<EnergyEntryScreen> {
  Map campus = {};
  String? selectedDate;
  String? selectedMonthYear;

  final List<String> tabTitles = ['Daily Entry', 'Monthly Entry'];
  int selectedIndex = 0;

  TextEditingController createdOnCont = TextEditingController();
  TextEditingController createdByCont = TextEditingController();
  TextEditingController modifiedOnCont = TextEditingController();
  TextEditingController modifiedByCont = TextEditingController();

  List dailyEntry = [
    {"source": "Energy Source"},
    {"source": "Consumption"},
  ];
  List monthlyEntry = [
    {"source": "Energy Source"},
    {"source": "Consumption(Provision)"},
    {"source": "Consumption(Final)"},
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      PowerConsumptionRepository().getCampusData(context);
      PowerConsumptionRepository().getPowerReportData(context);
      DateTime now = DateTime.now();
      selectedDate = DateFormat("dd-MM-yyyy").format(now);
      DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
      selectedMonthYear = DateFormat("MM-yyyy").format(firstDayOfMonth);
      campus = powerProvider.campusData.firstWhere(
        (e) =>
            "${e['campus_id']}" ==
            "${authProvider.user?.employeeType == "Operator" ? authProvider.user?.campusId : widget.campusId}",
        orElse: () => {},
      );
      // logger.w(selectedMonthYear);
    });
    super.initState();
  }

  bool isView = false;

  EnergyDataGridSource dataSource = EnergyDataGridSource([], true);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, PowerConsumptionProvider>(
      builder: (context, auth, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Energy Entry"),
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SafeArea(
              child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ContainerListDialogManualData(
                            data: campus,
                            colors: Palette.pureWhite,
                            hint: "Select Campus",
                            fun: () {
                              commonDialog(
                                  context,
                                  DropdownDialogList(
                                      courses: value.campusData,
                                      dropdownKey: "campus_name",
                                      hint: "Campus",
                                      onSelected: (val) {
                                        campus = val as Map;

                                        setState(() {});
                                      },
                                      head: "Select Campus"));
                            },
                            keys: 'campus_name',
                          ),
                          const HeightFull(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(tabTitles.length, (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      setState(() {
                                        selectedIndex = index;
                                        campus = {};
                                        value.energyEnterList.clear();
                                        modifiedByCont.clear();
                                        modifiedOnCont.clear();
                                        createdByCont.clear();
                                        createdOnCont.clear();
                                        dataSource = EnergyDataGridSource(
                                            [], selectedIndex == 0);
                                      });
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: selectedIndex == index
                                          ? Palette.primary
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(32),
                                      border: Border.all(
                                        color: selectedIndex == index
                                            ? Palette.primary
                                            : Palette.grey,
                                      ),
                                    ),
                                    child: Text(
                                      tabTitles[index].toUpperCase(),
                                      style: TextStyle(
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Palette.dark,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const HeightFull(),
                          Row(
                            children: [
                              Expanded(
                                  child: TextFormFieldCustom(
                                      readOnly: true,
                                      isOptional: true,
                                      label: "Created On",
                                      controller: createdOnCont,
                                      hint: "Created On")),
                              const WidthFull(),
                              Expanded(
                                  child: TextFormFieldCustom(
                                      readOnly: true,
                                      label: "Created By",
                                      isOptional: true,
                                      controller: createdByCont,
                                      hint: "Created By")),
                            ],
                          ),
                          const HeightFull(),
                          Row(
                            children: [
                              Expanded(
                                  child: TextFormFieldCustom(
                                      readOnly: true,
                                      isOptional: true,
                                      label: "Modified On",
                                      controller: modifiedOnCont,
                                      hint: "Modified On")),
                              const WidthFull(),
                              Expanded(
                                  child: TextFormFieldCustom(
                                      readOnly: true,
                                      label: "Modified By",
                                      isOptional: true,
                                      controller: modifiedByCont,
                                      hint: "Modified By")),
                            ],
                          ),
                          const HeightFull(),
                          DatePickerDialog(
                            date: selectedIndex == 0
                                ? selectedDate
                                : selectedMonthYear,
                            hint: selectedIndex == 0
                                ? "Select a Date"
                                : "Select a Month & Year",
                            onPickDate: () async {
                              if (selectedIndex == 0) {
                                // Full Date Picker
                                await pickDate(context, (String? pickedDate) {
                                  setState(() {
                                    selectedDate = pickedDate;
                                  });
                                });
                              } else {
                                // Month-Year Picker
                                await pickMonthYear(context,
                                    (String? pickedMonthYear) {
                                  setState(() {
                                    selectedMonthYear = pickedMonthYear;
                                  });
                                });
                              }
                            },
                            onRemoveDate: () {
                              setState(() {
                                if (selectedIndex == 0) {
                                  selectedDate = null;
                                } else {
                                  selectedMonthYear = null;
                                }
                              });
                            },
                          ),
                          const HeightFull(),
                          ButtonPrimary(
                              onPressed: campus.isEmpty
                                  ? () {
                                      // ignore: void_checks
                                      return showMessage(
                                          "Kindly Select Campus");
                                    }
                                  : () {
                                      isView = true;
                                      PowerConsumptionRepository()
                                          .getEnergyEntry(context,
                                              params: {
                                                "mill_date": selectedIndex == 0
                                                    ? selectedDate
                                                    : "01-$selectedMonthYear",
                                                "campus_id":
                                                    campus["campus_id"],
                                                "period_type":
                                                    selectedIndex == 0
                                                        ? "date"
                                                        : "month"
                                              },
                                              isDaily: selectedIndex == 0)
                                          .then((onValue) {
                                        if (value.energyEnterList.isNotEmpty) {
                                          dataSource = EnergyDataGridSource(
                                              value.energyEnterList,
                                              selectedIndex == 0);
                                          modifiedByCont.text =
                                              value.energyEnterList[0]
                                                  ["modified_user"];
                                          modifiedOnCont.text =
                                              FormatDate.formattedStr(
                                                  value.energyEnterList[0]
                                                          ["modified_on"] ??
                                                      "");
                                          createdByCont.text =
                                              value.energyEnterList[0]
                                                  ["created_user"];
                                          createdOnCont.text =
                                              FormatDate.formattedStr(
                                                  value.energyEnterList[0]
                                                          ["created_on"] ??
                                                      "");
                                        }
                                        setState(() {});
                                      });
                                    },
                              label: "View"),
                        ],
                      ),
                    ),
                    !isView || dataSource.rows.isEmpty
                        ? const SizedBox()
                        : SizedBox(
                            width:
                                MediaQuery.of(context).size.width, // Full width
                            height: context.heightQuarter() + 200,
                            child: SfDataGrid(
                              source: dataSource,
                              gridLinesVisibility: GridLinesVisibility.both,
                              columnWidthMode: ColumnWidthMode.fill,
                              headerGridLinesVisibility:
                                  GridLinesVisibility.both,
                              horizontalScrollPhysics:
                                  const AlwaysScrollableScrollPhysics(),
                              verticalScrollPhysics:
                                  const AlwaysScrollableScrollPhysics(),
                              columns: selectedIndex == 0
                                  ? [
                                      // Daily Entry Columns
                                      GridColumn(
                                        columnName: 'energy_source_name',
                                        width: 200,
                                        label: Container(
                                          color: Palette.primary,
                                          padding: const EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            dailyEntry[0]["source"],
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      GridColumn(
                                        columnName: 'consumption_total',
                                        width: 250,
                                        label: Container(
                                          color: Palette.primary,
                                          padding: const EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            dailyEntry[1]["source"],
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ]
                                  : [
                                      // Monthly Entry Columns
                                      GridColumn(
                                        columnName: 'energy_source_name',
                                        width: 200,
                                        label: Container(
                                          color: Palette.primary,
                                          padding: const EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            monthlyEntry[0]["source"],
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      GridColumn(
                                        width: 250,
                                        columnName: 'consumption_total',
                                        label: Container(
                                          color: Palette.primary,
                                          padding: const EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            monthlyEntry[1]["source"],
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      GridColumn(
                                        width: 250,
                                        columnName: 'consumption',
                                        label: Container(
                                          color: Palette.primary,
                                          padding: const EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            monthlyEntry[2]["source"],
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                            ),
                          ),
                  ],
                ),
              ),
              !isView ||
                      dataSource.rows.isEmpty ||
                      auth.user?.employeeType == 'Operator' ||
                      auth.user?.employeeType == "Plant"
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DoubleButton(
                          primaryLabel: "Save",
                          secondarylabel: "Cancel",
                          primaryOnTap: () {
                            // for (int i = 0; i < value.energyEnterList.length; i++) {
                            //   value.energyEnterList[i]['consumption_total'] =
                            //       double.tryParse(controllers[i].text) ??
                            //           0.0;
                            // }

                            Map<String, dynamic> data = {
                              "mill_date_month": "01-$selectedMonthYear",
                              "campus_id": campus["campus_id"],
                              "mill_date": selectedDate,
                              "user_login_id": auth.user?.employeeId,
                              "obj": selectedIndex == 0
                                  ? jsonEncode(value.energyEnterList
                                      .map((e) => {
                                            "id": e["id"],
                                            "energy_source_id":
                                                e["energy_source_id"],
                                            "consumption":
                                                e["consumption_total"],
                                          })
                                      .toList())
                                  : jsonEncode({}),
                              "obj2": selectedIndex == 1
                                  ? jsonEncode(value.energyEnterList
                                      .map((e) => {
                                            "id": e["id"],
                                            "energy_source_id":
                                                e["energy_source_id"],
                                            "consumption": e["consumption"],
                                            "consumption_total":
                                                e["consumption_total"]
                                          })
                                      .toList())
                                  : jsonEncode({})
                            };
                            logger.i(value.energyEnterList);
                            PowerConsumptionRepository()
                                .saveEnergyEntry(context, params: data)
                                .then((v) {
                              campus = {};
                              value.energyEnterList.clear();
                              modifiedByCont.clear();
                              modifiedOnCont.clear();
                              createdByCont.clear();
                              createdOnCont.clear();
                              dataSource =
                                  EnergyDataGridSource([], selectedIndex == 0);
                            });
                          },
                          secondaryOnTap: () {
                            Navigator.pop(context);
                          }),
                    )
            ],
          )),
        );
      },
    );
  }
}

class EnergyDataGridSource extends DataGridSource {
  List<DataGridRow> _dataGridRows = [];
  List<Map<String, dynamic>> energyData;
  List<TextEditingController> controllers = [];
  List<TextEditingController> controllersFinal = [];

  EnergyDataGridSource(this.energyData, bool isDaily) {
    controllers = List.generate(
      energyData.length,
      (index) => TextEditingController(
        text: energyData[index]['consumption'].toString(),
      ),
    );
    controllersFinal = List.generate(
      energyData.length,
      (index) => TextEditingController(
        text: energyData[index]['consumption_total'].toString(),
      ),
    );

    _dataGridRows = energyData.asMap().entries.map((entry) {
      int index = entry.key;
      var data = entry.value;
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'energy_source_name',
            value: data['energy_source_name']),

        // Daily View
        if (isDaily)
          DataGridCell<Widget>(
            columnName: 'consumption_total',
            value: Container(
              margin: const EdgeInsets.all(4),
              child: TextFormFieldCustom(
                controller: controllers[index],
                isOptional: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  energyData[index]['consumption_total'] =
                      double.tryParse(value) ?? 0.0;
                },
                hint: "Enter value",
              ),
            ),
          )

        // Monthly View with Three Columns
        else ...[
          DataGridCell<Widget>(
            columnName: 'consumption',
            value: Container(
              margin: const EdgeInsets.all(4),
              child: TextFormFieldCustom(
                controller: controllers[index],
                isOptional: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  energyData[index]['consumption'] =
                      double.tryParse(value) ?? 0.0;
                },
                hint: "Enter value",
              ),
            ),
          ),
          DataGridCell<Widget>(
            columnName: 'consumption_total',
            value: Container(
              margin: const EdgeInsets.all(4),
              child: TextFormFieldCustom(
                controller: controllersFinal[index],
                isOptional: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  energyData[index]['consumption_total'] =
                      double.tryParse(value) ?? 0.0;
                },
                hint: "Enter value",
              ),
            ),
          ),
        ],
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
        height: 60,
        alignment: Alignment.center,
        child: cell.value is Widget ? cell.value : Text(cell.value.toString()),
      );
    }).toList());
  }
}

class DatePickerDialog extends StatelessWidget {
  const DatePickerDialog({
    super.key,
    required this.date,
    required this.hint,
    required this.onPickDate,
    required this.onRemoveDate,
  });

  final String? date;
  final String hint;
  final VoidCallback onPickDate;
  final VoidCallback onRemoveDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPickDate,
      child: Container(
        height: 45,
        width: context.widthFull(),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(.3))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Center(
                child: date == null || date!.isEmpty
                    ? TextCustom(
                        date ?? "",
                        size: 13,
                        color: Palette.dark.withOpacity(.6),
                      )
                    : TextCustom(date ?? "",
                        maxLines: 1, fontWeight: FontWeight.w400, size: 14),
              ),
            ),
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.8),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  border: Border.all(color: Colors.grey.withOpacity(.3))),
              child: const Icon(
                Icons.calendar_month_rounded,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
