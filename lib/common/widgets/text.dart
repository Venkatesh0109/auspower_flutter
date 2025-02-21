import 'package:flutter/material.dart';
import 'package:auspower_flutter/utilities/extensions/double_extension.dart';
import 'package:readmore/readmore.dart';

class TextCustom extends StatelessWidget {
  final String value;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextAlign? align;
  final TextDecoration? decoration;
  final double? height;
  const TextCustom(
    this.value, {
    super.key,
    this.size,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.align,
    this.decoration,
    this.height,
  });
  @override
  Widget build(BuildContext context) {
    double fontSize = (size ?? 14).getFontSize(context);
    return Text(
      value,
      maxLines: maxLines ?? 10000,
      overflow: TextOverflow.ellipsis,
      textAlign: align,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontFamily: "Poppins",
          fontWeight: fontWeight,
          decoration: decoration,
          height: height),
    );
  }
}

class ReadMoreTextCustom extends StatelessWidget {
  const ReadMoreTextCustom(this.value,
      {super.key,
      this.size,
      this.color,
      this.fontWeight,
      this.maxLines,
      this.align,
      this.height,
      this.moreFontWeight});
  final String value;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight, moreFontWeight;
  final int? maxLines;
  final TextAlign? align;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      value,
      trimExpandedText: ' less',
      trimCollapsedText: 'more',
      trimLines: 2,
      trimMode: TrimMode.Line,
      lessStyle: fontStyle(moreFontWeight: moreFontWeight),
      moreStyle: fontStyle(moreFontWeight: moreFontWeight),
      style: fontStyle(),
    );
  }

  double get fontSize => (size ?? 14);

  TextStyle fontStyle({FontWeight? moreFontWeight}) => TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: moreFontWeight ?? fontWeight,
      height: height);
}
