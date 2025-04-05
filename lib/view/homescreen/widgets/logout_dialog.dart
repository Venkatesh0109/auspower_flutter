import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/providers/auth_provider.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:auspower_flutter/repositories/sql_db_repository.dart';
import 'package:auspower_flutter/services/route/navigation.dart';
import 'package:auspower_flutter/services/storage/storage_constants.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/view/authentication/screens/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
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
                    isLoading: isLoading,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      // String? topic = value.user?.notificationTopic;
                      // if (topic != null && topic.isNotEmpty) {
                      //   await FirebaseMessaging.instance
                      //       .unsubscribeFromTopic(topic);
                      // }
                      await FirebaseMessaging.instance.deleteToken();
                      storage.delete(key: StorageConstants.authCreds);
                      SqlDbRepository().deleteAll();
                      clearProviderData();
                      // clearAppCache();
                      setState(() {
                        isLoading = false;
                      });
                      if (mounted) {
                        Navigation()
                            .pushRemoveUntil(context, const LoginScreen());
                      }
                    },
                    label: "Logout"),
              ),
            ],
          ),
        ]);
      },
    );
  }

  Future<void> clearAppCache() async {
    final cacheDir = await getTemporaryDirectory();
    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  void clearProviderData() {
    authProvider.clear();
    companyProvider.clear();
    powerProvider.clear();
    tableProvider.clear();
    analysisProvider.clear();
  }
}
