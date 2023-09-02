import 'package:flutter/material.dart';
import '../utils/extensions/context_extension.dart';
import 'custom_color.dart';

mixin StyleGuideMixin {
  ThemeData themeData(BuildContext context) {
    return context.theme;
  }

  TextTheme textTheme(BuildContext context) {
    return context.theme.textTheme;
  }

  TextStyle h1(BuildContext context) {
    return context.textTheme.headlineLarge!.copyWith(
      fontSize: 36,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.35,
      color: Colors.black
    );
  }

  TextStyle h2(BuildContext context) {
    return context.textTheme.headlineMedium!.copyWith(
      fontSize: 28,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.35,
    );
  }

  TextStyle h3(BuildContext context) {
    return context.textTheme.headlineSmall!.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.35,
    );
  }

  TextStyle labelLarge(BuildContext context) {
    return context.textTheme.labelLarge!.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.1
    );
  }

  TextStyle labelMedium(BuildContext context) {
    return context.textTheme.labelMedium!.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.1,
      color: CustomColor.text,
    );
  }

  TextStyle labelSmall(BuildContext context) {
    return context.textTheme.labelSmall!.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.1,
      color: CustomColor.text,
    );
  }
}
