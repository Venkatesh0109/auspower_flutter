import 'dart:async';
import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/assets/local_images.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/models/auth_user.dart';
import 'package:auspower_flutter/providers/auth_provider.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/services/route/navigation.dart';
import 'package:auspower_flutter/services/storage/storage_constants.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/utilities/extensions/context_extention.dart';
import 'package:auspower_flutter/view/dashboardscreen.dart';
import 'package:auspower_flutter/view/energy_analysis/screens/energy_analysis_screen.dart';
import 'package:auspower_flutter/view/homescreen/screen/power_consumption.dart';
import 'package:auspower_flutter/view/homescreen/widgets/logout_dialog.dart';
import 'package:auspower_flutter/view/homescreen/widgets/report_widgets.dart';
import 'package:auspower_flutter/view/activity/screens/energy_entry.dart';
import 'package:auspower_flutter/view/report/screens/meter_reset_report.dart';
import 'package:auspower_flutter/view/report/screens/power_factor_variation_report.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String _currentTime = "";
  String _currentDate = "";
  Timer? _timer;

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime =
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
      _currentDate = "${now.day}/${now.month}/${now.year}";
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _updateTime();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _updateTime();
      });
      // logger.f(authProvider.user?.employeeType);
      String authDetails =
          await storage.read(key: StorageConstants.authCreds) ?? '';
      authProvider.user = AuthUser.fromJson(jsonDecode(authDetails));
      // logger.w(authProvider.user?.toJson());
      // if (authProvider.user?.employeeType != 'Admin' ||
      //     authProvider.user?.employeeType == 'Operator'||authProvider.user?.employeeType == 'Plant') {
      //   drawerList.removeWhere((element) {
      //     return element['id'] == 3;
      //   });
      // }
      setState(() {});
    });
    super.initState();
  }

  List drawerList = [
    {
      'id': 1,
      'title': 'Analysis',
      'img': LocalImages.analysis,
      'children': [
        {
          'id': 1,
          'title': 'Energy Analysis',
          'onTap': const EnergyAnalysisScreen()
        },
      ],
      'onTap': () {}
    },
    // {
    //   'id': 2,
    //   'title': 'Master',
    //   'img': LocalImages.master,
    //   'children': [
    //     {'id': 5, 'title': 'Company', 'onTap': () {}},
    //     {'id': 6, 'title': 'Business Unit', 'onTap': () {}},
    //     {'id': 7, 'title': 'Plant', 'onTap': () {}},
    //     {'id': 8, 'title': 'Department', 'onTap': () {}},
    //   ],
    //   'onTap': () {}
    // },
    {
      'id': 3,
      'title': 'Activity',
      'img': LocalImages.activity,
      'children': [
        {'id': 1, 'title': 'Energy Entry', 'onTap': const EnergyEntryScreen()},
      ],
      'onTap': () {}
    },
    // {
    //   'id': 4,
    //   'title': 'Settings',
    //   'img': LocalImages.settings,
    //   'children': [
    //     {'id': 1, 'title': 'User Rights', 'onTap': () {}},
    //     {'id': 2, 'title': 'Report Rights', 'onTap': () {}},
    //     {'id': 3, 'title': 'Order Wise', 'onTap': () {}},
    //     // {'id': 4, 'title': 'Reports', 'onTap': () {}},
    //   ],
    //   'onTap': () {}
    // },
    {
      'id': 5,
      'title': 'Report',
      'img': LocalImages.report,
      'children': [
        {'id': 1, 'title': 'Power Report', 'onTap': const PowerConsumption()},
        {
          'id': 2,
          'title': 'Meter Reset Report',
          'onTap': const MeterResetReportScreen()
        },
        {
          'id': 3,
          'title': 'Power Factor Variation Report',
          'onTap': const PowerFactorVariationReport()
        },
        // {'id': 1, 'title': 'Text Report', 'onTap': TextSearch()},
        // {
        //   'id': 2,
        //   'title': 'Energy Report',
        //   'onTap': EnergyReportScreen(),
        // },
        // {'id': 3, 'title': 'TNEB', 'onTap': () {}},
        // {'id': 4, 'title': 'Yearly Energy', 'onTap': () {}},
        // {'id': 4, 'title': 'Monthly Energy', 'onTap': () {}},
      ],
      'onTap': () {}
    },
    // {'id': 4, 'title': 'Earnings', 'img': "", 'children': [], 'onTap': () {}},
    // {'id': 3, 'title': 'Deduction', 'img': "", 'children': [], 'onTap': () {}},
    // {
    //   'id': 8,
    //   'title': 'Vehicle Inspection',
    //   'img': "",
    //   'children': [],
    //   'onTap': () {}
    // },
    // {'id': 9, 'title': 'DA Report', 'img': "", 'children': [], 'onTap': () {}},
    // {
    //   'id': 10,
    //   'title': 'ID Management',
    //   'img': "",
    //   'children': [],
    //   'onTap': () {}
    // },
    // {
    //   'id': 11,
    //   'title': 'Adhoc Vehicle',
    //   'img': LocalIcon.adhoc,
    //   'children': [],
    //   'onTap': () => Get.toNamed(AppRoute.adhocVehicleList)
    // },
    // {
    //   'id': 12,
    //   'title': 'Tasks',
    //   'img': LocalIcon.taskIcon,
    //   'children': [],
    //   'onTap': () => Get.toNamed(AppRoute.taskScreen)
    // },
    // {
    //   'id': 7,
    //   'title': 'View Profile',
    //   'img': LocalIcon.viewprofileIcon,
    //   'children': [],
    //   'onTap': () => Get.toNamed(AppRoute.viewProfile)
    // },
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value:
          const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      child: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          return SafeArea(
            child: Container(
              width: context.widthHalf() + 100,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(34)),
                  color: Palette.pureWhite),
              child: SafeArea(
                  child: ListView(
                children: [
                  const HeightFull(multiplier: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () => homeKey.currentState!.closeDrawer(),
                          child: const Icon(Icons.chevron_left,
                              color: Palette.grey, size: 30)),
                      Image.asset(
                        LocalImages.placeHolder,
                        height: 70,
                        width: 70,
                      ),
                      const SizedBox(width: 30)
                    ],
                  ),
                  const HeightHalf(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: TextCustom(
                          "Emp Name: ${auth.user?.employeeName}",
                          fontWeight: FontWeight.bold,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                  const HeightHalf(),
                  Center(
                      child: TextCustom(
                    "Time: $_currentTime",
                    fontWeight: FontWeight.w500,
                    size: 14,
                  )),
                  const HeightHalf(),

                  Center(
                      child: TextCustom(
                    "Date: $_currentDate",
                    fontWeight: FontWeight.w500,
                    size: 14,
                  )),
                  // Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  // InkWell(
                  //     onTap: () => homeKey.currentState!.closeDrawer(),
                  //     child: const Icon(Icons.chevron_left,
                  //         color: Palette.grey, size: 30)),
                  //       // if ((provdAuth.employeeData["attach"] ?? {}).isNotEmpty)
                  //       Container(
                  //         height: 110,
                  //         width: 110,
                  //         clipBehavior: Clip.antiAliasWithSaveLayer,
                  //         decoration: BoxDecoration(
                  //             border:
                  //                 Border.all(color: Palette.secondary, width: 8),
                  //             borderRadius: BorderRadius.circular(12),
                  //             color: Palette.grey),
                  //         child:
                  //             // img.isNotEmpty
                  //             //     ? InkWell(
                  //             //         onTap: () {},
                  //             //         child: ClipRRect(
                  //             //             borderRadius: BorderRadius.circular(12),
                  //             //             child: CachedNetworkImage(imageUrl: img)),
                  //             //       )
                  //             //     :
                  //             Image.asset(LocalImages.placeHolder,
                  //                 fit: BoxFit.cover),
                  //       ),
                  //       const SizedBox(width: 30)
                  //     ]),

                  // const HeightHalf(),
                  // const Center(
                  //   child: TextCustom("", fontWeight: FontWeight.w400, size: 13),
                  // ),
                  const HeightFull(multiplier: 2),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: drawerList.length,
                    itemBuilder: (context, index) {
                      Map data = drawerList[index];
                      return (data['children'] ?? []).isEmpty
                          ? menu1(data, index)
                          : menu2(data, index);
                    },
                  ),
                  const HeightFull(multiplier: 2),
                  ButtonPrimary(
                      label: "Logout",
                      onPressed: () {
                        commonDialog(context, const LogoutDialog());
                      }),
                  const HeightFull()
                ],
              )),
            ),
          );
        },
      ),
    );
  }

  bool isExpand = false;

  Widget menu2(Map data, int index) {
    bool isOpened = selectedIndex == index && isExpand;
    String image = data['img'];
    List list = data['children'] ?? [];
    return InkWell(
      onTap: () {
        isExpand = false;
        if (isOpened) {
          isExpand = false;
        } else {
          isExpand = !isExpand;
        }
        selectedIndex = index;
        setState(() {});
        data['onTap']();
      },
      child: AnimatedContainer(
        curve: Curves.easeOutSine,
        duration: const Duration(milliseconds: 300),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListTile(
              leading: Image.asset(image, height: 20),
              horizontalTitleGap: 0,
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              trailing: !isOpened
                  ? const Icon(Icons.chevron_right)
                  : const Icon(Icons.expand_more),
              title: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: TextCustom(data["title"],
                    fontWeight: FontWeight.w500, size: 14),
              )),
          if (isOpened)
            FadeInDown(
              from: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  list.length,
                  (e) => InkWell(
                      onTap: () {
                        Navigation()
                            .push(context, FadeRoute(page: list[e]['onTap']));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 44, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(list[e]["title"],
                                fontWeight: FontWeight.w500, size: 13),
                          ],
                        ),
                      )),
                ),
              ),
            )
        ]),
      ),
    );
  }

  Widget menu1(Map data, int index) {
    String image = data['img'];
    return ListTile(
        leading: Image.asset(
          image,
          height: 20,
          width: 20,
          color: Palette.primary,
        ),
        horizontalTitleGap: 0,
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.zero,
        title: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: TextCustom(data["title"] ?? '',
              fontWeight: FontWeight.w500, size: 14),
        ),
        onTap: () {
          data['onTap']();
          selectedIndex = index;
          setState(() {});
        });
  }
}
