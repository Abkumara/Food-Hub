import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';

class OtpBox extends StatelessWidget {
  final Function(String) onOtpSubmit; // Callback for OTP submission

  const OtpBox({super.key, required this.onOtpSubmit});

  @override
  Widget build(BuildContext context) {
    // Calculate the width of each OTP box based on screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double boxWidth =
        (screenWidth - 100) / 6; // Subtracting padding and dividing equally

    return OtpTextField(
      numberOfFields: 6, // Number of OTP fields
      borderColor: colorWhite, // Border color
      cursorColor: colorWhite, // Cursor color
      showFieldAsBox: true, // Display fields as boxes
      fieldWidth: boxWidth,
      fieldHeight: boxWidth,
      borderRadius: BorderRadius.circular(15),
      focusedBorderColor: colorWhite,
      filled: true,
      fillColor: Colors.white24,
      decoration: InputDecoration(
        border: InputBorder.none,
        counterText: '',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: colorWhite, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: colorWhite, width: 2),
        ),
      ),
      textStyle: size16_M_bold(), // Custom text style
      onCodeChanged: (String code) {
        // Handle when the user enters or changes the OTP
        debugPrint('OTP Changed: $code');
      },
      onSubmit: (String otp) {
        // Call the parent widget's function to verify OTP
        onOtpSubmit(otp); // Passing OTP to parent
      },
    );
  }
}
