// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/models/auth_user.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/services/route/navigation.dart';
import 'package:auspower_flutter/services/storage/storage_constants.dart';
import 'package:auspower_flutter/view/authentication/screens/login_screen.dart';
import 'package:auspower_flutter/view/homescreen/screen/company_screen.dart';
import 'package:auspower_flutter/view/homescreen/screen/plant_screen.dart';
import 'package:auspower_flutter/view/onboarding/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:auspower_flutter/theme/palette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => Future.delayed(const Duration(seconds: 3)).then((v) {
              initilize();
            }));
    super.initState();
  }

  void initilize() async {
    String authDetails =
        await storage.read(key: StorageConstants.authCreds) ?? '';
    String onboard = await storage.read(key: StorageConstants.onboarding) ?? '';
    if (authDetails.isNotEmpty) {
      AuthUser user = AuthUser.fromJson(jsonDecode(authDetails));
      authProvider.user = user;
      if (authProvider.user?.employeeType == 'Operator' ||
          authProvider.user?.employeeType == 'Plant') {
        Navigation().pushRemoveUntil(
            context,
            PlantScreen(
                campusId: authProvider.user?.campusId.toString() ?? "",
                companyId: authProvider.user?.companyId.toString() ?? "",
                buId: authProvider.user?.buId.toString() ?? ""));
      } else {
        Navigation().pushRemoveUntil(context, const CompanyScreen());
      }
      setState(() {});
    } else if (onboard.isNotEmpty) {
      Navigation().pushRemoveUntil(context, const LoginScreen());
    } else {
      Navigation().pushRemoveUntil(context, const OnBoardingScreen());
    }
  }
  //   void initilize() async {
  //   String authDetails =
  //       await storage.read(key: StorageConstants.authCreds) ?? '';
  //   String onboard = await storage.read(key: StorageConstants.onboarding) ?? '';
  //   if (onboard.isNotEmpty) {
  //     Navigation().pushRemoveUntil(context, const LoginScreen());
  //   } else if (onboard.isEmpty) {
  //     Navigation().pushRemoveUntil(context, const OnBoardingScreen());
  //   } else {
  //     AuthUser user = AuthUser.fromJson(jsonDecode(authDetails));
  //     authProvider.user = user;
  //     Navigation().pushRemoveUntil(context, const CompanyScreen());
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.pureWhite,
      body: Center(
          child: Image.asset("assets/images/auth_images/auspower_icon.png",
              height: 150)),
    );
  }
}
