import 'package:auspower_flutter/common/widgets/empty.dart';
import 'package:auspower_flutter/common/widgets/shimmer_list.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/models/branch_list_data.dart';
import 'package:auspower_flutter/providers/company_provider.dart';
import 'package:auspower_flutter/repositories/company_repository.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/theme/theme_guide.dart';
import 'package:auspower_flutter/view/dashboardscreen.dart';
import 'package:auspower_flutter/view/homescreen/screen/company_screen.dart';
import 'package:auspower_flutter/view/homescreen/screen/plant_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BranchScreen extends StatefulWidget {
  const BranchScreen(
      {super.key, required this.campusId, required this.companyId});
  final String campusId, companyId;

  @override
  State<BranchScreen> createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      CompanyRepository().getBranchList(context,
          campusId: widget.campusId.toString(),
          companyId: widget.companyId.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "BU List",
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async {
          CompanyRepository().getBranchList(context,
              campusId: widget.campusId.toString(),
              companyId: widget.companyId.toString());
        },
        child: Consumer<CompanyProvider>(
          builder: (context, company, child) {
            List<BranchListData> companyList = company.branchList?.data ?? [];
            return company.isLoading || company.companyList == null
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
                                  BranchListData companyData =
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
                                                  page: PlantScreen(
                                                      campusId: companyData
                                                          .campusId
                                                          .toString(),
                                                      companyId: companyData
                                                          .companyId
                                                          .toString(),
                                                      buId: companyData.buId
                                                          .toString())));
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
                                                  companyData.buName ?? "",
                                                  color: Palette.primary,
                                                  fontWeight: FontWeight.bold,
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
    );
  }
}
