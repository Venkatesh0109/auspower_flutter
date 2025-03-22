import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/providers/power_consumption_provider.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/providers/table_provider.dart';
import 'package:auspower_flutter/repositories/power_consumption_repository.dart';
import 'package:auspower_flutter/repositories/table_repository.dart';
import 'package:auspower_flutter/services/route/navigation.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/utilities/extensions/context_extention.dart';
import 'package:auspower_flutter/view/dashboardscreen.dart';
import 'package:auspower_flutter/view/homescreen/screen/company_screen.dart';
import 'package:auspower_flutter/view/homescreen/widgets/report_widgets.dart';
import 'package:auspower_flutter/view/table_report/detail_power_consumption.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PowerConsumption extends StatefulWidget {
  const PowerConsumption({super.key});

  @override
  State<PowerConsumption> createState() => _PowerConsumptionState();
}

class _PowerConsumptionState extends State<PowerConsumption> {
  Map? campus;
  Map? company;
  Map? bu;
  Map? plant;
  Map? department;
  Map? equipment;
  Map? shift;

  String? periodName;
  String? groupByName;

  String? selectedDate;
  String? fromDate;
  String? toDate;

  int _selectedIndex = 0; // To keep track of the selected tab index

  final List<String> tabTitles = ['Detail', 'Summary', 'Cummulative'];
  List<Map<String, dynamic>> selectedMeter = [];
  List meterId = [];
  List<Map<String, dynamic>> powerFields = [];

  List powerFieldsMatch = [
    // {"field_name": "S.No"},
    {"field_name": "Date"},
    {"field_name": "Plant"},
    {"field_name": "Department"},
    {"field_name": "Equipment Name"},
    {"field_name": "meter"},
    {"field_name": "Energy"},
    {"field_name": "Shift"},
    {"field_name": "Shift1 Start C.kWh"},
    {"field_name": "Shift2 Start C.kWh"},
    {"field_name": "Shift3 Start C.kWh"},
    {"field_name": "Shift1 End C.kWh"},
    {"field_name": "Shift2 End C.kWh"},
    {"field_name": "Shift3 End C.kWh"},
    {"field_name": "Shift1 kWh"},
    {"field_name": "Shift2 kWh"},
    {"field_name": "Shift3 kWh"},
  ];

  List shiftData = [
    {"shift": "1"},
    {"shift": "2"},
    {"shift": "3"}
  ];

  Map? groupBy;
  List groupByLists = [
    {"groupBy": "Plant"},
    {"groupBy": "Department"},
    {"groupBy": "Equipment Group"},
    {"groupBy": "IOT Equipment"},
    {"groupBy": "Meter"},
  ];

  Map? period;
  List periodList = [
    {"name": "Running Shift"},
    {"name": "Shift"},
    {"name": "Date"},
    {"name": "From To"},
  ];

