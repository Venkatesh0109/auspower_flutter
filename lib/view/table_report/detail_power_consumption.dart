import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'package:url_launcher/url_launcher.dart';

class DetailpowerConnsumptionTable extends StatefulWidget {
  const DetailpowerConnsumptionTable({super.key, required this.reportHead});
  final List<Map<String, dynamic>> reportHead;

  @override
  State<DetailpowerConnsumptionTable> createState() =>
      _DetailpowerConnsumptionTableState();
}

class _DetailpowerConnsumptionTableState
    extends State<DetailpowerConnsumptionTable> {
  late List<Map<String, dynamic>> employees;
  late EmployeeDataSource employeeDataSource;
  List columnDefinitions = [];
  List<dynamic> rowItemsValues = [];

  @override
  void initState() {
    super.initState();
    employees = widget.reportHead;
    rowItemsValues = tableProvider.detailedPowerConsumptionList;
    if (employees.isNotEmpty) {
      columnDefinitions.clear();
      for (var field in employees) {
        // Add key-value pairs as columns in columnDefinitions
        if (field["field_code"] == "from_date") {
          columnDefinitions.add({
            "field_name": field["field_name"].toString(),
            "field_code": "mill_date"
          });
        } else {
          columnDefinitions.add({
            "field_name": field["field_name"].toString(),
            "field_code": field["field_code"].toString()
          });
        }
      }
    }

    employeeDataSource = EmployeeDataSource(
        employeeData: rowItemsValues, columns: columnDefinitions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detailed Power Consumption"),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              final RenderBox renderBox =
                  context.findRenderObject() as RenderBox;
              final offset = renderBox.localToGlobal(Offset.zero);
              final screenWidth = MediaQuery.of(context).size.width;
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  screenWidth - offset.dx - renderBox.size.width,
                  offset.dy - renderBox.size.height,
                  -1,
                  0,
                ),
                items: [
                  const PopupMenuItem<String>(
                    value: 'Download as PDF',
                    child: Row(
                      children: [
                        Icon(Icons.picture_as_pdf, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Download as PDF'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Download as Excel',
                    child: Row(
                      children: [
                        Icon(Icons.table_chart, color: Colors.green),
                        SizedBox(width: 8),
                        Text('Download as Excel'),
                      ],
                    ),
                  ),
                ],
              ).then((value) {
                if (value != null) {
                  if (value == 'Download as PDF') {
                    _downloadPDF();
                  } else if (value == 'Download as Excel') {
                    _downloadExcel();
                  }
                }
              });
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.download,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SfDataGrid(
              allowTriStateSorting: true,
              showSortNumbers: true,
              allowMultiColumnSorting: true,
              source: employeeDataSource,
              isScrollbarAlwaysShown: true,
              allowSorting: false,
              columnWidthMode: ColumnWidthMode.auto,
              horizontalScrollPhysics: const AlwaysScrollableScrollPhysics(),
              verticalScrollPhysics: const AlwaysScrollableScrollPhysics(),
              columns: [
                GridColumn(
                  columnName: "S.No",
                  width: 80, // Fixed width for serial number
                  label: Container(
                    color: Palette.primary,
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      "S.No",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                ...columnDefinitions.map((column) {
                  String head = column["field_name"];
                  return GridColumn(
                    columnName: column["field_name"],
                    width: head.length < 10 ? 160 : double.nan,
                    label: Container(
                      color: Palette.primary,
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: Text(
                        column["field_name"],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _downloadPDF() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text("Generating PDF... Please wait"),
          ],
        ),
      ),
    );

    try {
      if (Platform.isAndroid) {
        PermissionStatus manageStoragePermission =
            await Permission.manageExternalStorage.request();
        if (!manageStoragePermission.isGranted) {
          Navigator.pop(context); // Close the loading dialog
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //       content: Text('Permission to manage external storage denied.')),
          // );
          return;
        }
      }

      final pdf = pw.Document();

      const int rowsPerPage = 30;
      List<List<String>> allRows = rowItemsValues.map((item) {
        return columnDefinitions.map((col) {
          return item[col["field_code"]]?.toString() ?? '';
        }).toList();
      }).toList();

      List<List<List<String>>> chunkedData = [];
      for (int i = 0; i < allRows.length; i += rowsPerPage) {
        chunkedData.add(allRows.sublist(
            i,
            i + rowsPerPage > allRows.length
                ? allRows.length
                : i + rowsPerPage));
      }

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return chunkedData.map((chunk) {
              return pw.Table.fromTextArray(
                headers: columnDefinitions.map((e) => e["field_name"]).toList(),
                data: chunk,
              );
            }).toList();
          },
        ),
      );

      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/');
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        Navigator.pop(context); // Close the loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to get the storage directory.')),
        );
        return;
      }
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

      final file =
          File('${directory.path}/DetailedPowerConsumption_$timestamp.pdf');
      await file.writeAsBytes(await pdf.save());

      Navigator.pop(context); // Close the loading dialog

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PDF downloaded successfully!')),
      );

      await NotificationServiceData().showDownloadNotification(file, true);

      if (Platform.isIOS) {
        await Share.shareXFiles([XFile(file.path)], text: "Download PDF");
      }
    } catch (e) {
      Navigator.pop(context); // Close the loading dialog in case of error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: $e')),
      );
    }
  }

  void _downloadExcel() async {
    if (Platform.isAndroid) {
      PermissionStatus manageStoragePermission =
          await Permission.manageExternalStorage.request();
      if (!manageStoragePermission.isGranted) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //       content: Text('Permission to manage external storage denied.')),
        // );
        return;
      }
    }

    final xls.Workbook workbook = xls.Workbook();
    final xls.Worksheet sheet = workbook.worksheets[0];

    // Add headers
    for (int i = 0; i < columnDefinitions.length; i++) {
      sheet
          .getRangeByIndex(1, i + 1)
          .setText(columnDefinitions[i]["field_name"]);
    }

    // Add data
    for (int i = 0; i < rowItemsValues.length; i++) {
      for (int j = 0; j < columnDefinitions.length; j++) {
        sheet.getRangeByIndex(i + 2, j + 1).setText(
              (rowItemsValues[i][columnDefinitions[j]["field_code"]] ?? "-")
                  .toString(),
            );
      }
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    Directory? directory;
    if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/');
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    }

    if (directory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get the storage directory.')),
      );
      return;
    }

    // Generate unique file name with timestamp
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final file =
        File('${directory.path}/DetailedPowerConsumption_$timestamp.xlsx');

    await file.writeAsBytes(bytes);
    await NotificationServiceData().showDownloadNotification(file, false);


    if (Platform.isIOS) {
      await Share.shareXFiles([XFile(file.path)], text: "Download Excel");
    }

  }
}

