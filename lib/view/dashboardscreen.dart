import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/assets/local_images.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/models/currennt_power_machine_data.dart';
import 'package:auspower_flutter/models/plant_list_data.dart';
import 'package:auspower_flutter/providers/auth_provider.dart';
import 'package:auspower_flutter/providers/table_provider.dart';
import 'package:auspower_flutter/repositories/table_repository.dart';
import 'package:auspower_flutter/services/route/navigation.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/utilities/date_format.dart';
import 'package:auspower_flutter/utilities/extensions/context_extention.dart';
import 'package:auspower_flutter/view/energy_analysis/screens/energy_analysis_screen.dart';
import 'package:auspower_flutter/view/homescreen/screen/company_screen.dart';
import 'package:auspower_flutter/view/homescreen/screen/power_consumption.dart';
import 'package:auspower_flutter/view/homescreen/screen/sheetview.dart';
import 'package:auspower_flutter/view/homescreen/screen/top_consumption.dart';
import 'package:auspower_flutter/view/notification/notification_screen.dart';
import 'package:auspower_flutter/view/report/screens/energy_entry.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.companyData});

  final PlantListData? companyData;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      TableRepository().gettableData(context,
          plantId: widget.companyData?.plantId.toString() ?? "");
      TableRepository().getGraphData(context,
          plantId: widget.companyData?.plantId.toString() ?? "");
    });
    super.initState();
  }

  DateTime? lastBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, TableProvider>(
      builder: (context, auth, value, child) {
        return WillPopScope(
          onWillPop: () async {
            final now = DateTime.now();
            bool allowPop = false;
            if (lastBackPressTime == null ||
                now.difference(lastBackPressTime!) >
                    const Duration(seconds: 1)) {
              lastBackPressTime = now;
              Fluttertoast.showToast(
                msg: "Press back again to exit",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
              // LayoutRepository().changeScreen(0, context);
            } else {
              allowPop = true;
            }
            return Future<bool>.value(allowPop);
          }, //
          child: Scaffold(
              backgroundColor: Palette.pureWhite,
              appBar: CommonAppBar(
                title: "DashBoard",
                leading: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios)),
                action: Padding(
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
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(children: [
                  Row(
                    children: [
                      Expanded(
                        child: AnimatedCard(
                          onTap: () {
                            Navigation().push(
                                context,
                                FadeRoute(
                                    page: SheetViewScreen(
                                        companyData: widget.companyData ??
                                            PlantListData())));
                          },
                          color: const Color.fromARGB(255, 254, 214, 186),
                          head: "Meter Matrix",
                          image: LocalImages.sheetView,
                        ),
                      ),
                      const WidthFull(),
                      Expanded(
                        child: AnimatedCard(
                          onTap: () {
                            Navigation().push(context,
                                FadeRoute(page: const MeterDataChart()));
                          },
                          color: const Color(0xffEEDEF6),
                          head: "Top Consumption",
                          image: LocalImages.consumption,
                        ),
                      ),
                    ],
                  ),
                  const HeightFull(),
                  const TextCustom(
                    "Analysis",
                    color: Palette.dark,
                    fontWeight: FontWeight.bold,
                    size: 17,
                  ),
                  const HeightHalf(),
                  AnimatedCard(
                    onTap: () {
                      Navigation().push(context,
                          FadeRoute(page: const EnergyAnalysisScreen()));
                    },
                    color: const Color.fromARGB(255, 186, 236, 254),
                    head: "Energy Analysis",
                    image: LocalImages.energyAnalysis,
                  ),
                  const HeightFull(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextCustom(
                        "Activity",
                        color: Palette.dark,
                        fontWeight: FontWeight.bold,
                        size: 17,
                      ),
                      const HeightHalf(),
                      AnimatedCard(
                        onTap: () {
                          Navigation().push(
                              context,
                              FadeRoute(
                                  page: EnergyEntryScreen(
                                      campusId: widget.companyData?.campusId
                                              .toString() ??
                                          "")));
                        },
                        color: const Color.fromARGB(255, 243, 254, 186),
                        head: "Energy Entry",
                        image: LocalImages.energyEntry,
                      ),
                      const HeightFull(),
                    ],
                  ),
                  const TextCustom(
                    "Report",
                    color: Palette.dark,
                    fontWeight: FontWeight.bold,
                    size: 17,
                  ),
                  const HeightHalf(),
                  AnimatedCard(
                    onTap: () {
                      Navigation().push(
                          context, FadeRoute(page: const PowerConsumption()));
                    },
                    color: const Color.fromARGB(255, 254, 186, 186),
                    head: "Power Consumption",
                    image: LocalImages.powerconsumption,
                  ),
                ]),
              )),
        );
      },
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<CurrentPowerTableData> employeeData}) {
    _employeeData = employeeData.asMap().entries.map<DataGridRow>((entry) {
      int index = entry.key;
      CurrentPowerTableData e = entry.value;

      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'S.no', value: index + 1),
        DataGridCell<Map<String, dynamic>>(
          columnName: 'Status',
          value: {
            'index': index + 1,
            'status': e.nocom,
            "desc": e.meterStatusDescription,
            "date": e.dateTime
          },
        ),
        DataGridCell<String>(
            columnName: 'Date',
            value:
                "${FormatDate.formattedStr(e.dateTime.toString())} & ${FormatDate.time(e.dateTime.toString())}"),
        DataGridCell<String>(
            columnName: 'Meter', value: "${e.meterCode} - ${e.meterName}"),
        DataGridCell<String>(
            columnName: 'Slave Id', value: "${e.slaveId}"),
        DataGridCell<double>(
            columnName: 'C.KWH', value: e.machineKWh),
        DataGridCell<double>(columnName: 'Energy', value: e.kWh),
        DataGridCell<double>(columnName: 'kva', value: e.kva),
        DataGridCell<double>(
            columnName: 'Average Powerfactor', value: e.avgPowerfactor),
        DataGridCell<double>(columnName: 'Power(kw)', value: e.kw),
        DataGridCell<String>(columnName: 'Meter Type', value: e.meterType),
        
        DataGridCell<String>(columnName: 'IP Address', value: e.ipAddress),
      ]);
    }).toList();

    // _employeeData.sort((a, b) {
    //   bool aIsRunning =
    //       a.getCells()[0].value['status'] == 'N'; // Assuming 'N' is not running
    //   bool bIsRunning = b.getCells()[0].value['status'] == 'N';
    //   notifyListeners();

    //   return aIsRunning ? (bIsRunning ? 1 : 0) : -1; // Sort 'running' first
    // });
    // _employeeData.sort((a, b) {
    //   bool aIsRunning = a
    //           .getCells()
    //           .firstWhere((cell) => cell.columnName == 'Status')
    //           .value['status'] ==
    //       'N';

    //   bool bIsRunning = b
    //           .getCells()
    //           .firstWhere((cell) => cell.columnName == 'Status')
    //           .value['status'] ==
    //       'N';

    //   return aIsRunning ? (bIsRunning ? 1 : 0) : -1;
    // });

    // notifyListeners();
  }
  // void sortData(String columnName) {
  //   if (columnName == 'S.no') {
  //     _employeeData.sort((a, b) {
  //       logger.f(a.getCells()[0].value['status'][0]);

  //       bool aIsRunning = a.getCells()[0].value['status'] ==
  //           'N'; // Assuming 'N' is not running
  //       bool bIsRunning = b.getCells()[0].value['status'] == 'N';

  //       return aIsRunning ? (bIsRunning ? 1 : 0) : -1;
  //     });
  //   }
  //   // Add sorting logic for other columns if needed
  //   notifyListeners();
  // }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == 'Status') {
          var index = e.value['index'];
          var status = e.value['status'];
          bool isRunning = (status == 'N');

          return GestureDetector(
            onTapDown: (TapDownDetails details) {
              showMenu(
                context: homeKey.currentContext!,
                position: RelativeRect.fromLTRB(
                  details.globalPosition.dx,
                  details.globalPosition.dy,
                  details.globalPosition.dx + 50,
                  details.globalPosition.dy + 50,
                ),
                items: [
                  PopupMenuItem(
                    height: 20,
                    value: e.value,
                    child: Text(
                        "Date Time: ${FormatDate().getFormatedDateTime(e.value["date"].toString())}"),
                  ),
                  PopupMenuItem(
                    height: 20,
                    value: e.value,
                    child: Text("Desc: ${e.value["desc"]}"),
                  ),
                ],
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MachineStatusItem(
                  width: 26,
                  height: 26,
                  isRunning: isRunning,
                  text: TextCustom(
                    "",
                    size: index.toString().length == 3 ? 8 : 10,
                  ),
                ),
              ],
            ),
          );
        } else if (e.columnName == 'Meter') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (e.value.toString().length > (constraints.maxWidth / 8)) {
                  return Marquee(
                    text: e.value.toString(),
                    style: const TextStyle(fontSize: 16),
                    scrollAxis: Axis.horizontal,
                    blankSpace: 20.0,
                    velocity: 30.0,
                    pauseAfterRound: const Duration(seconds: 1),
                    startPadding: 10.0,
                    accelerationDuration: const Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: const Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  );
                } else {
                  return Text(e.value.toString());
                }
              },
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }
      }).toList(),
    );
  }
}

