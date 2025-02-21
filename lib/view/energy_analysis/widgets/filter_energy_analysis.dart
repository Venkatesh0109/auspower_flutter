import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/providers/filter_store_provider.dart';
import 'package:auspower_flutter/providers/power_consumption_provider.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/repositories/power_consumption_repository.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/view/energy_analysis/screens/energy_analysis_screen.dart';
import 'package:auspower_flutter/view/homescreen/widgets/report_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List detailsTopBar = [
  {
    "name": "Live",
    "group_for": "regular",
    "report_for": "detail",
    "period_id": "cur_shift",
    "groupby": "meter",
    "plant_id": "0",
    "company_id": "0",
    "meter_id": "1",
  },
  {
    "name": "Previous Shift",
    "group_for": "regular",
    "report_for": "detail",
    "period_id": "#previous_shift",
    "groupby": "meter",
    "plant_id": "0",
    "company_id": "0",
    "meter_id": "1",
  },
  {
    "name": "Previous Day",
    "group_for": "regular",
    "report_for": "detail",
    "period_id": "#previous_day",
    "groupby": "meter",
    "plant_id": "0",
    "company_id": "0",
    "meter_id": "1",
  },
  {
    "name": "This Week",
    "group_for": "regular",
    "report_for": "detail",
    "period_id": "#this_week",
    "groupby": "meter",
    "plant_id": "0",
    "company_id": "0",
    "meter_id": "1",
  },
  {
    "name": "This Month",
    "group_for": "regular",
    "report_for": "detail",
    "period_id": "#this_month",
    "groupby": "meter",
    "plant_id": "0",
    "company_id": "0",
    "meter_id": "1",
  },
  {
    "name": "This Year",
    "group_for": "regular",
    "report_for": "detail",
    "period_id": "#this_year",
    "groupby": "meter",
    "plant_id": "0",
    "company_id": "0",
    "meter_id": "1",
  },
  {
    "name": "Custom",
    "group_for": "regular",
    "report_for": "detail",
    "period_id": "#from_to",
    "groupby": "meter",
    "plant_id": "0",
    "company_id": "0",
    "meter_id": "1",
  },
];

class FilterGraph extends StatefulWidget {
  const FilterGraph({
    super.key,
    required this.periodId,
  });
  final String periodId;

  @override
  State<FilterGraph> createState() => _FilterGraphState();
}

class _FilterGraphState extends State<FilterGraph> {
  // Map? campus;
  // Map? company;
  // Map? bu;
  // Map? plant;

  // String? groupByName;

