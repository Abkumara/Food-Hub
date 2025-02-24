import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/screens/home/order_detail/widgets/item_amount.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';


class Tab1 extends StatefulWidget {
  const Tab1({super.key});

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 206,
              margin: const EdgeInsets.only(
                  top: 10, left: 20, bottom: 25, right: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  color: const Color(0xFFF2F2F2),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(19),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/icon1.png',
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Idly",
                              style: size14_M_medium(textColor: Colors.black),
                            ),
                          ],
                        ),
                        Text(
                          '(50 Pieces)*1',
                          style: size14_M_medium(
                              textColor: const Color(0xff767676)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/icon1.png',
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Vada",
                              style: size14_M_medium(textColor: Colors.black),
                            ),
                          ],
                        ),
                        Text(
                          '(70 Pieces)*1',
                          style: size14_M_medium(
                              textColor: const Color(0xff767676)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/icon1.png',
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Curd Rice",
                              style: size14_M_medium(textColor: Colors.black),
                            ),
                          ],
                        ),
                        Text(
                          '(5kg)',
                          style: size14_M_medium(
                              textColor: const Color(0xff767676)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/icon1.png',
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Lemon Rice",
                              style: size14_M_medium(textColor: Colors.black),
                            ),
                          ],
                        ),
                        Text(
                          '(3kg)',
                          style: size14_M_regular(
                              textColor: const Color(0xff767676)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 11),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('₹8050',
                            style: GoogleFonts.prompt(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Icon(
                            _isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (_isExpanded) const ItemAmount(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 65),
        child: ElevatedButton(
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const TrackPage(),
            //     ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: greenColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Track Your Order',
            style: size16_M_bold(),
          ),
        ),
      ),
    );
  }
}
