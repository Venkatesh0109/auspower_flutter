import 'package:flutter/material.dart';

import 'package:auspower_flutter/common/widgets/loading_overlay.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/assets/local_images.dart';
import 'package:auspower_flutter/constants/size_unit.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/providers/auth_provider.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/theme/theme_guide.dart';
import 'package:auspower_flutter/utilities/extensions/context_extention.dart';
import 'package:provider/provider.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.description,
    required this.form,
    this.automaticallyImplyLeading = false,
  });
  final String title, description;
  final bool automaticallyImplyLeading;
  final Widget form;

  @override
  Widget build(BuildContext context) {
    bool isKeyBoardOpened = MediaQuery.of(context).viewInsets.bottom != 0;
    return Consumer<AuthProvider>(
      builder: (context, value, child) => LoadingOverlay(
        isLoading: value.googleLoading,
        child: Scaffold(
          backgroundColor: Palette.pureWhite,
          body: Stack(children: [
            Container(
              color: Palette.primary,
              width: context.widthFull(),
              height: context.heightHalf() + 100,
              child: Image.asset(LocalImages.star, fit: BoxFit.cover),
            ),
            if (automaticallyImplyLeading && !isKeyBoardOpened)
              SafeArea(
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    style: IconButtonTheme.of(context).style?.copyWith(
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.transparent)),
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: Palette.pureWhite,
                    )),
              ),
            SafeArea(
              child: Center(
                child: ListView(shrinkWrap: true, children: [
                  Center(
                      child: Image.asset(
                          "assets/images/auth_images/auspower.png",
                          height: 100)),
                  const HeightFull(),
                  TextCustom(
                    title,
                    color: Palette.pureWhite,
                    size: 22,
                    fontWeight: FontWeight.w900,
                    align: TextAlign.center,
                  ),
                  const HeightFull(),
                  TextCustom(
                    description,
                    color: Palette.pureWhite,
                    fontWeight: FontWeight.bold,
                    align: TextAlign.center,
                  ),
                  const HeightFull(),
                  Container(
                    margin: const EdgeInsets.all(SizeUnit.xlg),
                    padding: const EdgeInsets.all(SizeUnit.xlg),
                    decoration:
                        ThemeGuide.cardDecoration(color: Palette.pureWhite),
                    child: form,
                  )
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
