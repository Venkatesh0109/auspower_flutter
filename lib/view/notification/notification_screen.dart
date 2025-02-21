import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/empty.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/providers/sql_db_provider.dart';
import 'package:auspower_flutter/repositories/sql_db_repository.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/theme/theme_guide.dart';
import 'package:auspower_flutter/utilities/message.dart';
import 'package:auspower_flutter/view/homescreen/screen/company_screen.dart';
import 'package:auspower_flutter/view/homescreen/widgets/report_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isSelectAllChecked = false;
  bool isAscentingOrder = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      SqlDbRepository().getNotificationList();
      // getList();
      setState(() {});
    });
    super.initState();
  }

  // List<NotificationModel> data = [];

  // Future<List<NotificationModel>> getList() async {
  //   data = await SqlDbRepository().getNotificationList();
  //   return data;
  // }

  //Row rowOrColumn = const Row();
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Consumer<SqlDbProvider>(
      builder: (context, value1, child) {
        return Scaffold(
          // appBar: AppBar(
          //   title: Text(
          //     "Notification",
          //     style: Theme.of(context)
          //         .textTheme
          //         .titleMedium!
          //         .copyWith(color: Colors.white, fontSize: 20),
          //   ),
          //   iconTheme: const IconThemeData(color: Colors.white),
          //   backgroundColor: Theme.of(context).colorScheme.onPrimary,
          //   actions: [
          // IconButton(
          //   onPressed: () {
          //     showDialog(
          //       context: context,
          //       builder: (context) {
          //         return AlertDialog(
          //           backgroundColor: Colors.white,
          //           elevation: 7,
          //           title: const Text(
          //             "Delete",
          //             style: TextStyle(fontFamily: "Mulish", color: Colors.red),
          //           ),
          //           content: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               const Align(
          //                 alignment: Alignment.centerLeft,
          //                 child: Text("Do you want to delete?"),
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Column(
          //                 children: [
          //                   ElevatedButton(
          //                     onPressed: () {
          //                       setState(() {
          //                         SqlDbRepository().deleteAll();
          //                         Navigator.pop(context);
          //                       });
          //                     },
          //                     child: const Text("All Notification"),
          //                   ),
          //                   const SizedBox(
          //                     height: 10,
          //                   ),
          //                   ElevatedButton(
          //                     onPressed: () {
          //                       setState(() {
          //                         for (final element in listId) {
          //                           SqlDbRepository().deleteItem(element);
          //                         }
          //                         Navigator.pop(context);
          //                       });
          //                     },
          //                     child: const Text(
          //                       "Selected Only Notification",
          //                     ),
          //                   ),
          //                   const SizedBox(
          //                     height: 10,
          //                   ),
          //                   ElevatedButton(
          //                     onPressed: () {
          //                       Navigator.pop(context);
          //                     },
          //                     child: const Text(
          //                       "Cancel",
          //                     ),
          //                   )
          //                 ],
          //               )
          //             ],
          //           ),
          //         );
          //       },
          //     );
          //   },
          //   icon: const Icon(
          //     Icons.delete,
          //     color: Colors.white,
          //   ),
          // ),
          //   ],
          // ),

          appBar: CommonAppBar(
            title: "Notification",
            leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios)),
            action: value1.notificationList.isEmpty
                ? const SizedBox()
                : InkWell(
                    onTap: () {
                      commonDialog(context,
                          NotificationDeleteDialog(listId: value1.listId));
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.delete_outline,
                        color: Palette.pureWhite,
                      ),
                    ),
                  ),
          ),
          backgroundColor: Colors.white,
          body: Consumer<SqlDbProvider>(
            builder: (context, value, child) {
              final List<NotificationListModel> list = [];
              for (final element in value.notificationList) {
                list.add(
                  NotificationListModel(
                    title: element.title.toString(),
                    description: element.description.toString(),
                    dateAndTime: element.dateTime.toString(),
                    id: element.id.toString(),
                  ),
                );
              }

              if (isAscentingOrder == true) {
                list.sort(
                  (a, b) => a.dateAndTime.compareTo(b.dateAndTime),
                );
              }
              if (isAscentingOrder == false) {
                list.sort(
                  (b, a) => a.dateAndTime.compareTo(b.dateAndTime),
                );
              }
              return value.notificationList.isEmpty
                  ? const EmptyScreen(
                      title: "There is currently no notification available.",
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const Spacer(),
                          //     IconButton(
                          //       icon: Icon(isAscentingOrder == false
                          //           ? Icons.arrow_downward
                          //           : Icons.arrow_upward),
                          //       onPressed: () {
                          //         setState(() {
                          //           isAscentingOrder = !isAscentingOrder;
                          //         });
                          //       },
                          //     ),
                          //   ],
                          // ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: false,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (ctx, index) {
                                return SqliteListItem(
                                  list[index].title.toString(),
                                  list[index].description.toString(),
                                  list[index].id.toString(),
                                  list[index].dateAndTime.toString(),
                                  value.checkedBoxId,
                                  index: index,
                                );
                              },
                            ),
                          ),
                          // HeightFull(),
                        ]);
            },
          ),
        );
      },
    );
  }
}

