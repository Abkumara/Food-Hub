import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';

class CouponCard extends StatelessWidget {
  final String discountType;
  final Color discountBgColor;
  final String? brandImage;
  final String couponCode;
  final String discountText;
  final String description;
  final Color cardBgColor;
  final VoidCallback onApply;

  const CouponCard({
    super.key,
    required this.discountType,
    required this.discountBgColor,
    this.brandImage,
    required this.couponCode,
    required this.discountText,
    required this.description,
    required this.cardBgColor,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 50,
                decoration: BoxDecoration(
                  color: discountBgColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      discountType,
                      style: size16_M_bold(textColor: colorWhite),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (brandImage != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Image.asset(
                              brandImage!,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        Text(
                          couponCode,
                          style: size18_M_bold(textColor: blackType1),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => showCouponAppliedDialog(
                              context, couponCode, discountText),
                          child: Text(
                            "APPLY",
                            style: size16_M_bold(textColor: primaryOrange),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      discountText,
                      style: size16_M_bold(textColor: greenColor),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Dash(
                        length: MediaQuery.of(context).size.width * 0.5,
                        dashLength: 5,
                        dashColor: blackType1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: size12_M_medium(textColor: blackType1),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "+ MORE",
                      style: size12_M_medium(textColor: blackType1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCouponAppliedDialog(
      BuildContext context, String couponCode, String discountText) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (context, animation, secondaryAnimation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            // Apply alternating animation: Left to right, then right to left
            final slideOffset = animation.value < 0.5
                ? Offset(-1 + animation.value * 2, 0) // Left to right
                : Offset(1 - (animation.value - 0.5) * 2, 0); // Right to left

            return SlideTransition(
              position: Tween<Offset>(
                begin: slideOffset,
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "'$couponCode' applied",
                        style: size16_M_bold(textColor: blackType1),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${discountText.replaceAll("Save ", "").replaceAll(" on this order!", "")} savings with this coupon",
                        style: size22_M_bold(textColor: blackType1),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Woohoo! Your coupon successfully applied",
                        style: size14_M_medium(textColor: blackType1),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Done!",
                          style: size16_M_bold(textColor: colorWhite),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      transitionDuration: const Duration(milliseconds: 20),
    );
  }
}
