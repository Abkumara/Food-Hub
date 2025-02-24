import 'package:flutter/material.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.textEditingController,
  });
  final String hintText;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill this field';
        }
        return null;
      },
      keyboardType: TextInputType.streetAddress,
      style: size16_M_regular().copyWith(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: size14_M_regular().copyWith(color: hintTextColor),
        errorStyle: size14_M_bold().copyWith(
          color: Colors.red[900],
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 29.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0.2, color: textFieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0.2, color: textFieldBorder),
        ),
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0.2, color: textFieldBorder),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0.2, color: textFieldBorder),
        ),
        filled: true,
        fillColor: colorWhite,
      ),
    );
  }
}
