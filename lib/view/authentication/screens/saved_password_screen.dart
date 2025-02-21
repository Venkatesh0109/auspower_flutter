import 'package:animated_visibility/animated_visibility.dart';
import 'package:flutter/material.dart';

import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/divider.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/app_strings.dart';
import 'package:auspower_flutter/constants/size_unit.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/models/login_creds.dart';
import 'package:auspower_flutter/providers/auth_provider.dart';
import 'package:auspower_flutter/repositories/auth_repository.dart';
import 'package:auspower_flutter/theme/Palette.dart';
import 'package:auspower_flutter/theme/theme_guide.dart';
import 'package:auspower_flutter/utilities/extensions/context_extention.dart';
import 'package:provider/provider.dart';

class SavedPasswordScreen extends StatefulWidget {
  const SavedPasswordScreen({super.key, required this.creds});
  final LoginCreds creds;

  @override
  State<SavedPasswordScreen> createState() => _SavedPasswordScreenState();
}

class _SavedPasswordScreenState extends State<SavedPasswordScreen> {
  bool isVisible = false;

  void intialize() {
    isVisible = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => intialize());
    return SingleChildScrollView(
      padding: const EdgeInsets.all(SizeUnit.lg),
      child: SizedBox(
        width: context.widthFull(),
        child: AnimatedVisibility(
          visible: isVisible,
          enterDuration: const Duration(milliseconds: 450),
          enter: slideInVertically(initialOffsetY: -1) + fadeIn(),
          child: Column(children: [
            const SizedBox(width: 30, child: DividerCustom(thickness: 5)),
            const Icon(
              Icons.key,
              size: 45,
              color: Palette.greenAccent,
            ),
            const HeightHalf(),
            const TextCustom(
              "Use saved password?",
              size: 18,
              fontWeight: FontWeight.w700,
            ),
            const HeightFull(),
            const TextCustom(
              "You'll login in to ${AppStrings.appName}",
              color: Palette.secondary,
              fontWeight: FontWeight.bold,
            ),
            const HeightFull(),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: SizeUnit.xlg, vertical: 10),
              margin: const EdgeInsets.symmetric(vertical: SizeUnit.md),
              decoration: ThemeGuide.cardDecoration(),
              child: Row(
                children: [
                  const Icon(Icons.password, size: 30),
                  const WidthFull(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(
                        widget.creds.email,
                        size: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextCustom(
                        securedPassword,
                        size: 16,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  )
                ],
              ),
            ),
            const HeightFull(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const TextCustom(
                    "Get back to login page",
                  )),
              Consumer<AuthProvider>(
                builder:
                    (BuildContext context, AuthProvider value, Widget? child) {
                  return ButtonPrimary(
                      label: "Continue",
                      onPressed: onContinue,
                      isLoading: value.isLoading);
                },
              ),
            ]),
            const HeightHalf(),
            const Divider(color: Palette.grey),
            const HeightHalf(),
            const TextCustom(
              "You can click continue to log in without having to enter your password or Username because they are stored in a password manager.",
              size: 12,
              color: Palette.grey,
            )
          ]),
        ),
      ),
    );
  }

  void onContinue() {
    Map<String, dynamic> data = {
      "username": widget.creds.email,
      "password": widget.creds.password
    };
    AuthRepository().login(context, data);
  }

  String get securedPassword => "*" * (widget.creds.password?.length ?? 0);
}
