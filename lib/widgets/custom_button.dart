import 'package:flutter/material.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.isWhite = true,
      this.opacity = 1,
      this.isTransparent = false});
  final bool isTransparent;
  final double opacity;
  final String text;
  final Function onTap;
  final bool isWhite;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Opacity(
        opacity: opacity,
        child: Container(
          height: 54,
          width: double.infinity,
          decoration: BoxDecoration(
              color: isTransparent
                  ? Colors.white38
                  : isWhite
                      ? colorWhite
                      : primaryOrange,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colorWhite, width: 1)),
          child: Center(
            child: Text(
              text,
              style: size16_M_bold().copyWith(
                  color: isTransparent
                      ? colorWhite
                      : isWhite
                          ? primaryOrange
                          : colorWhite),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonWithOutline extends StatelessWidget {
  const CustomButtonWithOutline({
    super.key,
    required this.text,
    required this.onTap,
    this.isWhite = true,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
    this.height,
    this.textStyle,
  });
  final double? height;
  final String text;
  final Function onTap;
  final bool isWhite;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: height ?? 42,
        width: double.infinity,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: 1)),
        child: Center(
          child: Text(
            text,
            style: textStyle ?? size16_M_bold().copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
