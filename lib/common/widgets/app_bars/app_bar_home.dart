import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/size_unit.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/providers/auth_provider.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:provider/provider.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});
  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Consumer<AuthProvider>(
        builder: (context, value, child) {
          String name = value.user?.employeeName ?? '';
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(SizeUnit.lg),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextCustom('Have a nice day!',
                                color: Palette.secondary,
                                size: 16,
                                fontWeight: FontWeight.bold),
                            TextCustom('Welcome $name!',
                                maxLines: 1,
                                size: 18,
                                fontWeight: FontWeight.w800),
                          ]),
                    ),
                    const WidthFull(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications)),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
