import 'package:auspower_flutter/common/widgets/empty.dart';
import 'package:auspower_flutter/common/widgets/shimmer_list.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/models/plant_list_data.dart';
import 'package:auspower_flutter/providers/company_provider.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/repositories/company_repository.dart';
import 'package:auspower_flutter/repositories/power_consumption_repository.dart';
import 'package:auspower_flutter/services/route/navigation.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/theme/theme_guide.dart';
import 'package:auspower_flutter/view/dashboardscreen.dart';
import 'package:auspower_flutter/view/homescreen/screen/company_screen.dart';
import 'package:auspower_flutter/view/homescreen/widgets/drawer.dart';
import 'package:auspower_flutter/view/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen(
      {super.key,
      required this.campusId,
      required this.companyId,
      required this.buId});
  final String campusId, companyId, buId;

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      if (authProvider.user?.employeeType == 'Operator' ||
          authProvider.user?.employeeType == 'Plant'&&
              authProvider.user?.isCampus == "no") {
        PowerConsumptionRepository().getPowerReportData(context);
        PowerConsumptionRepository().getCampusData(context);
        CompanyRepository().getPlantList(context,
            campusId: authProvider.user?.campusId.toString() ?? "",
            companyId: authProvider.user?.companyId.toString() ?? "",
            buId: authProvider.user?.buId ?? "");
        PowerConsumptionRepository().getCompanyData(
            context, authProvider.user?.campusId.toString() ?? "");
        PowerConsumptionRepository().getBusinessData(context,
            campusId: authProvider.user?.campusId.toString() ?? "",
            companyId: authProvider.user?.companyId.toString() ?? "");
        PowerConsumptionRepository().getPlantData(context, data: {
          "campus_id": authProvider.user?.campusId.toString() ?? "",
          "company_id": authProvider.user?.companyId.toString() ?? "",
          "bu_id": authProvider.user?.buId.toString() ?? ""
        });
      } else {
        CompanyRepository().getPlantList(context,
            campusId: widget.campusId.toString(),
            companyId: widget.companyId.toString(),
            buId: widget.buId);
      }
    });
    super.initState();
  }

  DateTime? lastBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (authProvider.user?.employeeType == 'Operator' ||
            authProvider.user?.employeeType == 'Plant'&&
              authProvider.user?.isCampus == "no") {
          final now = DateTime.now();
          bool allowPop = false;

          if (lastBackPressTime == null ||
              now.difference(lastBackPressTime!) > const Duration(seconds: 1)) {
            lastBackPressTime = now;
            Fluttertoast.showToast(
              msg: "Press back again to exit",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            return false; // Prevent exiting on first press
          } else {
            allowPop = true;
          }
          return allowPop; // Exit if double pressed
        } else {
          return true; // Allow back press for other users
        }
      },
      child: Scaffold(
        key: authProvider.user?.employeeType == 'Operator' ||
                authProvider.user?.employeeType == 'Plant'&&
              authProvider.user?.isCampus == "no"
            ? homeKey
            : null,
        drawer: authProvider.user?.employeeType == 'Operator' ||
                authProvider.user?.employeeType == 'Plant'&&
              authProvider.user?.isCampus == "no"
            ? const CustomDrawer()
            : null,
        appBar: CommonAppBar(
          title: "Plant List",
          action: authProvider.user?.employeeType == 'Operator' ||
                  authProvider.user?.employeeType == 'Plant'&&
              authProvider.user?.isCampus == "no"
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigation().push(context,
                                FadeRoute(page: const NotificationScreen()));
                          },
                          child:
                              const Icon(Icons.notifications_active_outlined)),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          leading: authProvider.user?.employeeType == 'Operator' ||
                  authProvider.user?.employeeType == 'Plant'&&
              authProvider.user?.isCampus == "no"
              ? InkWell(
                  onTap: () {
                    homeKey.currentState!.openDrawer();
                  },
                  child: const Icon(Icons.menu))
              : InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios)),
        ),
        body: SafeArea(
            child: RefreshIndicator(
          onRefresh: () async {
            CompanyRepository().getPlantList(context,
                campusId: widget.campusId.toString(),
                companyId: widget.companyId.toString(),
                buId: widget.buId);
          },
          child: Consumer<CompanyProvider>(
            builder: (context, company, child) {
              List<PlantListData> companyList = company.plantList?.data ?? [];
              return company.isLoading
                  ? const ShimmerList()
                  : companyList.isEmpty
                      ? const EmptyScreen()
                      : ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          children: [
                              ListView.builder(
                                  itemCount: companyList.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    PlantListData companyData =
                                        companyList[index];
                                    var totalKwh =
                                        (companyData.pmCommonKwh ?? 0.0) +
                                            (companyData.pmEquipmentKwh ?? 0.0);
                                    return Column(
                                      children: [
                                        const HeightFull(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                FadeRoute(
                                                    page: DashboardScreen(
                                                  companyData: companyData,
                                                )));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                                boxShadow:
                                                    ThemeGuide.primaryShadow,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                color: Colors.white),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextCustom(
                                                    companyData.plantName ?? "",
                                                    fontWeight: FontWeight.bold,
                                                    color: Palette.primary,
                                                    size: 16,
                                                  ),
                                                  const HeightHalf(),
                                                  RowWidget(
                                                    head1: 'Total KWh',
                                                    head2: 'Utilities KWh',
                                                    value1: "$totalKwh",
                                                    value2:
                                                        "${companyData.pmCommonKwh}",
                                                  ),
                                                  const HeightHalf(),
                                                  RowWidget(
                                                    head1: 'Equipments KWh',
                                                    head2: 'No Of Meters',
                                                    value1:
                                                        "${companyData.pmEquipmentKwh}",
                                                    value2:
                                                        "${companyData.pmMeterCount}",
                                                  ),
                                                  const HeightHalf(),
                                                  RowWidget(
                                                    head1: 'OFF',
                                                    head2: 'RUN',
                                                    head3: "IDLE",
                                                    value1:
                                                        "${companyData.offKwh}",
                                                    value2:
                                                        "${companyData.onLoadKwh}",
                                                    value3:
                                                        "${companyData.idleKwh}",
                                                    isThree: true,
                                                  ),
                                                  const HeightHalf(),
                                                  RowWidget(
                                                    head1: 'On Status',
                                                    head2: 'Off Status',
                                                    value1:
                                                        "${companyData.pmNocomNCount}",
                                                    value2:
                                                        "${companyData.pmNocomSCount}",
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ],
                                    );
                                  })
                            ]);
            },
          ),
        )),
      ),
    );
  }
}