  // Map? groupBy;
  // Map? meter;
  // List groupByLists = [
  //   {"groupBy": "Plant"},
  //   {"groupBy": "Department"},
  //   {"groupBy": "Equipment Group"},
  //   {"groupBy": "IOT Equipment"},
  //   {"groupBy": "Meter"},
  // ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      PowerConsumptionRepository().getMeterData(context,
          data: {
            "company_id": "",
            "bu_id": "",
            "campus_id": "",
            "plant_id": "",
          },
          isAll: false);
      // initializeData();
      setState(() {});
    });
    super.initState();
  }

  // void initializeData() {
  //   campus = {"campus_name": "All"};
  //   company = {"company_name": "All"};
  //   bu = {"bu_name": "All"};
  //   plant = {"plant_name": "All"};
  //   groupBy = groupByLists.isNotEmpty ? groupByLists[4] : null;
  //   groupByName = "meter";
  //   meter = powerProvider.meterLists[0];
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer2<FilterStoreProvider, PowerConsumptionProvider>(
      builder: (context, filter, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const SizedBox(width: 24),
              const TextCustom("Filter", size: 16),
              InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close))
            ]),
            const HeightFull(),
            const TextCustom("Select Campus :", size: 12, color: Palette.grey),
            const HeightHalf(),
            ContainerListDialogManualData(
              data: filter.campus,
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
                          filter.setCampus(val as Map);
                          PowerConsumptionRepository().getCompanyData(
                              context, "${filter.campus?["campus_id"]}");
                        },
                        head: "Select Campus"));
              },
              keys: 'campus_name',
            ),
            const HeightFull(),
            const TextCustom("Select Company :", size: 12, color: Palette.grey),
            const HeightHalf(),
            ContainerListDialogManualData(
              data: filter.company,
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
                          filter.setCompany(val as Map);
                          PowerConsumptionRepository().getBusinessData(
                            context,
                            campusId: "${filter.campus?["campus_id"]}",
                            companyId: "${filter.company?["company_id"]}",
                          );
                          PowerConsumptionRepository().getEquipmentData(
                            context,
                            companyId: "${filter.company?["company_id"]}",
                          );
                        },
                        head: "Select Company"));
              },
              keys: 'company_name',
            ),
            const HeightFull(),
            const TextCustom("Select Bu :", size: 12, color: Palette.grey),
            const HeightHalf(),
            ContainerListDialogManualData(
              data: filter.bu,
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
                          filter.setBu(val as Map);
                          PowerConsumptionRepository().getPlantData(
                            context,
                            data: {
                              "campus_id": "${filter.campus?["campus_id"]}",
                              "company_id": "${filter.company?["company_id"]}",
                              "bu_id": "${filter.bu?["bu_id"]}",
                            },
                          );
                        },
                        head: "Select BU"));
              },
              keys: 'bu_name',
            ),
            const HeightFull(),
            const TextCustom("Select Plant :", size: 12, color: Palette.grey),
            const HeightHalf(),
            ContainerListDialogManualData(
              data: filter.plant,
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
                          filter.setPlant(val as Map);
                          PowerConsumptionRepository().getMeterData(context,
                              data: {
                                "company_id":
                                    "${filter.company?["company_id"]}",
                                "bu_id": "${filter.bu?["bu_id"]}",
                                "plant_id": "${filter.plant?["plant_id"]}",
                              },
                              isAll: false);
                        },
                        head: "Select Plant"));
              },
              keys: 'plant_name',
            ),
            const HeightFull(),
            const TextCustom("Select Group By :",
                size: 12, color: Palette.grey),
            const HeightHalf(),
            ContainerListDialogManualData(
              data: filter.groupBy,
              colors: Palette.pureWhite,
              hint: "Select Group By",
              fun: () {
                commonDialog(
                    context,
                    DropdownDialogList(
                        courses: filter.groupByLists,
                        isSearch: true,
                        dropdownKey: "groupBy",
                        hint: "Group By",
                        onSelected: (val) {
                          filter.setGroupBy(val as Map);
                        },
                        head: "Select Group By"));
              },
              keys: 'groupBy',
            ),
            const HeightFull(),
            const TextCustom("Select Meter :", size: 12, color: Palette.grey),
            const HeightHalf(),
            ContainerListDialogManualData(
              data: filter.meter,
              colors: Palette.pureWhite,
              hint: "Select Meter",
              fun: () {
                commonDialog(
                    context,
                    DropdownDialogList(
                        courses: value.meterLists,
                        isSearch: true,
                        dropdownKey: "meter_name",
                        dropdownKey1: "meter_code",
                        hint: "Meter",
                        onSelected: (val) {
                          filter.setMeter(val as Map);
                        },
                        head: "Select Meter"));
              },
              keys: 'meter_name',
              key1: 'meter_code',
            ),
            const HeightFull(),
            DoubleButton(
                primaryLabel: "View",
                secondarylabel: "Cancel",
                primaryOnTap: () {
                  PowerConsumptionRepository()
                      .getEnergyAnalysisChart(context, params: {
                    "group_for": "regular",
                    "report_for": "cumulative",
                    "period_id": widget.periodId,
                    "groupby": "meter",
                    "plant_id": "0",
                    "company_id": "0",
                    "meter_id": filter.meter?["meter_id"],
                    "is_minmax": "yes"
                  }).then((value) {
                    dataSource = EnergyAnalysisGridSource(
                        powerProvider.energyAnalysis?.data ?? []);
                    Navigator.pop(context);
                  });
                },
                secondaryOnTap: () => Navigator.pop(context)),
          ],
        );
      },
    );
  }
}