  Map? meterType;
  List meterTypeLists = [
    {"meterType": "All Meters"},
    {"meterType": "Primary Meters"},
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      initializeData();
      setState(() {});
    });
    super.initState();
  }

  void initializeData() {
    DateTime now = DateTime.now();
    selectedDate = DateFormat("dd-MM-yyyy").format(now);
    fromDate = DateFormat("dd-MM-yyyy").format(now);
    toDate = DateFormat("dd-MM-yyyy").format(now);
    // powerProvider.getCampusList([]);
    // powerProvider.getCompanyList([]);
    // powerProvider.getBusinessList([]);
    // powerProvider.getPlantList([]);
    // powerProvider.getDepartmentList([]);
    // powerProvider.getEquipmentList([]);
    // logger.e(authProvider.user?.toJson());
    if (authProvider.user?.employeeType == "Operator" ||
        authProvider.user?.employeeType == 'Plant' &&
            authProvider.user?.isCampus == "no") {
      campus = powerProvider.campusData.firstWhere(
          (e) => "${e["campus_id"]}" == authProvider.user?.campusId.toString(),
          orElse: () => {});
      company = powerProvider.companyData.firstWhere(
          (e) =>
              "${e["company_id"]}" == authProvider.user?.companyId.toString(),
          orElse: () => {});
      bu = powerProvider.buLists.firstWhere(
          (e) => "${e["bu_id"]}" == authProvider.user?.buId.toString(),
          orElse: () => {});

      plant = powerProvider.plantLists.firstWhere(
          (e) => "${e["plant_id"]}" == authProvider.user?.plantId.toString(),
          orElse: () => {});
      PowerConsumptionRepository().getDepartmentData(context, data: {
        "company_id": authProvider.user?.companyId.toString() ?? "",
        "bu_id": authProvider.user?.buId.toString() ?? "",
        "plant_id": authProvider.user?.plantId.toString() ?? "",
      });
    } else {
      campus = {"campus_name": "All"};
      company = {"company_name": "All"};
      bu = {"bu_name": "All"};
      plant = {"plant_name": "All"};
    }
    department = {"plant_department_name": "All"};
    equipment = {"equipment_group_name": "All"};
    groupBy = groupByLists.isNotEmpty ? groupByLists[4] : null;
    period = periodList.isNotEmpty ? periodList[0] : null;
    meterType = meterTypeLists.isNotEmpty ? meterTypeLists[0] : null;
    selectedMeter = [
      {"meter_id": 0, "meter_name": "All"},
    ];
    meterId = selectedMeter.map((item) => item["meter_id"] as int).toList();
    powerFields = List<Map<String, dynamic>>.from(powerProvider
        .powerReportFields
        .where((field) => powerFieldsMatch.any((staticField) =>
            staticField["field_name"] == field["field_name"])));
    groupByName = "meter";
    periodName = "cur_shift";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          title: "Power Consumption",
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios)),
          action: InkWell(
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              onTap: () {
                setState(() {
                  initializeData();
                });
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.refresh, color: Palette.pureWhite),
              ))),
      body: SafeArea(child: Consumer2<PowerConsumptionProvider, TableProvider>(
        builder: (context, value, table, child) {
          return ListView(padding: const EdgeInsets.all(12), children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enable horizontal scrolling
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(tabTitles.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedIndex == index
                              ? Palette.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: _selectedIndex == index
                                ? Palette.primary
                                : Palette.grey,
                          ),
                        ),
                        child: Text(
                          tabTitles[index].toUpperCase(),
                          style: TextStyle(
                            color: _selectedIndex == index
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
            ),

            const HeightFull(),
            const TextCustom("Select Campus :", size: 12, color: Palette.dark),
            const HeightHalf(),
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
                          campus = val as Map?;
                          PowerConsumptionRepository().getCompanyData(
                              context, "${campus?["campus_id"]}");
                          company = {"company_name": "All"};
                          bu = {"bu_name": "All"};
                          plant = {"plant_name": "All"};
                          department = {"plant_department_name": "All"};
                          equipment = {"equipment_group_name": "All"};
                          setState(() {});
                        },
                        head: "Select Campus"));
              },
              keys: 'campus_name',
            ),
            const HeightFull(),
            const TextCustom("Select Company :", size: 12, color: Palette.dark),
            const HeightHalf(),
            ContainerListDialogManualData(
              data: company,
              colors: Palette.pureWhite,
              hint: "Select Company",
              fun: () {
                commonDialog(
                    context,
                    DropdownDialogList(
                        courses: value.companyData,
                        dropdownKey: "company_name",
                        hint: "Company",
                        onSelected: (val) {
                          company = val as Map?;
                          PowerConsumptionRepository().getBusinessData(context,
                              campusId: "${campus?["campus_id"]}",
                              companyId: "${company?["company_id"]}");
                          PowerConsumptionRepository().getEquipmentData(context,
                              companyId: "${company?["company_id"]}");
                          bu = {"bu_name": "All"};
                          plant = {"plant_name": "All"};
                          department = {"plant_department_name": "All"};
                          equipment = {"equipment_group_name": "All"};

                          setState(() {});
                        },
                        head: "Select Company"));
              },
              keys: 'company_name',
            ),
            const HeightFull(),
            const TextCustom("Select BU :", size: 12, color: Palette.dark),
            const HeightHalf(),
            ContainerListDialogManualData(
              data: bu,
              colors: Palette.pureWhite,
              hint: "Select BU",
              fun: () {
                commonDialog(
                    context,
                    DropdownDialogList(
                        courses: value.buLists,
                        dropdownKey: "bu_name",
                        hint: "BU",
                        onSelected: (val) {
                          bu = val as Map?;

                          PowerConsumptionRepository()
                              .getPlantData(context, data: {
                            "campus_id": "${campus?["campus_id"]}",
                            "company_id": "${company?["company_id"]}",
                            "bu_id": "${bu?["bu_id"]}"
                          });
                          plant = {"plant_name": "All"};
                          department = {"plant_department_name": "All"};
                          equipment = {"equipment_group_name": "All"};
                          // logger.w(selectedOOR);
                          setState(() {});
                        },
                        head: "Select BU"));
              },
              keys: 'bu_name',
            ),
            const HeightFull(),
            const TextCustom("Select Plant :", size: 12, color: Palette.dark),
            const HeightHalf(),
            ContainerListDialogManualData(
              data: plant,
              colors: Palette.pureWhite,
              hint: "Select Plant",
              fun: () {
                commonDialog(
                    context,
                    DropdownDialogList(
                        courses: value.plantLists,
                        dropdownKey: "plant_name",
                        hint: "Plant",
                        onSelected: (val) {
                          plant = val as Map?;
                          PowerConsumptionRepository()
                              .getDepartmentData(context, data: {
                            "company_id": "${company?["company_id"]}",
                            "bu_id": "${bu?["bu_id"]}",
                            "plant_id": "${plant?["plant_id"]}",
                          });
                          department = {"plant_department_name": "All"};
                          equipment = {"equipment_group_name": "All"};
                          // logger.w(selectedOOR);
                          setState(() {});
                        },
                        head: "Select Plant"));
              },
              keys: 'plant_name',
            ),
            const HeightFull(),
            const TextCustom("Select Department :",
                size: 12, color: Palette.dark),
            const HeightHalf(),
            ContainerListDialogManualData(
              data: department,
              colors: Palette.pureWhite,
              hint: "Select Department",
              fun: () {
                commonDialog(
                    context,
                    DropdownDialogList(
                        courses: value.departmentLists,
                        dropdownKey: "plant_department_name",
                        hint: "Department",
                        onSelected: (val) {
                          department = val as Map?;
                          logger.f(department);
                          equipment = {"equipment_group_name": "All"};
                          // logger.w(selectedOOR);
                          setState(() {});
                        },
                        head: "Select Department"));
              },
              keys: 'plant_department_name',
            ),
            const HeightFull(),
            const TextCustom("Select Equipment Group :",
                size: 12, color: Palette.dark),
            const HeightHalf(),
            ContainerListDialogManualData(
              data: equipment,
              colors: Palette.pureWhite,
              hint: "Select Equipment Group",
              fun: () {
                commonDialog(
                    context,
                    DropdownDialogList(
                        courses: value.equipmentLists,
                        dropdownKey: "equipment_group_name",
                        hint: "Equipment Group",
                        onSelected: (val) {
                          equipment = val as Map?;
                          logger.f(equipment);

                          // logger.w(selectedOOR);
                          setState(() {});
                        },
                        head: "Select Equipment Group"));
              },
              keys: 'equipment_group_name',
            ),
            const HeightFull(),
            const TextCustom("Select Group By :",
                size: 12, color: Palette.dark),
            const HeightHalf(),
            ContainerListDialogManualData(
              data: groupBy,
              colors: Palette.pureWhite,
              hint: "Select Group By",
              fun: () {
                commonDialog(
                    context,
                    DropdownDialogList(
                        courses: groupByLists,
                        isSearch: true,
                        dropdownKey: "groupBy",
                        hint: "Group By",
                        onSelected: (val) {
                          groupBy = val as Map?;
                          if (groupBy?["groupBy"] == "Plant") {
                            groupByName = "plant";
                          } else if (groupBy?["groupBy"] == "Department") {
                            groupByName = "plant_department";
                          } else if (groupBy?["groupBy"] == "Equipment Group") {
                            groupByName = "equipment_group";
                          } else if (groupBy?["groupBy"] == "IOT Equipment") {
                            groupByName = "equipment";
                          } else if (groupBy?["groupBy"] == "Meter") {
                            groupByName = "meter";
                          }

                          // logger.w(selectedOOR);
                          setState(() {});
                        },
                        head: "Select Group By"));
              },
              keys: 'groupBy',
            ),
            const HeightFull(),
            const TextCustom("Select Meter Type :",
                size: 12, color: Palette.dark),
            const HeightHalf(),
            ContainerListDialogManualData(
              data: meterType,
              colors: Palette.pureWhite,
              hint: "Select Meter Type",
              fun: () {
                commonDialog(
                    context,
                    DropdownDialogList(
                        courses: meterTypeLists,
                        isSearch: true,
                        dropdownKey: "meterType",
                        hint: "Meter Type",
                        onSelected: (val) {
                          meterType = val as Map?;
                          selectedMeter = [];
                          PowerConsumptionRepository().getMeterData(context,
                              data: {
                                "company_id": "${company?["company_id"]}",
                                "bu_id": "${bu?["bu_id"]}",
                                "plant_id": "${plant?["plant_id"]}",
                                "plant_department_id": department?[
                                            "plant_department_id"] ==
                                        null
                                    ? ""
                                    : "${department?["plant_department_id"]}",
                                "equipment_group_id":
                                    equipment?["equipment_group_id"] == null
                                        ? ""
                                        : "${equipment?["equipment_group_id"]}",
                                "meter_type":
                                    meterType?["meterType"] == "All Meters"
                                        ? ""
                                        : "primary"
                              },
                              isAll: true);
                          // logger.w(selectedOOR);
                          setState(() {});
                        },
                        head: "Select Meter Type"));
              },
              keys: 'meterType',
            ),
            const HeightFull(),
            const TextCustom("Select Meter :", size: 12, color: Palette.dark),
            const HeightHalf(),
            ContainerListDialog(
              data: selectedMeter,
              hint: "Meter",
              key1: 'meter_name',
              fun: () async {
                // Open the dialog for selecting items
                await commonDialog(
                  context,
                  MultiselectDialogList(
                    courses: value.meterLists, // Your available options
                    dropdownKey: 'meter_name',
                    hint: "Meter",
                    onSelected: (selectedItems) {
                      setState(() {
                        selectedMeter = List.from(
                            selectedItems as List<Map<String, dynamic>>);
                        logger.f(selectedMeter);
                        meterId = selectedMeter
                            .map((item) => item["meter_id"])
                            .toList();
                      });
                    },
                    head: "Meter",
                    selectedList: selectedMeter,
                  ),
                );
                setState(() {}); // Trigger UI update after dialog
              },
            ),
            const HeightFull(),
            const TextCustom("Select Period :", size: 12, color: Palette.dark),
            const HeightHalf(),
            ContainerListDialogManualData(
              data: period,
              colors: Palette.pureWhite,
              hint: "Select Period",
              fun: () {
                commonDialog(
                    context,
                    DropdownDialogList(
                        isSearch: true,
                        courses: periodList,
                        dropdownKey: "name",
                        hint: "Period",
                        onSelected: (val) {
                          period = val as Map?;
                          if (period?["name"] == "Running Shift") {
                            periodName = "cur_shift";
                          } else if (period?["name"] == "Shift") {
                            periodName = "sel_shift";
                          } else if (period?["name"] == "Date") {
                            periodName = "sel_date";
                          } else if (period?["name"] == "From To") {
                            periodName = "from_to";
                          }
                          shift = {};
                          selectedDate =
                              DateFormat("dd-MM-yyyy").format(DateTime.now());
                          fromDate =
                              DateFormat("dd-MM-yyyy").format(DateTime.now());
                          toDate =
                              DateFormat("dd-MM-yyyy").format(DateTime.now());
                          // logger.w(selectedOOR);
                          setState(() {});
                        },
                        head: "Select Period"));
              },
              keys: 'name',
            ),

            if (period?["name"] == "From To") ...[
              const HeightFull(),
              Row(
                children: [
                  Expanded(
                    child: DatePickerDialogs(
                      date: fromDate,
                      hint: "Select From Date",
                      onPickDate: () async {
                        await pickDate(context, (String? pickedDate) {
                          setState(() {
                            fromDate = pickedDate;
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
            ],
            if (period?["name"] == "Date") ...[
              const HeightFull(),
              DatePickerDialogs(
                date: selectedDate,
                hint: "Select a Date",
                onPickDate: () async {
                  await pickDate(context, (String? pickedDate) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  });
                },
                onRemoveDate: () {
                  setState(() {
                    selectedDate = null; // Clear the selected date
                  });
                },
              ),
            ],
            if (period?["name"] == "Shift") ...[
              const HeightFull(),
              DatePickerDialogs(
                date: selectedDate,
                hint: "Select a Date",
                onPickDate: () async {
                  await pickDate(context, (String? pickedDate) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  });
                },
                onRemoveDate: () {
                  setState(() {
                    selectedDate = null; // Clear the selected date
                  });
                },
              ),
              const HeightFull(),
              ContainerListDialogManualData(
                data: shift,
                colors: Palette.pureWhite,
                hint: "Select Shift",
                fun: () {
                  commonDialog(
                      context,
                      DropdownDialogList(
                          courses: shiftData,
                          isSearch: true,
                          dropdownKey: "shift",
                          hint: "Shift",
                          onSelected: (val) {
                            shift = val as Map?;
                            logger.w(shift);
                            setState(() {});
                          },
                          head: "Select Shift"));
                },
                keys: 'shift',
              ),
            ],
            const HeightFull(),
            const TextCustom("Select Report Fields :",
                size: 12, color: Palette.dark),
            const HeightHalf(),
            ContainerListDialog(
              data: powerFields,
              hint: "Report Fields",
              key1: 'field_name',
              fun: () async {
                await commonDialog(
                  context,
                  MultiselectDialogList(
                    isSelect: true,
                    courses: value.powerReportFields,
                    dropdownKey: 'field_name',
                    hint: "Report Fields",
                    onSelected: (selectedItems) {
                      setState(() {
                        List<Map<String, dynamic>> selectedItemsList =
                            (selectedItems as List)
                                .whereType<Map<String, dynamic>>()
                                .toList();
                        powerFields = selectedItemsList;
                      });
                    },
                    head: "Report Fields",
                    selectedList: powerFields,
                  ),
                );
                setState(() {}); // Trigger UI update after dialog
              },
            ),
            const HeightFull(multiplier: 2),
            DoubleButton(
                isLoading: table.isLoading,
                primaryLabel: "View",
                secondarylabel: "Cancel",
                primaryOnTap: () {
                  logger.e(groupBy);
                  Map<String, dynamic> tableParams = {
                    "company_id": company?["company_id"] == null
                        ? ""
                        : "${company?["company_id"]}",
                    "bu_id": bu?["bu_id"] == null ? "" : "${bu?["bu_id"]}",
                    "campus_id": campus?["campus_id"] == null
                        ? ""
                        : "${campus?["campus_id"]}",
                    "plant_id": plant?["plant_id"] == null
                        ? ""
                        : "${plant?["plant_id"]}",
                    "plant_department_id":
                        department?["plant_department_id"] == null
                            ? ""
                            : "${department?["plant_department_id"]}",
                    "meter_id": meterId.isEmpty ||
                            (meterId.length == 1 && meterId[0] == 0)
                        ? ""
                        : meterId.join(
                            ","), // Convert list to a comma-separated string

                    // "meter_id": "",
                    "equipment_group_id":
                        equipment?["equipment_group_id"] == null
                            ? ""
                            : "${equipment?["equipment_group_id"]}",
                    "meter_type": meterType?["meterType"] == "All Meters"
                        ? ""
                        : "primary",
                    "groupby": groupByName,
                    "group_for": "regular",
                    "period_id": periodName,
                    "from_date":
                        period?["name"] == "Shift" || period?["name"] == "Date"
                            ? selectedDate
                            : fromDate,
                    "to_date": toDate == null || toDate == "" ? "" : toDate,
                    "shift_id":
                        shift?["shift"] == null ? "" : "${shift?["shift"]}",
                    "report_for": tabTitles[_selectedIndex].toLowerCase(),
                    "reportfor": "6to6",
                  };
                  // if (period?["name"] == "Shift") {
                  //   tableParams.addAll({
                  //     "from_date": selectedDate,
                  //     "to_date": toDate == null || toDate == "" ? "" : toDate,
                  //   });
                  // }
                  // if (period?["name"] == "From To") {
                  //   tableParams.addAll({
                  //     "from_date": fromDate,
                  //     "to_date": toDate == null || toDate == "" ? "" : toDate,
                  //   });
                  // }
                  logger.v(tableParams);
                  TableRepository()
                      .getPowerConsumptionData(context, params: tableParams)
                      .then((v) {
                    Navigation().push(
                        context,
                        FadeRoute(
                            page: DetailpowerConnsumptionTable(
                          reportHead: powerFields,
                        )));
                  });
                },
                secondaryOnTap: () {
                  Navigator.pop(context);
                })
            // ButtonPrimary(onPressed: () {}, label: "View")
          ]);
        },
      )),
    );
  }
}

class DatePickerDialogs extends StatelessWidget {
  const DatePickerDialogs({
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
