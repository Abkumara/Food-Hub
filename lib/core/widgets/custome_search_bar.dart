import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/core/widgets/outline_border.dart';

class SearchInputField extends StatefulWidget {
  const SearchInputField({
    super.key,
    this.margin,
    this.padding,
    this.labelText,
    this.hintText,
    this.width,
    this.labelStyle,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.suffixOnTap,
    this.borderColor,
    this.onTap,
    this.border,
    this.iconColor,
    this.style,
    required this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.hintStyle,
    this.height,
    this.readOnly = false,
    this.inputFormatters,
    this.fillColor,
    this.textInputAction,
    this.passwordFieldDesignChanged,
    this.textColor,
    this.isPasswordValidate,
    this.contentPadding,
    this.onChanged,
    this.prefixIcon,
    this.prefixWidget,
    this.radius,
  });

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BoxBorder? border;
  final Color? iconColor;
  final Color? borderColor;
  final bool? isPasswordValidate;
  final bool? passwordFieldDesignChanged;
  final Color? textColor;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final String? hintText;
  final double? width;
  final double? height;
  final String? labelText;
  final double? radius;
  final TextStyle? labelStyle;
  final bool obscureText;
  final TextStyle? style;
  final void Function()? suffixOnTap;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final Icon? prefixIcon;
  final Widget? prefixWidget;

  @override
  State<SearchInputField> createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextFormField(
        style: widget.style ?? size14_M_bold(textColor: Colors.black),
        onTap: widget.onTap,
        onFieldSubmitted: widget.onFieldSubmitted,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        obscureText: widget.obscureText,
        validator: widget.validator,
        readOnly: widget.readOnly,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            isDense: true,
            prefixIcon: widget.prefixIcon,
            prefixIconConstraints: const BoxConstraints(
                maxHeight: 44, minHeight: 44, maxWidth: 40, minWidth: 40),
            suffixIconConstraints: const BoxConstraints(
                maxHeight: 44, minHeight: 44, maxWidth: 40, minWidth: 40),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: widget.borderColor ?? Colors.transparent)),
            focusedBorder: kAuthInputBorder(
                color: widget.borderColor ?? Colors.transparent),
            enabledBorder: kAuthInputBorder(
                color: widget.borderColor ?? Colors.transparent),
            // enabledBorder: kAuthInputBorder(radius: widget.radius!,color: Colors.transparent),
            // errorBorder: kAuthInputBorder(color: Colors.transparent),
            // disabledBorder: kAuthInputBorder(color: Colors.transparent),
            // focusedErrorBorder: kAuthInputBorder(color: Colors.transparent),
            fillColor: Colors.white,
            filled: true,
            errorStyle: size12_M_bold(textColor: Colors.black),
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                size16_M_regular(textColor: navTextColor)
                    .copyWith(fontSize: 15),
            contentPadding: widget.contentPadding ??
                const EdgeInsets.only(top: 15, left: 18, right: 18),
            prefix: widget.prefixWidget,
            suffixIcon: widget.suffixIcon),
      ),
    );
  }
}
