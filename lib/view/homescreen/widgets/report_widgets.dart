import 'dart:ui';
import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/constants/size_unit.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/utilities/extensions/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class ContainerListDialog extends StatelessWidget {
  const ContainerListDialog({
    super.key,
    required this.data,
    required this.hint,
    required this.fun,
    required this.key1,
  });

  final List<Map<String, dynamic>> data;
  final String hint, key1;
  final VoidCallback fun;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        width: context.widthFull(),
        decoration: BoxDecoration(
          color: Palette.pureWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(.3)),
        ),
        child: data.isEmpty
            ? TextCustom(
                hint,
                size: 13,
                color: Palette.dark.withOpacity(.6),
              )
            : Wrap(
                spacing: 6.0,
                runSpacing: 1.0,
                children: data
                    .map(
                      (item) => Chip(
                        label: TextCustom(
                          item[key1] ?? '',
                          size: 12.5,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.lightBlue.shade200,
                        deleteIcon: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                        onDeleted: () {
                          data.remove(item); // Remove item
                          fun(); // Call the function to refresh the UI
                        },
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}

extension ListExtensions on List {
  String extractString(String key) {
    try {
      String value = '';
      for (var e in this) {
        value += '${e[key]}${e == last ? '' : ', '}';
      }
      return value;
    } on Exception {
      return '';
    }
  }
}

class MultiselectDialogList extends StatefulWidget {
  const MultiselectDialogList({
    super.key,
    required this.courses,
    required this.dropdownKey,
    required this.hint,
    required this.onSelected,
    required this.head,
    required this.selectedList,
    this.isSelect = false,
  });

  final courses, selectedList;
  final String dropdownKey;
  final Function(Object) onSelected;
  final String hint;
  final String head;
  final bool? isSelect;

  @override
  State<MultiselectDialogList> createState() => _MultiselectDialogListState();
}

class _MultiselectDialogListState extends State<MultiselectDialogList> {
  List course = [];
  List<Map<String, dynamic>> selectedItems = [];
  bool selectAll = false;
  TextEditingController coursecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    course = List.from(widget.courses);

    // Ensure selectedItems contains only matching fields
    selectedItems = widget.selectedList
        .where((field) => course.any(
            (item) => item[widget.dropdownKey] == field[widget.dropdownKey]))
        .toList();

    selectAll = selectedItems.length == course.length;
  }

  void _filterCourses(Object? query) {
    // Accepts Object?
    String text = query?.toString() ?? ""; // Convert to String safely
    setState(() {
      if (text.isEmpty) {
        course = List.from(widget.courses);
      } else {
        course = widget.courses
            .where((element) => element[widget.dropdownKey]
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextCustom(widget.head, size: 16),
          ],
        ),
        widget.isSelect == true
            ? Row(
                children: [
                  Checkbox(
                    activeColor: Palette.primary,
                    value: selectAll,
                    onChanged: (bool? value) {
                      setState(() {
                        selectAll = value ?? false;
                        if (selectAll) {
                          selectedItems = List.from(course);
                        } else {
                          selectedItems.clear();
                        }
                      });
                    },
                  ),
                  const TextCustom("Select All", size: 14),
                ],
              )
            : const SizedBox.shrink(),
        TextFieldDropdownSearch(
          controller: coursecontroller,
          hint: widget.hint,
          onChanged: (value) => _filterCourses(value),
          isCrtColor: true,
        ),
        const HeightFull(),
        SizedBox(
          height: context.heightQuarter(),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: course.length,
            itemBuilder: (context, index) {
              final item = course[index];
              final isSelected = selectedItems.contains(item);

              return InkWell(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedItems.remove(item);
                    } else {
                      selectedItems.add(item);
                    }
                    selectAll = selectedItems.length == course.length;
                  });
                },
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: Palette.primary,
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value ?? false) {
                            selectedItems.add(item);
                          } else {
                            selectedItems.remove(item);
                          }
                          selectAll = selectedItems.length == course.length;
                        });
                      },
                    ),
                    TextCustom("${item[widget.dropdownKey]}", size: 14),
                  ],
                ),
              );
            },
          ),
        ),
        DoubleButton(
          primaryLabel: "Confirm",
          secondarylabel: "Cancel",
          primaryOnTap: () {
            widget.onSelected(selectedItems);
            Navigator.pop(context);
          },
          secondaryOnTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

commonDialog(BuildContext context, Widget child) {
  return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var size = MediaQuery.of(context).size;
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Scaffold(
              backgroundColor: Palette.dark.withOpacity(.5),
              body: SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Palette.pureWhite,
                            borderRadius: BorderRadius.circular(12)),
                        width: size.width - 24,
                        child: Padding(
                            padding: const EdgeInsets.all(16), child: child)),
                  ],
                ),
              )),
        );
      });
}

class DropdownDialogList extends StatefulWidget {
  const DropdownDialogList(
      {super.key,
      required this.courses,
      required this.dropdownKey,
       this.dropdownKey1,
      required this.hint,
      required this.onSelected,
      required this.head,
      this.isSearch = false});
  final List courses;
  final String dropdownKey;
  final String? dropdownKey1;
  final Function(Object?) onSelected;
  final String hint;
  final String head;
  final bool? isSearch;

  @override
  State<DropdownDialogList> createState() => _DropdownDialogListState();
}

class _DropdownDialogListState extends State<DropdownDialogList> {
  List course = [];
  @override
  void initState() {
    course = widget.courses;
    // logger.w(course);
    super.initState();
  }