class MachineStatusItem extends StatefulWidget {
  const MachineStatusItem({
    super.key,
    required this.width,
    required this.height,
    required this.isRunning,
    this.text,
  });

  final double width;
  final double height;
  final bool isRunning;
  final Widget? text;

  @override
  State<MachineStatusItem> createState() => _MachineStatusItemState();
}

class _MachineStatusItemState extends State<MachineStatusItem>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> opacity;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    opacity = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color circleColor = widget.isRunning ? Colors.green : Colors.red;

    return
        // FadeTransition(
        //   opacity: opacity,
        //   child:
        Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor,
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey,
          ),
        ],
      ),
      child: Center(
        child: widget.text,
      ),
    );

    // );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Start from the right
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
}

class AnimatedCard extends StatefulWidget {
  final VoidCallback onTap;
  final String head, image;
  final Color color;

  const AnimatedCard({
    super.key,
    required this.onTap,
    this.color = Colors.transparent,
    required this.head,
    required this.image,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Card(
              elevation: 3,
              shadowColor: Colors.grey.withOpacity(.5),
              color: widget.color,
              child: Container(
                width: context.widthFull(),
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Image.asset(
                      widget.image,
                      height: 70,
                      fit: BoxFit.fill,
                    ),
                    const HeightHalf(),
                    TextCustom(
                      widget.head,
                      fontWeight: FontWeight.w600,
                      size: context.isTablet() ? 14 : 13,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
