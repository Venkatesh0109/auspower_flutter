import 'package:auspower_flutter/common/widgets/loaders.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/models/plant_list_data.dart';
import 'package:auspower_flutter/providers/table_provider.dart';
import 'package:auspower_flutter/repositories/table_repository.dart';
import 'package:auspower_flutter/theme/theme_guide.dart';
import 'package:auspower_flutter/view/dashboardscreen.dart';
import 'package:auspower_flutter/view/homescreen/screen/company_screen.dart';
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
  int _selectedIndex = 0; // To keep track of the selected tab index

  final List<String> tabTitles = [
    'Sheet View',
    'Grid View'
  ]; // Dynamic list of tab titles

  // This is used to toggle the content based on the selected index

  @override
  Widget build(BuildContext context) {
    logger.f(widget.companyData.toJson());
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
            TableRepository().gettableData(context,
                plantId: widget.companyData.plantId.toString());
          },
          child: Column(
            children: [
              const HeightFull(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the row horizontally
                  children: List.generate(tabTitles.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0), // Add space between tabs
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index; // Update the selected tab
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const TextCustom("Total Meters: "),
                        TextCustom("${widget.companyData.meterCount}",
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                    Row(
                      children: [
                        const TextCustom("On Meters: "),
                        TextCustom("${widget.companyData.nocomNCount}",
                            color: Palette.greenAccent,
                            fontWeight: FontWeight.bold),
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
              Expanded(
                  child: _selectedIndex == 0
                      ? const SheetViewWidget()
                      : const GridViewWidget())
            ],
          ),
        ),
      ),
    );
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
    return Consumer<TableProvider>(
      builder: (context, value, child) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: value.isLoading
                ? const Center(child: Loader())
                : GridView.builder(
                    itemCount: value.currentpowerTableData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: screenWidth > 600 ? 1.7 : 1.3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
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
                  ));
      },
    );
  }
}