  TextEditingController coursecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 24),
            TextCustom(widget.head, size: 16),
            InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close))
          ],
        ),
        const HeightFull(),
        widget.isSearch == true
            ? const SizedBox.shrink()
            : Column(
                children: [
                  TextFieldDropdownSearch(
                    controller: coursecontroller,
                    hint: widget.hint,
                    onChanged: (p0) {
                      if (coursecontroller.text.isEmpty) {
                        course = widget.courses;
                        setState(() {});
                      } else {
                        course = course
                            .where((element) => element[widget.dropdownKey]
                                .toString()
                                .toLowerCase()
                                .contains(coursecontroller.text.toLowerCase()))
                            .toList();
                        setState(() {});
                      }
                    },
                    isCrtColor: false,
                  ),
                ],
              ),
        const HeightFull(),
        SizedBox(
          height: context.heightQuarter(),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            shrinkWrap: true,
            itemCount: course.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                // widget.contCourses.text = course[index]["name"];
                widget.onSelected(course[index]);
                Navigator.pop(context);
                setState(() {});
              },
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(widget.dropdownKey1==""? "${course[index][widget.dropdownKey]}":"${course[index][widget.dropdownKey1]} - ${course[index][widget.dropdownKey]}",
                        fontWeight: FontWeight.w400, size: 14),
                    dividerCommonNew(),
                    const SizedBox(height: 4)
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}

Divider dividerCommonNew() {
  return const Divider(color: Palette.grey, thickness: 1);
}

class ContainerListDialogManualData extends StatelessWidget {
  const ContainerListDialogManualData({
    super.key,
    this.data,
    required this.hint,
    required this.fun,
    this.colors,
    this.key1 ,
    required this.keys,
  });

  final Map? data;
  final String hint, keys;
  final VoidCallback fun;
  final Color? colors;
  final String? key1;

  @override
  Widget build(BuildContext context) {
    logger.f(data?[key1]);
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        height: 52,
        width: context.widthFull(),
        decoration: BoxDecoration(
            color: colors,
            borderRadius: BorderRadius.circular(SizeUnit.borderRadius),
            border: Border.all(color: Colors.grey.withOpacity(.3))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              data?[keys] == null || data?[keys] == ""
                  ? TextCustom(
                      hint,
                      size: 12,
                      color: Palette.dark.withOpacity(.6),
                    )
                  : Expanded(
                      child: TextCustom(data?[key1] == null||data?[key1] == ""?"${data?[keys]}": "${data?[key1]} - ${data?[keys]}",
                          maxLines: 1, fontWeight: FontWeight.w400, size: 14)),
            ]),
      ),
    );
  }
}

class TextFieldDropdownSearch extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hint;
  final bool obscured, isReadOnly;
  final Function(Object?)? onChanged;
  final TextInputType? textInputType;
  final TextCapitalization? capitalization;
  final int? length;
  final bool isCrtColor;
  const TextFieldDropdownSearch({
    super.key,
    required this.controller,
    this.hint,
    this.obscured = false,
    this.textInputType,
    this.capitalization,
    this.isReadOnly = false,
    this.length,
    this.focusNode,
    this.onChanged,
    required this.isCrtColor,
  });

  @override
  State<TextFieldDropdownSearch> createState() =>
      _TextFieldDropdownSearchState();
}

class _TextFieldDropdownSearchState extends State<TextFieldDropdownSearch> {
  bool hasError = false;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hasError ? 50 + 22 : 50,
      decoration: const BoxDecoration(color: Palette.pureWhite),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        autofocus: false,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        maxLength: widget.length,
        readOnly: widget.isReadOnly,
        textCapitalization: widget.capitalization ?? TextCapitalization.none,
        keyboardType: widget.textInputType ?? TextInputType.text,
        obscureText: widget.obscured ? !isVisible : false,
        cursorColor: Palette.primary,
        validator: (value) {
          if (value == null || value.isEmpty) {
            setState(() {
              hasError = true;
            });
            return 'This field is required';
          }
          setState(() {
            hasError = false;
          });
          return null;
        },
        style: const TextStyle(),
        decoration: InputDecoration(
            fillColor: Palette.pureWhite,
            suffixIcon: widget.obscured
                ? InkWell(
                    onTap: () => setState(() => isVisible = !isVisible),
                    child: !isVisible
                        ? const Icon(Icons.visibility_off,
                            color: Color(0xffd2d2d2))
                        : const Icon(Icons.visibility,
                            color: Color(0xffd2d2d2)))
                : null,
            filled: false,
            counterText: "",
            hintText: widget.hint,
            errorStyle: const TextStyle(fontSize: 13),
            contentPadding: const EdgeInsets.only(left: 16, top: 16),
            hintStyle:
                TextStyle(fontSize: 13, color: Palette.grey.withOpacity(.8)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: widget.isCrtColor
                        ? widget.controller.text.length <= 9
                            ? Colors.red
                            : Colors.green
                        : Palette.primary)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.withOpacity(.3))),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Palette.primary)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.withOpacity(.3)))),
      ),
    );
  }
}

Future<void> pickDate(
    BuildContext context, Function(String?) onDatePicked) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  String formattedDate =
      DateFormat('dd-MM-yyyy').format(pickedDate!); // Format the date
  onDatePicked(formattedDate); // Pass the formatted date back
}

Future<void> pickMonthYear(
    BuildContext context, ValueChanged<String?> onDatePicked) async {
  final DateTime now = DateTime.now();
  final DateTime? picked = await showMonthYearPicker(
    context: context,
    initialDate: now,
    firstDate: DateTime(now.year - 10, 1), // Allow 10 years back
    lastDate: DateTime(now.year + 10, 12), // Allow 10 years forward
  );

  if (picked != null) {
    final formattedDate = DateFormat("MM-yyyy").format(picked); // Format to MM-yyyy
    onDatePicked(formattedDate);
  }
}
