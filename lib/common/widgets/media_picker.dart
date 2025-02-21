import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/network_image_cus.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/size_unit.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/theme/theme_guide.dart';
import 'package:auspower_flutter/utilities/extensions/context_extention.dart';

class MediaPicker extends StatelessWidget {
  const MediaPicker(
      {super.key,
      required this.title,
      required this.onPicked,
      this.file,
      this.networkImage = '',
      this.onRemovedNetworkImage,
      this.size,
      this.isVideoOnly = false,
      this.isMultiMedia = false});
  final String title, networkImage;
  final Function(File?) onPicked;
  final VoidCallback? onRemovedNetworkImage;
  final File? file;
  final double? size;
  final bool isMultiMedia, isVideoOnly;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topRight, children: [
      InkWell(
        onTap: pickImage,
        child: Container(
          height: size ?? 250,
          width: size ?? context.widthFull(),
          clipBehavior: Clip.antiAlias,
          decoration: ThemeGuide.cardDecoration(),
          child: file != null
              ? Image.file(file!, fit: BoxFit.cover)
              : networkImage.isNotEmpty
                  ? NetworkImageCustom(logo: networkImage)
                  : imagePicker(),
        ),
      ),
      removeImage(context)
    ]);
  }

  Column imagePicker() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        decoration: BoxDecoration(
            color: Palette.primary.withOpacity(.3), shape: BoxShape.circle),
        child: const Padding(
          padding: EdgeInsets.all(SizeUnit.md),
          child: Icon(Icons.add, color: Palette.primary, size: 32),
        ),
      ),
      const HeightFull(),
      TextCustom(title,
          color: Palette.secondary, size: 16, fontWeight: FontWeight.w400)
    ]);
  }

  Widget removeImage(BuildContext context) {
    if (file == null && networkImage.isEmpty) return const SizedBox();
    return SecondaryIconButton(context,
        onPressed:
            networkImage.isEmpty ? () => onPicked(null) : onRemovedNetworkImage,
        icon: const Icon(Icons.close));
  }

  void pickImage() async {
    File? file = await picker();
    if (file == null) return;
    onPicked(file);
  }

  Future<File?> picker() async {
    return null;
  
    // if (isMultiMedia) return await CustomImagePicker().pickMedia();
    // if (isVideoOnly) return await CustomImagePicker().pickVideo();

    // return await CustomImagePicker().pickImage();
  }
}
