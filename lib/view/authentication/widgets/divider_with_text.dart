import 'package:flutter/material.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/theme/palette.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Expanded(child: Divider(color: Palette.muted)),
      const WidthFull(),
      TextCustom(
        title,
        fontWeight: FontWeight.w600,
        color: Palette.secondary,
      ),
      const WidthFull(),
      const Expanded(child: Divider(color: Palette.muted))
    ]);
  }
}
