import 'package:flutter/material.dart';

import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/size_unit.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/providers/auth_provider.dart';
import 'package:auspower_flutter/repositories/auth_repository.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/theme/theme_guide.dart';
import 'package:provider/provider.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bg.withOpacity(.5),
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Container(
              padding: const EdgeInsets.all(SizeUnit.lg),
              margin: const EdgeInsets.all(SizeUnit.lg),
              decoration: ThemeGuide.cardDecoration(),
              child: Column(children: [
                const TextCustom('Log Out',
                    color: Palette.red, fontWeight: FontWeight.w700, size: 18),
                const HeightHalf(),
                const TextCustom('Are you sure want to logout?',
                    align: TextAlign.center,
                    color: Palette.secondary,
                    fontWeight: FontWeight.bold),
                const HeightFull(),
                DoubleButton(
                    primaryLabel: 'Confirm',
                    secondarylabel: 'Not Now',
                    primaryOnTap: () => AuthRepository().logout(context),
                    secondaryOnTap: () => Navigator.pop(context),
                    isLoading: auth.isLoading)
              ]),
            )),
          ],
        ),
      ),
    );
  }
}
