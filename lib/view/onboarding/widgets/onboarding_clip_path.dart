import 'package:flutter/material.dart';

class OnBoardingClipPath extends CustomClipper<Path> {
  OnBoardingClipPath();
  int differnce = 80;
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - differnce);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - differnce,
    );
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
