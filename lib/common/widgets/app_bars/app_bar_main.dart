import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/size_unit.dart';
import 'package:auspower_flutter/constants/space.dart';

class AppBarMain extends StatelessWidget {
  const AppBarMain({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return FadeInRight(
        child: SafeArea(
      child: Container(
        padding: const EdgeInsets.all(SizeUnit.lg),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: TextCustom(title,
                  maxLines: 1, size: 18, fontWeight: FontWeight.w800)),
          const WidthFull(),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications)),
        ]),
      ),
    ));
  }
}
