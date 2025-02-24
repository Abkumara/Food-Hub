import 'package:flutter/material.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({
    super.key,
    required this.image,
    required this.itemName,
  });

  final String image;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 104,
          height: 104,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.error)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          itemName,
          textAlign: TextAlign.center,
          style: size14_M_medium(textColor: blackType1),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }
}
