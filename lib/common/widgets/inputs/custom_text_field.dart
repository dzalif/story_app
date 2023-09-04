import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../style_guide/custom_color.dart';
import '../../style_guide/style_guide_mixin.dart';
import '../../utils/constants/constant_value.dart';

class CustomTextField extends StatelessWidget with StyleGuideMixin {
  final String hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final AutovalidateMode autovalidateMode;
  final FocusNode? focusNode;
  final bool autoFocus;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;
  final String? Function(String?)? onChanged;
  final TextInputType? textInputType;
  final double? borderRadius;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final bool disabled;
  final Widget? icon;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final String? errorText;
  final bool isRequired;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final String? prefixText;

  const CustomTextField({
    Key? key,
    this.labelText,
    this.onTap,
    this.onChanged,
    this.validator,
    this.hintText = "",
    this.focusNode,
    this.autoFocus = false,
    this.maxLines,
    this.maxLength,
    this.readOnly = false,
    this.borderRadius,
    this.textInputType,
    this.onEditingComplete,
    this.controller,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.disabled = false,
    this.icon,
    this.obscureText = false,
    this.textInputAction,
    this.errorText,
    this.isRequired = false,
    this.inputFormatters,
    this.prefixIcon,
    this.prefixText
  }) : super(key: key);

  InputBorder? get _border {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1,
        color: CustomColor.inactive,
      ),
      borderRadius: BorderRadius.circular(
        borderRadius ?? ConstantValue.inputBorderRadius,
      ),
    );
  }

  List<TextInputFormatter>? get customInputFormatters {
    if (textInputType == CustomTextInputType.float) {
      return [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,10}')),
      ];
    }

    if (textInputType == CustomTextInputType.integer) {
      return [
        FilteringTextInputFormatter.digitsOnly,
      ];
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(context),
        TextFormField(
          onTap: onTap,
          autovalidateMode: autovalidateMode,
          onChanged: onChanged,
          readOnly: readOnly,
          autofocus: autoFocus,
          focusNode: focusNode,
          autocorrect: false,
          maxLength: maxLength,
          validator: validator,
          maxLines: obscureText ? 1 : maxLines,
          keyboardType: textInputType,
          controller: controller,
          onEditingComplete: onEditingComplete,
          textInputAction: textInputAction,
          enabled: !disabled,
          obscureText: obscureText,
          inputFormatters: inputFormatters ?? customInputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
            suffixIcon: icon,
            errorStyle: labelMedium(context).copyWith(
              color: CustomColor.error,
            ),
            prefixIcon: prefixIcon,
            hintStyle: labelLarge(context).copyWith(
              color: CustomColor.inputText,
            ),
            fillColor: disabled ? CustomColor.inactive : Colors.white,
            filled: true,
            enabledBorder: _border,
            disabledBorder: _border,
            focusedBorder: _border,
            border: InputBorder.none,
            prefixText: prefixText,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    if (labelText == null) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 4),
          child: Row(
            children: [
              Text(
                labelText!,
                style: labelLarge(context),
              ),
              isRequired
                  ? Container(
                margin: const EdgeInsets.only(left: 2),
                child: Text(
                  "*",
                  style: labelLarge(context).copyWith(
                    color: CustomColor.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
                  : const SizedBox()
            ],
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class CustomTextInputType extends TextInputType {
  const CustomTextInputType.numberWithOptions() : super.numberWithOptions();

  static const TextInputType float = TextInputType.numberWithOptions(
    decimal: true,
  );

  static const TextInputType integer = TextInputType.number;
}
