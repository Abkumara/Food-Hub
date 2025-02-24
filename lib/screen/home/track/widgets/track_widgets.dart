import 'package:flutter/material.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';

class TrackStep extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const TrackStep({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imagePath),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: size16_M_bold(textColor: Colors.black),
            ),
            Text(
              description,
              style: size14_M_medium(textColor: greenColor),
            ),
          ],
        ),
      ],
    );
  }
}

class DottedVerticalDivider extends StatelessWidget {
  const DottedVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        20,
        (_) => Container(
          width: 2,
          height: 6,
          color: primaryOrange,
          margin: const EdgeInsets.symmetric(vertical: 4),
        ),
      ),
    );
  }
}
