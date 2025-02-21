// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';

// Future<File?> cropImage(File? file) async {
//   String path = file!.path;
//   var croppedFile = await ImageCropper().cropImage(
//     sourcePath: path,
//     compressFormat: ImageCompressFormat.jpg,
//     compressQuality: 100,
//     uiSettings: [
//       AndroidUiSettings(
//           aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
//           toolbarTitle: '',
//           toolbarColor: Colors.black,
//           hideBottomControls: true,
//           toolbarWidgetColor: Colors.white,
//           initAspectRatio: CropAspectRatioPreset.ratio16x9,
//           lockAspectRatio: true),
//       IOSUiSettings(title: '')
//     ],
//   );
//   if (croppedFile != null) {
//     return File(croppedFile.path);
//   }
//   return null;
// }
