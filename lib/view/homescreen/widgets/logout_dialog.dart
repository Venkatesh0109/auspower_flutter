import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/services/route/navigation.dart';
import 'package:auspower_flutter/services/storage/storage_constants.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/view/authentication/screens/login_screen.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const TextCustom(
        "Logout",
        color: Palette.dark,
        fontWeight: FontWeight.bold,
        size: 17,
      ),
      const HeightFull(),
      const TextCustom("Are you sure you want to logout?",
          color: Palette.dark, size: 14),
      const HeightFull(),
      Row(
        children: [
          Expanded(
            child: ButtonOutlined(
                onPressed: () {
                  Navigator.pop(context);
                },
                label: "Cancel"),
          ),
          const WidthFull(),
          Expanded(
            child: ButtonPrimary(
                onPressed: () {
                  storage.delete(key: StorageConstants.authCreds);
                  clearProviderData();
                  Navigation().pushRemoveUntil(context, const LoginScreen());
                },
                label: "Logout"),
          ),
        ],
      ),
    ]);
  }

  void clearProviderData() {
    authProvider.clear();
    companyProvider.clear();
    powerProvider.clear();
    tableProvider.clear();
  }
}
