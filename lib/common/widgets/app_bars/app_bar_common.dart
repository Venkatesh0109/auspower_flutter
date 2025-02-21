import 'package:flutter/material.dart';

import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/size_unit.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/theme/palette.dart';

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCommon({
    super.key,
    this.title = '',
    this.subTitle = '',
    this.onRefresh,
    this.safeArea = true,
    this.automaticLeadingImplies = true,
    this.actions = const [],
    this.isStacked = false,
  });

  final String title, subTitle;
  final VoidCallback? onRefresh;
  final bool safeArea;
  final bool automaticLeadingImplies, isStacked;
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(SizeUnit.lg),
        child: Row(
          children: [
            if (automaticLeadingImplies) ...[
              if (isStacked)
                SecondaryIconButton(context,
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios_new))
              else
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios_new)),
              const WidthFull(),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(title,
                      maxLines: 1, size: 18, fontWeight: FontWeight.w800),
                  if (subTitle.isNotEmpty)
                    TextCustom(subTitle,
                        color: Palette.secondary,
                        size: 12,
                        fontWeight: FontWeight.bold),
                ],
              ),
            ),
            ...actions
          ],
        ),
      ),
    );
  }
}
