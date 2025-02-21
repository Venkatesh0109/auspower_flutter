import 'package:animate_do/animate_do.dart';
import 'package:animated_visibility/animated_visibility.dart';
import 'package:flutter/material.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/utilities/extensions/context_extention.dart';
import 'package:auspower_flutter/view/onboarding/widgets/onboarding_clip_path.dart';
import 'package:auspower_flutter/view/onboarding/widgets/onboarding_data.dart';

class OnBoardingWidget extends StatefulWidget {
  const OnBoardingWidget({super.key, required this.data});
  final OnBoardingDatum data;

  @override
  State<OnBoardingWidget> createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState extends State<OnBoardingWidget> {
  bool visible = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      visible = true;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ClipPath(
          clipper: OnBoardingClipPath(),
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: context.widthFull(),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: widget.data.color,
                borderRadius: const BorderRadius.vertical(
                    bottom: Radius.elliptical(180, 60))),
            child: AnimatedVisibility(
                visible: visible,
                enterDuration: const Duration(milliseconds: 500),
                enter: slideIn(initialOffset: widget.data.animationOffset),
                child: FadeInRight(child: Image.asset(widget.data.image))),
          ),
        ),
      ),
      FadeInDown(
        child: Column(
          children: [
            const HeightFull(multiplier: 2),
            TextCustom(
              widget.data.title,
              color: Palette.accent,
              fontWeight: FontWeight.w900,
              size: 20,
            ),
            const HeightFull(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextCustom(
                widget.data.desc,
                color: Palette.secondary,
                align: TextAlign.center,
                size: 16,
              ),
            ),
          ],
        ),
      ),
      const HeightFull(),
    ]);
  }
}
