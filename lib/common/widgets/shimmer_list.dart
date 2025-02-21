import 'package:flutter/material.dart';
import 'package:auspower_flutter/common/widgets/shimmer_custom.dart';
import 'package:auspower_flutter/constants/size_unit.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/theme/theme_guide.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key, this.height});
  final double? height;
  @override
  Widget build(BuildContext context) {
    return ShimmerCustom(
      child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(
              SizeUnit.lg, SizeUnit.lg, SizeUnit.lg, SizeUnit.lg * 6),
          itemBuilder: (_, i) => LayoutBuilder(builder: (context, constraints) {
                return Container(
                    decoration: ThemeGuide.cardDecoration(), height: 100);
              }),
          separatorBuilder: (_, i) => const HeightFull(),
          itemCount: 10),
    );
  }
}
