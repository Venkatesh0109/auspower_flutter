import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:auspower_flutter/common/widgets/text_fields.dart';
import 'package:auspower_flutter/constants/assets/local_icons.dart';
import 'package:auspower_flutter/constants/size_unit.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/providers/auth_provider.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:provider/provider.dart';

class AppBarSearch extends StatelessWidget {
  AppBarSearch(
      {super.key,
      required this.onChanged,
      this.searchHint = 'Search categories',
      this.actions = const [],
      this.automaticLeadingImplies = true});
  final TextEditingController contSearch = TextEditingController();
  final Function(String) onChanged;
  final String searchHint;
  final List<Widget> actions;
  final bool automaticLeadingImplies;
  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Consumer<AuthProvider>(
        builder: (context, value, child) {
          return SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(SizeUnit.lg),
                  child: Row(children: [
                    if (automaticLeadingImplies) ...[
                      IconButton(
                          style: IconButtonTheme.of(context).style?.copyWith(
                              backgroundColor:
                                  const WidgetStatePropertyAll(Palette.bg)),
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_back,
                              color: Palette.dark)),
                      const WidthFull()
                    ],
                    Expanded(
                      child: TextFormFieldCustom(
                          controller: contSearch,
                          onChanged: onChanged,
                          prefix: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(LocalIcons.search, height: 18)
                              ]),
                          isOptional: true,
                          hint: searchHint),
                    ),
                    ...actions
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
