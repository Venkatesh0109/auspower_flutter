import 'package:auspower_flutter/constants/space.dart';
import 'package:flutter/material.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:lottie/lottie.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    super.key,
    this.title = "No data available at the moment.",
    this.isHeight = false,
  });
  final String title;
  final bool? isHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 400,
              child: Lottie.asset('assets/images/No Data Animation.json'),
            ),
            // Image.asset(LocalImages.empty),
            const HeightFull(multiplier: 2),
            TextCustom(
              title,
              fontWeight: FontWeight.bold,
              size: 18,
            ),
            // const HeightFull(multiplier: 6),
          ],
        ),
      ),
      ListView(
        shrinkWrap: true,
      ),
    ]);
  }
}
