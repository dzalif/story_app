import 'package:flutter/material.dart';

import '../../style_guide/custom_color.dart';
import '../../style_guide/style_guide_mixin.dart';
import '../../utils/constants/constant_value.dart';
import '../progress/circular_progress_box.dart';

class CustomMainButton extends StatelessWidget with StyleGuideMixin {
  final String text;
  final bool isLoading;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final Color? borderColor;
  final double? width;

  const CustomMainButton({
    super.key,
    required this.text,
    this.isLoading = false,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.borderColor,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ConstantValue.buttonBorderRadius,
          ),
        ),
        side: BorderSide(color: borderColor ?? CustomColor.inactive),
        backgroundColor: backgroundColor ?? CustomColor.secondary,
        elevation: 0,
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: onTap,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        layoutBuilder: (newchild, oldchild) => newchild!,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease,
        child: Container(
          key: ValueKey("${key.toString()}-$isLoading"),
          height: height ?? 48,
          alignment: Alignment.center,
          child: _buildButtonContent(context),
        ),
      ),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    return isLoading
        ? const CircularProgressBox()
        : Text(
      text,
      style: labelMedium(context).copyWith(
        color: onTap == null ? Colors.grey : textColor ?? Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
