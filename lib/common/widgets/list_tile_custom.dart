import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:auspower_flutter/theme/palette.dart';

class CustomListTile extends ListTile {
  /// A custom icon's asset path
  final String? icon;

  final Color? color;

  /// The text to display as the title label.
  final String titleText;
  final String subtitleText;

  /// Show the trailing widget (optional). Default value is `true`
  final bool enableTrailing;

  /// A widget to display after the title. It can be hide by [enableTrailing]
  final Widget trailingWidget;

  final EdgeInsets? padding;

  /// Creates a customized [ListTile] wiget
  CustomListTile(
      {super.key,
      this.icon,
      required this.titleText,
      required this.subtitleText,
      super.onTap,
      this.color,
      this.padding,
      this.enableTrailing = true,
      this.trailingWidget = const Icon(Icons.arrow_forward_ios_outlined,
          color: Palette.secondary)})
      : super(
          leading: icon == null
              ? null
              : Image.asset(icon, color: color, height: 24, width: 24),
          title: TextCustom(
            titleText,
            size: 16,
            fontWeight: FontWeight.w700,
          ),
          subtitle: TextCustom(subtitleText, color: Palette.secondary),
          trailing: enableTrailing ? trailingWidget : const SizedBox.shrink(),
          contentPadding: padding ?? EdgeInsets.zero,
        );
}
