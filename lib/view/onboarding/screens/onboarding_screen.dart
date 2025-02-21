import 'package:flutter/material.dart';
import 'package:auspower_flutter/view/onboarding/widgets/onboarding_bottom_bar.dart';
import 'package:auspower_flutter/view/onboarding/widgets/onboarding_data.dart';
import 'package:auspower_flutter/view/onboarding/widgets/onboarding_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController();
  List data = OnBoardingData().data;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: controller,
          itemCount: data.length,
          onPageChanged: (value) => setState(() => selectedIndex = value),
          itemBuilder: (context, index) => OnBoardingWidget(data: data[index])),
      bottomNavigationBar:
          OnBoardingBottomBar(controller: controller, index: selectedIndex),
    );
  }
}
