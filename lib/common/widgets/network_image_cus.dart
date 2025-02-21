import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:auspower_flutter/constants/assets/local_images.dart';
import 'package:auspower_flutter/theme/palette.dart';

class NetworkImageCustom extends StatelessWidget {
  const NetworkImageCustom({
    super.key,
    required this.logo,
    this.placeholderImage,
    this.fit,
    this.width,
    this.height,
    this.color,
  });

  final String logo;
  final Color? color;
  final BoxFit? fit;
  final String? placeholderImage;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    if (logo.isEmpty) return placeholder();
    return SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
          imageUrl: logo,
          fit: fit ?? BoxFit.cover,
          color: color,
          placeholder: (context, url) => placeholder(),
          errorWidget: (context, error, stackTrace) => errorWidget()),
    );
  }

  Widget placeholder() {
    String temp = placeholderImage ?? LocalImages.placeHolder;
    // if (temp.isEmpty) return Icon(Icons.person_2_outlined, color: color);
    return Image.asset(temp, color: color ?? Palette.pureWhite);
  }

  Widget errorWidget() {
    String temp = LocalImages.placeHolder;
    return Image.asset(temp, color: color);
  }
}
