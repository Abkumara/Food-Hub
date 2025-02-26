import 'package:flutter/material.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/screen/coupon/widgets/coupon_card.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Apply Coupons",
          style: size18_M_bold(textColor: blackType1),
        ),
        backgroundColor: colorWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: blackType1),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Discount Coupons",
              style: size22_M_bold(textColor: blackType1),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: [
                  CouponCard(
                    discountType: "30% OFF",
                    discountBgColor: primaryOrange,
                    brandImage: "assets/images/brand.png",
                    couponCode: "JUMBO",
                    discountText: "Save ₹149 on this order!",
                    description:
                        "Use code JUMBO & get 30% off on orders above ₹400. Maximum discount: ₹150.",
                    cardBgColor: colorWhite,
                    onApply: () {
                      print("JUMBO Applied");
                    },
                  ),
                  CouponCard(
                    discountType: "FLAT OFF",
                    discountBgColor: titleColor,
                    brandImage: null,
                    couponCode: "AXIS200",
                    discountText: "Save ₹825 on this order!",
                    description:
                        "Use code AXIS200 & get ₹200 off on orders above ₹400.",
                    cardBgColor: colorWhite,
                    onApply: () {
                      print("AXIS200 Applied");
                    },
                  ),
                  CouponCard(
                    discountType: "FLAT OFF",
                    discountBgColor: primaryOrange,
                    brandImage: "assets/images/brand.png",
                    couponCode: "RBLCC100",
                    discountText: "Save ₹349 on this order!",
                    description:
                        "Use code RBLCC100 & get ₹100 off on orders above ₹500.",
                    cardBgColor: colorWhite,
                    onApply: () {
                      print("RBLCC100 Applied");
                    },
                  ),
                  CouponCard(
                    discountType: "FLAT OFF",
                    discountBgColor: addressColor,
                    brandImage: null,
                    couponCode: "RBLCC100",
                    discountText: "Save ₹349 on this order!",
                    description:
                        "Use code RBLCC100 & get ₹100 off on orders above ₹500.",
                    cardBgColor: colorWhite,
                    onApply: () {
                      print("RBLCC100 Applied Again");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
