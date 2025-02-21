import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  const Responsive({
    super.key,
    required this.mobile,
    this.desktop,
    this.tablet,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Widget tabletWidget = tablet ?? mobile;
      if (constraints.maxWidth >= 1100) {
        return desktop ?? tabletWidget;
      } else if (constraints.maxWidth >= 650) {
        return tabletWidget;
      } else {
        return mobile;
      }
    });
  }
}
