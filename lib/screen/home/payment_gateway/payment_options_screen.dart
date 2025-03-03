import 'package:flutter/material.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/screen/home/payment_gateway/succsesfull_screen.dart';
import 'package:foods_hub/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentOptionsScreen extends StatefulWidget {
  const PaymentOptionsScreen({super.key});

  @override
  State<PaymentOptionsScreen> createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
  bool isChecked = false;
  String? selectedPaymentMethod;
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
              "Payment Options",
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/payoption.png',
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pay on Delivery (cash/UPI)',
                                  style: size16_M_medium(textColor: blackType1),
                                ),
                                Text(
                                  'Pay cash or ask for QR code',
                                  style: size14_M_regular(
                                      textColor: const Color(0xFF929294)),
                                ),
                              ],
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPaymentMethod = "value";
                                });
                              },
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selectedPaymentMethod == "value"
                                        ? const Color(0xff1CA672)
                                        : Colors.grey,
                                    width: 2,
                                  ),
                                  color: selectedPaymentMethod == "value"
                                      ? const Color(0xff1CA672)
                                      : Colors.transparent,
                                ),
                                child: selectedPaymentMethod == "value"
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 10,
                                      )
                                    : null,
                              ),
                            ),
                          ],
                        ),

                        // Checkbox(
                        //   value: isChecked,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       isChecked = value!;
                        //     });
                        //   },
                        //   shape: const CircleBorder(),
                        //   activeColor: const Color(0xFF1CA672),
                        //   checkColor: colorWhite,
                        //   side: const BorderSide(color: Color(0xFFD8D8D8)),
                        // )
                      ],
                    ),
                  ),
                  if (selectedPaymentMethod == "value") ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: CustomButtonWithOutline(
                          text: 'Pay ₹81',
                          textStyle: GoogleFonts.prompt(
                              color: colorWhite,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SuccessfulScreen(),
                                ));
                          },
                          bgColor: const Color(0xFF1CA672),
                          borderColor: const Color(0xFF1CA672),
                          textColor: colorWhite),
                    ),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
