import 'package:flutter/material.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/screen/tab_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class Tab2 extends StatefulWidget {
  const Tab2({super.key});

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return itemCard();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemRow(String itemName, String itemCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset('assets/icons/icon1.png'),
            const SizedBox(width: 8),
            Text(
              itemName,
              style: size14_M_medium(textColor: Colors.black),
            ),
          ],
        ),
        Text(
          itemCount,
          style: size14_M_medium(textColor: const Color(0xff767676)),
        ),
      ],
    );
  }

  Widget itemCard() {
    return Container(
      width: double.infinity,
      height: 207,
      margin: const EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(
          color: const Color(0xFFF2F2F2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(19),
        child: Column(
          children: [
            itemRow("Idly", '(50 Pieces)*1'),
            const SizedBox(height: 17),
            itemRow("Vada", '(70 Pieces)*1'),
            const SizedBox(height: 17),
            itemRow("Curd Rice", '(5kg)'),
            const SizedBox(height: 17),
            itemRow("Lemon Rice", '(3kg)'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TabScreen(index: 2),
                      ),
                    );
                  },
                  child: Text(
                    '+ Re Order Now',
                    style: size14_M_medium(textColor: greenColor),
                  ),
                ),
                Text('₹7000',
                    style: GoogleFonts.prompt(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
