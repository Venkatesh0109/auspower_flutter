import 'package:auspower_flutter/common/widgets/loaders.dart';
import 'package:auspower_flutter/models/plant_list_data.dart';
import 'package:auspower_flutter/providers/power_consumption_provider.dart';
import 'package:auspower_flutter/providers/table_provider.dart';
import 'package:auspower_flutter/repositories/power_consumption_repository.dart';
import 'package:auspower_flutter/repositories/table_repository.dart';
import 'package:auspower_flutter/theme/theme_guide.dart';
import 'package:auspower_flutter/utilities/extensions/context_extention.dart';
import 'package:auspower_flutter/view/dashboardscreen.dart';
import 'package:auspower_flutter/view/homescreen/screen/company_screen.dart';
import 'package:auspower_flutter/view/homescreen/widgets/report_widgets.dart';
import 'package:flutter/material.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/view/homescreen/widgets/sheetview_widget.dart';
import 'package:provider/provider.dart';

class SheetViewScreen extends StatefulWidget {
  const SheetViewScreen({super.key, required this.companyData});
  final PlantListData companyData;

  @override
  State<SheetViewScreen> createState() => _SheetViewScreenState();
}

class _SheetViewScreenState extends State<SheetViewScreen> {
  int _selectedIndex = 0;

  final List<String> tabTitles = ['Sheet View', 'Grid View'];

  Map selectedIpAddress = {};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      PowerConsumptionRepository().getIpaddress(context,
          plantId: widget.companyData.plantId.toString());
    });
    super.initState();
  }

  // This is used to toggle the content based on the selected index

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // logger.f(widget.companyData.toJson());
    return Consumer<PowerConsumptionProvider>(
      builder: (context, ip, child) {
        return Scaffold(
          appBar: CommonAppBar(
            title: "Meter Matrix",
            leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios)),
          ),
          body: SafeArea(
            child: RefreshIndicator(
                color: Palette.primary,
                onRefresh: () async {
                  TableRepository().gettableData(
                    context,
                    params: {
                      "plant_id": widget.companyData.plantId.toString(),
                      "group_for": 'regular',
                      "groupby": 'meter',
                      "period_id": 'cur_shift',
                    },
                  );
                },
                child: isPortrait && context.isMobile()
                    ? Column(
                        children: sheetViewChildren(context, ip),
                      )
                    : ListView(children: sheetViewChildren(context, ip))),
          ),
        );
      },
    );
  }

  List<Widget> sheetViewChildren(
      BuildContext context, PowerConsumptionProvider ip) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return [
      const HeightFull(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(tabTitles.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                      color:
                          _selectedIndex == index ? Colors.white : Palette.dark,
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
      if (_selectedIndex == 0)
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ContainerListDialogManualData(
                data: selectedIpAddress,
                colors: Palette.pureWhite,
                hint: "Filter By Ip Address",
                fun: () {
                  commonDialog(
                      context,
                      DropdownDialogList(
                        courses: ip.ipAddress,
                        isSearch: true,
                        dropdownKey: "ip_address",
                        hint: "Ip Address",
                        onSelected: (val) {
                          selectedIpAddress = val as Map;
                          TableRepository().gettableData(
                            context,
                            params: {
                              "plant_id": widget.companyData.plantId.toString(),
                              "group_for": 'regular',
                              "groupby": 'meter',
                              "period_id": 'cur_shift',
                              "converter_id": selectedIpAddress['converter_id'],
                            },
                          );
                          setState(() {});
                        },
                        head: "Select Ip Address",
                      ));
                },
                keys: 'ip_address',
              ),
            ),
            const HeightFull(),
          ],
        ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const TextCustom("Total Meters: "),
                TextCustom("${widget.companyData.meterCount}",
                    color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ],
            ),
            Row(
              children: [
                const TextCustom("On Meters: "),
                TextCustom("${widget.companyData.nocomNCount}",
                    color: Palette.greenAccent, fontWeight: FontWeight.bold),
              ],
            ),
            Row(
              children: [
                const TextCustom("Off Meters: "),
                TextCustom("${widget.companyData.nocomSCount}",
                    color: Colors.red, fontWeight: FontWeight.bold),
              ],
            ),
          ],
        ),
      ),
      const HeightFull(),
      ip.isLoading
          ? const Loader()
          : isPortrait && context.isMobile()
              ? Expanded(
                  child: _selectedIndex == 0
                      ? const SheetViewWidget()
                      : const GridViewWidget())
              : _selectedIndex == 0
                  ? const SheetViewWidget()
                  : const GridViewWidget()
    ];
  }
}

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({super.key});

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Consumer<TableProvider>(
      builder: (context, value, child) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: value.isLoading
                ? const Center(child: Loader())
                : SizedBox(
                    height: isPortrait && context.isMobile()
                        ? 0
                        : (value.currentpowerTableData.length / 2).ceil() *
                                context.heightFull() /
                                1.5 -
                            250, // ✅ 70% of screen height

                    child: GridView.builder(
                      itemCount: value.currentpowerTableData.length,
                      physics: isPortrait && context.isMobile()
                          ? const AlwaysScrollableScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: screenWidth > 600 ? 2.1 : 1.3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        final gridViewData = value.currentpowerTableData[index];
                        bool isRunning = gridViewData.nocom == 'N';
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: ThemeGuide.cardDecoration(),
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextCustom(
                                        "${gridViewData.meterName}",
                                        fontWeight: FontWeight.bold,
                                        color: Palette.primary.withOpacity(.7),
                                        size: 13,
                                        maxLines: 2,
                                      ),
                                    ),
                                    // LayoutBuilder(
                                    //   builder: (context, constraints) {
                                    //     if (gridViewData.meterName
                                    //             .toString()
                                    //             .length >
                                    //         (constraints.maxWidth / 6)) {
                                    //       return Marquee(
                                    //         text: gridViewData.meterName
                                    //             .toString(),
                                    //         style: const TextStyle(
                                    //             fontSize: 13,
                                    //             color: Palette.primary,
                                    //             fontWeight: FontWeight.bold),
                                    //         scrollAxis: Axis.horizontal,
                                    //         blankSpace: 20.0,
                                    //         velocity: 30.0,
                                    //         pauseAfterRound:
                                    //             const Duration(seconds: 1),
                                    //         startPadding: 10.0,
                                    //         accelerationDuration:
                                    //             const Duration(seconds: 1),
                                    //         accelerationCurve: Curves.linear,
                                    //         decelerationDuration:
                                    //             const Duration(
                                    //                 milliseconds: 500),
                                    //         decelerationCurve: Curves.easeOut,
                                    //       );
                                    //     } else {
                                    //       return
                                    //     }
                                    //   },
                                    // ),
                                    // Expanded(
                                    //   child: TextCustom(
                                    //     "${gridViewData.meterName}adadaadadadaadaadadad",
                                    //     fontWeight: FontWeight.bold,
                                    //     color: Palette.primary.withOpacity(.7),
                                    //     size: 13,
                                    //     maxLines: 1,
                                    //   ),
                                    // ),
                                    MachineStatusItem(
                                      width: 14,
                                      height: 14,
                                      isRunning: isRunning,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextCustom(
                                    "Energy : ${gridViewData.kWh}",
                                    color: Palette.dark,
                                  ),
                                ],
                              ),
                              const HeightHalf(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextCustom(
                                    "PF : ${gridViewData.avgPowerfactor}",
                                    color: Palette.dark,
                                  ),
                                ],
                              ),
                              const HeightHalf(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextCustom(
                                    "Kw : ${gridViewData.kw}",
                                    color: Palette.dark,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ));
      },
    );
  }
}