class NotificationListModel {
  const NotificationListModel(
      {required this.title,
      required this.description,
      required this.dateAndTime,
      required this.id});
  final String title;
  final String description;
  final String dateAndTime;
  final String id;
}

class SqliteListItem extends StatelessWidget {
  const SqliteListItem(
      this.title, this.description, this.id, this.dateTime, this.isChecked,
      {super.key, required this.index});

  final String title;
  final String description;
  final String id;
  final int index;
  final String dateTime;
  final Function(String checkedBoxId, bool isChecked) isChecked;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<SqlDbProvider>(context);

    DateTime parsedDateTime = DateFormat("dd-MM-yyyy HH:mm:ss").parse(dateTime);

    // Format the parsed DateTime object into desired format
    String formattedTime =
        DateFormat('hh:mm a').format(parsedDateTime); // 12-hour format
    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDateTime);

    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(12, index == 0 ? 12 : 0, 12, 12),
          decoration: BoxDecoration(
              color: Palette.pureWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Palette.grey),
              boxShadow: ThemeGuide.primaryShadow),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextCustom(
                          title,
                          color: title.contains("Alert: Gateway Not Responding")
                              ? Palette.red
                              : Palette.primary,
                          size: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: Checkbox(
                        checkColor: Colors.white,
                        value: provider.listId.contains(id),
                        onChanged: (value) {
                          if (value != null) {
                            isChecked(id, value);
                          }
                        },
                      ),
                    )
                  ],
                ),
                const HeightHalf(),
                Align(
                    alignment: Alignment.centerLeft,
                    child: TextCustom(
                      description,
                      size: 15,
                    )),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextCustom("Date: $formattedDate"),
                    TextCustom("Time: $formattedTime"),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NotificationDeleteDialog extends StatefulWidget {
  const NotificationDeleteDialog({super.key, required this.listId});
  final List<String> listId;

  @override
  State<NotificationDeleteDialog> createState() =>
      _NotificationDeleteDialogState();
}

class _NotificationDeleteDialogState extends State<NotificationDeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SqlDbProvider>(
      builder: (context, value, child) {
        return Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 24),
              const TextCustom(
                "Delete",
                size: 22,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
              InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.black)),
            ],
          ),
          const HeightFull(),
          const Align(
            alignment: Alignment.center,
            child: TextCustom(
              "Do you want to delete?",
              size: 18,
            ),
          ),
          const HeightFull(),
          Column(
            children: [
              ButtonPrimary(
                  onPressed:
                      // value.notificationList.isEmpty
                      //     ? () {
                      //         Navigator.pop(context);
                      //         return showMessage(
                      //             "There is no notification to delete");
                      //       }
                      //     :
                      () {
                    setState(() {
                      SqlDbRepository().deleteAll();
                      Navigator.pop(context);
                      SqlDbRepository().getNotificationList();
                    });
                  },
                  label: "Delete All"),
              const HeightHalf(),
              ButtonPrimary(
                  onPressed: widget.listId.isEmpty
                      ? () {
                          Navigator.pop(context);

                          return showMessage(
                              "Kindly Select Notification to Delete");
                        }
                      : () {
                          setState(() {
                            for (final element in widget.listId) {
                              SqlDbRepository().deleteItem(element);
                            }
                            Navigator.pop(context);
                            SqlDbRepository().getNotificationList();
                            sqlProvider.clearList();
                          });
                        },
                  label: "Selected Only"),
            ],
          ),
        ]);
      },
    );
  }
}
