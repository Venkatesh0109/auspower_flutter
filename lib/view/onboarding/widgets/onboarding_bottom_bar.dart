import 'package:auspower_flutter/services/route/navigation.dart';
import 'package:auspower_flutter/view/authentication/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/size_unit.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/theme/Palette.dart';
import 'package:auspower_flutter/view/onboarding/widgets/onboarding_data.dart';

class OnBoardingBottomBar extends StatelessWidget {
  const OnBoardingBottomBar(
      {super.key, required this.controller, required this.index});
  final PageController controller;
  final int index;

  bool get isLast => index == OnBoardingData().data.length - 1;

  String get button1 => isLast ? 'Get Started' : 'Next';

  String get button2 => isLast ? '' : 'SKIP';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SizeUnit.lg),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        if (isLast) const HeightFull(),
        ButtonPrimary(onPressed: () => onPressed(context), label: button1),
        HeightFull(multiplier: isLast ? 2 : 1),
        if (!isLast) ...[
          TextButton(
              onPressed: () =>
                  Navigation().pushRemoveUntil(context, const LoginScreen()),
              child: TextCustom(button2, color: Palette.secondary)),
          const HeightFull()
        ]
      ]),
    );
  }

  void onPressed(BuildContext context) {
    if (isLast) return Navigation().pushRemoveUntil(context, const LoginScreen());
    controller.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  // void navigateLogin(BuildContext context) {
  //   isOnBoarded = true;
  //   context.go(Routes.login);
  // }
}
