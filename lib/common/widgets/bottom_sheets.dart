import 'package:flutter/material.dart';
import 'package:auspower_flutter/constants/size_unit.dart';
import 'package:auspower_flutter/theme/palette.dart';

Future<void> commonBottomSheet(BuildContext context, child) {
  return showModalBottomSheet<void>(
      isScrollControlled: true,
      useRootNavigator: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Palette.bg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(SizeUnit.borderRadius * 2))),
      context: context,
      builder: (BuildContext context) => child);
}
