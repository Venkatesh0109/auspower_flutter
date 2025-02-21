import 'package:flutter/material.dart';

import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/common/widgets/text_fields.dart';
import 'package:auspower_flutter/constants/app_strings.dart';
import 'package:auspower_flutter/constants/size_unit.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/providers/auth_provider.dart';
import 'package:auspower_flutter/repositories/auth_repository.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/theme/theme_guide.dart';
import 'package:auspower_flutter/utilities/extensions/form_extension.dart';
import 'package:provider/provider.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});
  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final contPassword = TextEditingController();
  final contMobile = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) => init());
    super.initState();
  }

  void init() {
    setState(() {});
  }

  String? selectedCode = '+91';
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bg.withOpacity(.5),
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) => Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Container(
                padding: const EdgeInsets.all(SizeUnit.lg),
                margin: const EdgeInsets.all(SizeUnit.lg),
                decoration: ThemeGuide.cardDecoration(),
                child: Column(children: [
                  const TextCustom('Continue',
                      color: Palette.primary,
                      fontWeight: FontWeight.w700,
                      maxLines: 1,
                      size: 18),
                  const HeightHalf(),
                  const TextCustom(
                      'Please fill the below details to sign up in to the ${AppStrings.appName}',
                      align: TextAlign.center,
                      color: Palette.secondary,
                      fontWeight: FontWeight.bold),
                  if (contMobile.text.isEmpty) ...[
                    const HeightFull(),
                    MobileTextField(
                      contMobile: contMobile,
                      selectedCode: selectedCode,
                      onChanged: (e) => setState(() => selectedCode = e),
                    ),
                  ],
                  const HeightFull(),
                  TextFormFieldCustom(
                      controller: contPassword,
                      obscured: true,
                      label: 'Password',
                      hint: 'Enter you Password'),
                  const HeightFull(multiplier: 2),
                  DoubleButton(
                      primaryLabel: 'Confirm',
                      secondarylabel: 'Cancel',
                      primaryOnTap: onConfirm,
                      secondaryOnTap: () => Navigator.pop(context),
                      isLoading: auth.isLoading)
                ]),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void onConfirm() {
    if (formKey.hasError) return;
    AuthRepository().register(context, params: "");
  }
}
