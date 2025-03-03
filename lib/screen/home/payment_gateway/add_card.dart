import 'package:flutter/material.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add  New Card",
              style:
                  size16_M_bold(textColor: Colors.black).copyWith(fontSize: 15),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  "1 item Total :",
                  style: size14_M_regular(textColor: Colors.black)
                      .copyWith(fontSize: 15),
                ),
                Text(
                  " ₹81",
                  style: GoogleFonts.prompt(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF0F0F1),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextField(
                width: double.infinity,
                hintText: 'Card Number',
              ),
              const SizedBox(height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextField(
                    width: 200,
                    hintText: 'Valid Through (MM/YY)',
                  ),
                  CustomTextField(
                    width: 104,
                    hintText: 'CVV',
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const CustomTextField(
                width: double.infinity,
                hintText: 'Name on card',
              ),
              const SizedBox(height: 25),
              const CustomTextField(
                width: double.infinity,
                hintText: 'Card Nickname(for easy identification)',
              ),
              const SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border:
                          Border.all(color: const Color(0xFFD8D8D8), width: 1),
                    ),
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                      activeColor: primaryOrange,
                      checkColor: Colors.white,
                      side:
                          const BorderSide(color: Colors.transparent, width: 1),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Secure this card. ",
                          style: size14_M_regular(
                              textColor: const Color(0xFFB0AEAE)),
                        ),
                        TextSpan(
                          text: "Why is it important?",
                          style:
                              size14_M_bold(textColor: const Color(0xFF615F5F)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 45),
              SizedBox(
                width: double.infinity,
                height: 57,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE6E7E8),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                  ),
                  child: Text(
                    "Proceed",
                    style: size14_M_bold(textColor: const Color(0xFF8E9193)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final double width;
  final String hintText;
  const CustomTextField({
    super.key,
    required this.width,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD8D8D8), width: 1),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: size16_M_regular(textColor: const Color(0xFFB0AEAE)),
        ),
        style: size16_M_regular(textColor: Colors.black),
      ),
    );
  }
}