class EmployeeDataSource extends DataGridSource {
  final List columns;

  EmployeeDataSource(
      {required List<dynamic> employeeData, required this.columns}) {
    _employeeData = employeeData.asMap().entries.map<DataGridRow>((entry) {
      int index = entry.key + 1; // Generate Serial Number
      var e = entry.value;

      return DataGridRow(
        cells: [
          DataGridCell(
              columnName: "S.No",
              value: index), // Add Serial Number Dynamically
          ...columns
              .where((column) => column["field_code"] != "S.No")
              .map((column) {
            var fieldCode = column["field_code"];
            var value = e[fieldCode] ?? ''; // Fetch actual value from provider
            return DataGridCell(columnName: fieldCode, value: value);
          }),
        ],
      );
    }).toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        var displayValue = e.value.toString();

        if (e.columnName == "mill_date" && e.value != null) {
          try {
            DateTime formattedDate =
                DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(e.value);
            displayValue = DateFormat("dd-MM-yyyy").format(formattedDate);
          } catch (e) {
            displayValue = "Invalid Date";
          }
        }

        if (e.columnName == 'meter_name' ||
            e.columnName == 'plant_name' ||
            e.columnName == 'plant_department_name' && e.value != null) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (e.value.toString().length > (constraints.maxWidth / 8)) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    child: Marquee(
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
                    ),
                  );
                } else {
                  return Text(
                    e.value.toString(),
                    overflow: TextOverflow.ellipsis,
                  );
                }
              },
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(displayValue == "" ? "-" : displayValue),
          );
        }
      }).toList(),
    );
  }
}

class NotificationServiceData {
  Future<void> showDownloadNotification(File file, bool isPdf) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'download_channel',
      'Download Notifications',
      channelDescription: 'Notifications for download success',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Download Complete',
      'Your ${isPdf ? "PDF" : "Excel"} has been downloaded successfully!',
      notificationDetails,
      payload: file.path,
    );
    onNotificationTap(file.path);
  }
}

