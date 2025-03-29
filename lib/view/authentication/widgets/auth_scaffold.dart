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
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class AuthScaffold extends StatefulWidget {
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
  State<AuthScaffold> createState() => _AuthScaffoldState();
}

class _AuthScaffoldState extends State<AuthScaffold> {
  String version = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _getAppVersion();
    });
    super.initState();
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyBoardOpened = MediaQuery.of(context).viewInsets.bottom != 0;
    return Consumer<AuthProvider>(
      builder: (context, value, child) => LoadingOverlay(
        isLoading: value.googleLoading,
        child: Scaffold(
          backgroundColor: Palette.pureWhite,
          body: Stack(
            children: [
              // Background image
              Container(
                color: Palette.primary,
                width: context.widthFull(),
                height: context.heightHalf() + 100,
                child: Image.asset(LocalImages.star, fit: BoxFit.cover),
              ),

              // Back button
              if (widget.automaticallyImplyLeading && !isKeyBoardOpened)
                SafeArea(
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    style: IconButtonTheme.of(context).style?.copyWith(
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                        ),
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: Palette.pureWhite,
                    ),
                  ),
                ),

              // Main content
              SafeArea(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Column(
                          children: [
                            Center(
                              child: Image.asset(
                                "assets/images/auth_images/auspower.png",
                                height: 100,
                              ),
                            ),
                            const HeightFull(),
                            TextCustom(
                              widget.title,
                              color: Palette.pureWhite,
                              size: 22,
                              fontWeight: FontWeight.w900,
                              align: TextAlign.center,
                            ),
                            const HeightFull(),
                            TextCustom(
                              widget.description,
                              color: Palette.pureWhite,
                              fontWeight: FontWeight.bold,
                              align: TextAlign.center,
                            ),
                            const HeightFull(),
                            Container(
                              margin: const EdgeInsets.all(SizeUnit.xlg),
                              padding: const EdgeInsets.all(SizeUnit.xlg),
                              decoration: ThemeGuide.cardDecoration(
                                  color: Palette.pureWhite),
                              child: widget.form,
                            ),
                          ],
                        ),

                        // Powered By and Version at the end of content
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextCustom("Powered By", color: Palette.grey),
                                  WidthHalf(),
                                  Image.asset(
                                    "assets/images/ausweglogo.png",
                                    height: 52,
                                    width: 52,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ],
                              ),
                              Text(
                                "Version: $version",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontFamily: "Mulish",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
