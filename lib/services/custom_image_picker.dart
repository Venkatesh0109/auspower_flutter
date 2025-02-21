// import 'dart:io';

// import 'package:image_picker/image_picker.dart';

// class CustomImagePicker {
//   final ImagePicker picker = ImagePicker();
//   Future<File?> pickImage() async {
//     File? result;
//     try {
//       XFile? file = await picker.pickImage(source: ImageSource.gallery);
//       if (file == null) return result;
//       result = File(file.path);
//       return result;
//     } on Exception {
//       return result;
//     }
//   }

//   Future<File?> pickMedia() async {
//     File? result;
//     try {
//       XFile? file = await picker.pickMedia();
//       if (file == null) return result;
//       result = File(file.path);
//       return result;
//     } on Exception {
//       return result;
//     }
//   }

//   Future<File?> pickVideo() async {
//     File? result;
//     try {
//       XFile? file = await picker.pickVideo(source: ImageSource.gallery);
//       if (file == null) return result;
//       result = File(file.path);
//       return result;
//     } on Exception {
//       return result;
//     }
//   }
// }