Future<void> onNotificationTap(String filePath) async {
  if (await canLaunch(filePath)) {
    await launch(filePath);
  } else {
    OpenFile.open(filePath);
  }
}



  // void _downloadExcel() async {
  //   if (Platform.isAndroid) {
  //     PermissionStatus manageStoragePermission =
  //         await Permission.manageExternalStorage.request();
  //     if (!manageStoragePermission.isGranted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //             content: Text('Permission to manage external storage denied.')),
  //       );
  //       return;
  //     }
  //   }

  //   final xls.Workbook workbook = xls.Workbook();
  //   final xls.Worksheet sheet = workbook.worksheets[0];

  //   // Add headers
  //   for (int i = 0; i < columnDefinitions.length; i++) {
  //     sheet
  //         .getRangeByIndex(1, i + 1)
  //         .setText(columnDefinitions[i]["field_name"]);
  //   }

  //   // Add data
  //   for (int i = 0; i < rowItemsValues.length; i++) {
  //     for (int j = 0; j < columnDefinitions.length; j++) {
  //       sheet.getRangeByIndex(i + 2, j + 1).setText(
  //             rowItemsValues[i][columnDefinitions[j]["field_code"]].toString(),
  //           );
  //     }
  //   }

  //   final List<int> bytes = workbook.saveAsStream();
  //   workbook.dispose();

  //   Directory? directory;
  //   if (Platform.isAndroid) {
  //     directory = Directory('/storage/emulated/0/');
  //   } else if (Platform.isIOS) {
  //     directory = await getApplicationDocumentsDirectory();
  //   }

  //   if (directory == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Failed to get the storage directory.')),
  //     );
  //     return;
  //   }

  //   // Generate unique file name with timestamp
  //   String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  //   final file =
  //       File('${directory.path}/DetailedPowerConsumption_$timestamp.xlsx');

  //   await file.writeAsBytes(bytes);

  //   if (Platform.isIOS) {
  //     await Share.shareXFiles([XFile(file.path)], text: "Download Excel");
  //   }

  //   await NotificationServiceData().showDownloadNotification(file);
  // }

  // void _downloadPDF() async {
  //   if (Platform.isAndroid) {
  //     PermissionStatus manageStoragePermission =
  //         await Permission.manageExternalStorage.request();
  //     if (!manageStoragePermission.isGranted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //             content: Text('Permission to manage external storage denied.')),
  //       );
  //       return;
  //     }
  //   }

  //   final pdf = pw.Document();
  //   const int rowsPerPage = 50; // Adjust based on the page size

  //   List<List<Map<String, dynamic>>> paginatedData = [];
  //   for (int i = 0; i < rowItemsValues.length; i += rowsPerPage) {
  //     paginatedData.add(List<Map<String, dynamic>>.from(
  //       rowItemsValues.sublist(
  //         i,
  //         (i + rowsPerPage > rowItemsValues.length)
  //             ? rowItemsValues.length
  //             : i + rowsPerPage,
  //       ),
  //     ));
  //   }
  //   for (var pageData in paginatedData) {
  //     pdf.addPage(
  //       pw.Page(
  //         pageFormat: PdfPageFormat.a4,
  //         build: (pw.Context context) {
  //           return pw.Column(
  //             children: [
  //               pw.Text("Detailed Power Consumption Report",
  //                   style: pw.TextStyle(
  //                       fontSize: 18, fontWeight: pw.FontWeight.bold)),
  //               pw.SizedBox(height: 10),
  //               pw.Table.fromTextArray(
  //                 headers: columnDefinitions
  //                     .where((col) =>
  //                         pageData.isNotEmpty &&
  //                         pageData.first.containsKey(col["field_code"]))
  //                     .map((e) => e["field_name"])
  //                     .toList(),
  //                 data: pageData.map((item) {
  //                   return columnDefinitions
  //                       .where((col) => item.containsKey(col["field_code"]))
  //                       .map(
  //                           (col) => item[col["field_code"]]?.toString() ?? "-")
  //                       .toList();
  //                 }).toList(),
  //               ),
  //             ],
  //           );
  //         },
  //       ),
  //     );
  //   }

  //   Directory? directory;
  //   if (Platform.isAndroid) {
  //     directory = Directory('/storage/emulated/0/');
  //   } else if (Platform.isIOS) {
  //     directory = await getApplicationDocumentsDirectory();
  //   }

  //   if (directory == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Failed to get the storage directory.')),
  //     );
  //     return;
  //   }

  //   // Generate unique file name
  //   String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  //   final file =
  //       File('${directory.path}/DetailedPowerConsumption_$timestamp.pdf');

  //   await file.writeAsBytes(await pdf.save());

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('PDF downloaded at: ${file.path}')),
  //   );

  //   await NotificationServiceData().showDownloadNotification(file);

  //   if (Platform.isIOS) {
  //     await Share.shareXFiles([XFile(file.path)], text: "Download PDF");
  //   }
  // }