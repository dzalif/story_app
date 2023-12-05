import 'package:flutter/material.dart';

import '../../style_guide/custom_color.dart';
import '../../style_guide/style_guide_mixin.dart';

class CircularProgressBox extends StatelessWidget with StyleGuideMixin {
  final double width;
  final double height;
  final Color color;

  const CircularProgressBox({
    super.key,
    this.width = 17.0,
    this.height = 17.0,
    this.color = CustomColor.background,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
