import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/screen/home/payment_gateway/add_card.dart';
import 'package:foods_hub/screen/home/payment_gateway/payment_options_screen.dart';
import 'package:foods_hub/screen/home/payment_gateway/succsesfull_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentGateWay extends StatefulWidget {
  const PaymentGateWay({super.key});

  @override
  State<PaymentGateWay> createState() => _PaymentGateWayState();
}

class _PaymentGateWayState extends State<PaymentGateWay> {
  String? selectedPaymentMethod;
  bool isButtonPressed = false;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 2),
            _buildHeaderInfo(),
            const SizedBox(height: 20),
            _buildUPIInfo(),
            const SizedBox(height: 10),
            _buildPaymentOptions(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Credit & Debit Cards",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height:
                        (isButtonPressed && selectedPaymentMethod == "value")
                            ? 243
                            : (isButtonPressed ? 146 : 63),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isButtonPressed) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/icons/visa.png',
                                        width: 24, height: 24),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Axis Bank Card | ....9898",
                                          style: size16_M_medium(
                                              textColor: Colors.black),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Additional ",
                                              style: size16_M_regular(
                                                textColor:
                                                    const Color(0xff4D8D75),
                                              ),
                                            ),
                                            Text(
                                              "₹7 ",
                                              style: GoogleFonts.prompt(
                                                  color:
                                                      const Color(0xff4D8D75),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "Cashback",
                                              style: size16_M_regular(
                                                textColor:
                                                    const Color(0xff4D8D75),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
                            if (selectedPaymentMethod == "value") ...[
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const SuccessfulScreen(),
                                              ));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff1CA672),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Text(
                                          'Pay ₹81',
                                          style: GoogleFonts.prompt(
                                              color: colorWhite,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 9),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Text(
                                      'CVV is not needed for MATERCARD cards saved as per RBI guidelines',
                                      style: size12_M_regular(
                                          textColor: const Color(0xff929294)),
                                    ),
                                  )
                                ],
                              ),
                            ],
                            const SizedBox(height: 10),
                            const DottedLine(
                              dashColor: Color(0xffE7E7E7),
                            ),
                            const SizedBox(height: 20),
                          ],
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AddCardPage()),
                              );
                              setState(() {
                                isButtonPressed = !isButtonPressed;
                              });
                            },
                            child: Row(
                              children: [
                                Image.asset('assets/icons/add_new.png'),
                                const SizedBox(width: 10),
                                const Text(
                                  'Add New Card',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "More Payment Options",
                    style: size14_M_bold(textColor: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentOptionsScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 84,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Image.asset('assets/icons/money.png'),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pay on Delivery',
                                  style: size16_M_bold(textColor: Colors.black),
                                ),
                                Text(
                                  'Pay in cash or pay online',
                                  style: size14_M_regular(
                                          textColor: const Color(0xff929294))
                                      .copyWith(fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Container(
      height: 85,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: colorWhite,
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 5,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 33, top: 18, bottom: 18, right: 20),
        child: Row(
          children: [
            Image.asset(
              'assets/icons/payment_page.png',
              width: 15.0,
              height: 49.0,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "KSN Madhapur ",
                        style: size12_M_bold(textColor: Colors.black)
                            .copyWith(fontSize: 13),
                      ),
                      TextSpan(
                        text: "| Delivery in: 15-20 mins",
                        style: size12_M_medium(textColor: Colors.black)
                            .copyWith(fontSize: 13),
                      ),
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Home ",
                        style: size12_M_bold(textColor: Colors.black)
                            .copyWith(fontSize: 13),
                      ),
                      TextSpan(
                        text: "| Nandhini Enclave, Road no 4, Ma..",
                        style: size12_M_medium(textColor: Colors.black)
                            .copyWith(fontSize: 13),
                      ),
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUPIInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Image.asset('assets/images/upi_logo.png'),
          const SizedBox(width: 10),
          Text(
            'Pay by any UPI App',
            style: size14_M_bold(textColor: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            _buildPaymentRow(
              label: 'GPay',
              iconPath: 'assets/icons/g_pay.png',
              value: 'gpay',
            ),
            const DottedLine(
              dashColor: Color(0xffE7E7E7),
            ),
            _buildPaymentRow(
              label: 'PhonePe UPI',
              iconPath: 'assets/icons/phone_pe_upi.png',
              value: 'phonepe',
            ),
            const DottedLine(
              dashColor: Color(0xffE7E7E7),
            ),
            _buildPaymentRow(
              label: 'Paytm UPI',
              iconPath: 'assets/icons/paytm_upi.png',
              value: 'paytm',
            ),
            const DottedLine(
              dashColor: Color(0xffE7E7E7),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Image.asset('assets/icons/add_new.png'),
                  const SizedBox(width: 10),
                  Text('Add New UPI ID',
                      style: size16_M_bold(textColor: Colors.black)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentRow({
    required String label,
    required String iconPath,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(iconPath, width: 24, height: 24),
                  const SizedBox(width: 10),
                  Text(label, style: size16_M_bold(textColor: Colors.black)),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPaymentMethod = value;
                  });
                },
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selectedPaymentMethod == value
                          ? const Color(0xff1CA672)
                          : Colors.grey,
                      width: 2,
                    ),
                    color: selectedPaymentMethod == value
                        ? const Color(0xff1CA672)
                        : Colors.transparent,
                  ),
                  child: selectedPaymentMethod == value
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
          if (selectedPaymentMethod == value)
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 30),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SuccessfulScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1CA672),
                    foregroundColor: colorWhite,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Pay via $label'),
                ),
              ),
            )
        ],
      ),
    );
  }
}
