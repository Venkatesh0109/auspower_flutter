import 'package:flutter/material.dart';
import 'package:auspower_flutter/constants/assets/local_images.dart';

class OnBoardingData {
  List<OnBoardingDatum> data = [
    OnBoardingDatum(
        image: LocalImages.plane,
        title: 'Welcome to Auspower',
        desc: 'An Energy Management System helps you monitor and control your energy usage, ensuring you save money and reduce your environmental footprint.',
        color: const Color(0xffBBEBE3),
        animationOffset: const Offset(-1, 1)),
    OnBoardingDatum(
        image: LocalImages.wagon,
        title: 'Real-Time Monitoring',
        desc: 'Monitor your energy usage as it happens and make adjustments to stay within your set limits.',
        color: const Color(0xffFDE689),
        animationOffset: const Offset(1, 0)),
    OnBoardingDatum(
        image: LocalImages.sharing,
        title: 'Alerts and Notification',
        desc: 'Stay informed with customizable alerts for any unusual energy usage, helping you take timely action.',
        color: const Color(0xffF2D3D0),
        animationOffset: const Offset(0, 1)),
  ];
}

class OnBoardingDatum {
  final String image;
  final String title;
  final String desc;
  final Color color;
  final Offset animationOffset;
  OnBoardingDatum({
    required this.image,
    required this.title,
    required this.desc,
    required this.color,
    required this.animationOffset,
  });
}
