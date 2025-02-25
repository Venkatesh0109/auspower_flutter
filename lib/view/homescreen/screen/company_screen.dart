import 'package:auspower_flutter/common/widgets/empty.dart';
import 'package:auspower_flutter/common/widgets/shimmer_list.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/main.dart';
import 'package:auspower_flutter/models/company_list_model.dart';
import 'package:auspower_flutter/providers/company_provider.dart';
import 'package:auspower_flutter/repositories/company_repository.dart';
import 'package:auspower_flutter/repositories/power_consumption_repository.dart';
import 'package:auspower_flutter/services/route/navigation.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/theme/theme_guide.dart';
import 'package:auspower_flutter/view/dashboardscreen.dart';
import 'package:auspower_flutter/view/homescreen/screen/branch_screen.dart';
import 'package:auspower_flutter/view/homescreen/widgets/drawer.dart';
import 'package:auspower_flutter/view/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      CompanyRepository().getCompanyList(context, campusId: '');
      PowerConsumptionRepository().getPowerReportData(context);
      PowerConsumptionRepository().getCampusData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeKey,
      drawer: const CustomDrawer(),
      appBar: CommonAppBar(
        title: "Company List",
        action: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigation().push(
                        context, FadeRoute(page: const NotificationScreen()));
                  },
                  child: const Icon(Icons.notifications_active_outlined)),
            ],
          ),
        ),
        leading: InkWell(
            onTap: () {
              homeKey.currentState!.openDrawer();
            },
            child: const Icon(Icons.menu)),
      ),
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async {
          CompanyRepository().getCompanyList(context, campusId: '');
        },
        child: Consumer<CompanyProvider>(
          builder: (context, company, child) {
            List<CompanyListData> companyList = company.companyList?.data ?? [];
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
                              CompanyListData companyData = companyList[index];
                              var totalKwh = (companyData.pmCommonKwh ?? 0.0) +
                                  (companyData.pmEquipmentKwh ?? 0.0);

                              return Column(
                                children: [
                                  const HeightFull(),
                                  InkWell(
                                    onTap: () {
                                      // _sendTestNotification();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BranchScreen(
                                            campusId:
                                                companyData.campusId.toString(),
                                            companyId: companyData.companyId
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        boxShadow: ThemeGuide.primaryShadow,
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextCustom(
                                            companyData.companyName ?? "",
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
                                            value1: "${companyData.offKwh}",
                                            value2: "${companyData.onLoadKwh}",
                                            value3: "${companyData.idleKwh}",
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      );
          },
        ),
      )),
    );
  }

  // Function to send a test notification
  void sendTestNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'test_channel_id',
      'Test Notifications',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      // showBadge: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // notification id
      'Test Notification Title', // title
      'This is a test notification body.', // body
      platformDetails, // notification details
    );
  }
}

class RowWidget extends StatefulWidget {
  const RowWidget(
      {super.key,
      required this.head1,
      required this.head2,
      required this.value1,
      required this.value2,
      this.isThree = false,
      this.head3,
      this.value3});
  final String head1, head2;
  final String value1, value2;
  final String? head3, value3;
  final bool? isThree;

  @override
  State<RowWidget> createState() => _RowWidgetState();
}

class _RowWidgetState extends State<RowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
            crossAxisAlignment: widget.head1 == "On Status"
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              TextCustom(
                widget.head1,
                fontWeight: FontWeight.bold,
                size: 13,
                color:
                    widget.head1 == "On Status" ? Colors.green : Colors.black,
              ),
              const SizedBox(height: 4),
              TextCustom(
                widget.value1,
                color:
                    widget.head1 == "On Status" ? Colors.green : Colors.black,
              )
            ]),
        if (widget.isThree == true) ...[
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            TextCustom(
              widget.head3 ?? "",
              fontWeight: FontWeight.bold,
              size: 13,
            ),
            const SizedBox(height: 4),
            TextCustom(widget.value3 ?? "")
          ]),
        ],
        Column(
            crossAxisAlignment: widget.head2 == "Off Status"
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.end,
            children: [
              TextCustom(
                widget.head2,
                fontWeight: FontWeight.bold,
                size: 13,
                color: widget.head2 == "Off Status" ? Colors.red : Colors.black,
              ),
              const SizedBox(height: 4),
              TextCustom(
                widget.value2,
                color: widget.head2 == "Off Status" ? Colors.red : Colors.black,
              )
            ]),
      ],
    );
  }
}

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    this.leading,
    this.action,
    this.height,
  });

  final String title;
  final Widget? leading;
  final double? height;
  final Widget? action;

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.leading,
      title: Text(
        widget.title,
        style: const TextStyle(
          fontFamily: "Mulish",
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Palette.primary,
      iconTheme: const IconThemeData(
        color: Colors.white, // Change your color here
      ),
      actions: widget.action != null ? [widget.action!] : null,
    );
  }
}
