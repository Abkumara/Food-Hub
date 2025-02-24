import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';

class ItemAmount extends StatelessWidget {
  const ItemAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/cart_bill.png',
                        width: 23.0,
                        height: 23.0,
                      ),
                      const SizedBox(width: 8.5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('To Pay ',
                                  style:
                                      size14_M_bold(textColor: Colors.black)),
                              Text('₹81',
                                  style: GoogleFonts.prompt(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Text('Incl. all taxes & charges',
                              style: size10_M_regular(textColor: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Item',
                      style:
                          size12_M_regular(textColor: const Color(0xff646161))),
                  Text('₹45',
                      style: GoogleFonts.prompt(
                          color: const Color(0xff616060),
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery Fee | 1.8kms',
                      style:
                          size12_M_regular(textColor: const Color(0xff646161))),
                  Text('₹20.00',
                      style: GoogleFonts.prompt(
                          color: const Color(0xff616060),
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              // Text('Order above ₹100 to save ₹5',
              //     style: size12_M_regular(textColor: const Color(0xff646161))),
              const SizedBox(height: 10),
              const DottedLine(
                lineThickness: 1,
                dashColor: Color(0xffEAEAEA),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Item Discount',
                      style:
                          size12_M_regular(textColor: const Color(0xff646161))),
                  Text('-₹4',
                      style: GoogleFonts.prompt(
                          color: greenColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 10),
              const DottedLine(
                lineThickness: 1,
                dashColor: Color(0xffEAEAEA),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery Tip',
                      style:
                          size12_M_regular(textColor: const Color(0xff646161))),
                  Text('₹10.00',
                      style: GoogleFonts.prompt(
                          color: const Color(0xff616060),
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Platform fee',
                      style:
                          size12_M_regular(textColor: const Color(0xff646161))),
                  Text('₹5.00',
                      style: GoogleFonts.prompt(
                          color: const Color(0xff616060),
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('GST and Restaurant Charges',
                      style:
                          size12_M_regular(textColor: const Color(0xff646161))),
                  Text('₹5.00',
                      style: GoogleFonts.prompt(
                          color: const Color(0xff616060),
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 9.5),
              const DottedLine(
                lineThickness: 1,
                dashColor: Color(0xffEAEAEA),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('To Pay',
                      style: size12_M_medium(textColor: Colors.black)),
                  Text('₹81',
                      style: GoogleFonts.prompt(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
