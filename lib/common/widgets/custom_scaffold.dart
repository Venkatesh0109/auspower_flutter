import 'package:flutter/material.dart';
import 'package:auspower_flutter/common/widgets/loading_overlay.dart';
import 'package:auspower_flutter/constants/size_unit.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key,
      this.appBar,
      this.body,
      this.bottomBar,
      this.color,
      this.resizeToAvoidBottomInset = true,
      this.isLoading = false,
      this.isStackedAppBar = false});
  final Widget? appBar, body, bottomBar;
  final Color? color;
  final bool isLoading;
  final bool resizeToAvoidBottomInset, isStackedAppBar;
  @override
  Widget build(BuildContext context) {
    double safeAreaPadding = MediaQuery.of(context).viewPadding.top;
    if (safeAreaPadding != 0) safeAreaPadding - SizeUnit.lg;
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: color,
        body: isStackedAppBar
            ? Stack(children: [
                if (body != null) body!,
                if (appBar != null) appBar!,
              ])
            : Column(children: [
                if (appBar != null) appBar!,
                if (body != null) Expanded(child: body!),
              ]),
        bottomNavigationBar:
            bottomBar != null ? bottomBar! : const SizedBox.shrink(),
      ),
    );
  }

  List<Widget> get children => [
        if (appBar != null) appBar!,
        if (body != null) Expanded(child: body!),
      ];
}
