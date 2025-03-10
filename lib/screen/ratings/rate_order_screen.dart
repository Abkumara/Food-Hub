import 'package:flutter/material.dart';
import 'package:foods_hub/controller/api_controller/review_rating_controller.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/model/review_rate_model.dart';
import 'package:foods_hub/widgets/custom_app_bar_widget.dart';

class RateOrderScreen extends StatefulWidget {
  const RateOrderScreen({super.key, required this.orderId});
  final String orderId;
  @override
  State<RateOrderScreen> createState() => _RateOrderScreenState();
}

class _RateOrderScreenState extends State<RateOrderScreen> {
  int selectedStars = 0;
  bool isDropdownExpanded = false;
  ReviewRatingController reviewRatingController = ReviewRatingController();
  TextEditingController reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: const CustomAppBar(title: 'Rate your Meal'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/meal_rate.png',
              width: 250,
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              'Meal from KSN Madhapur',
              style: size16_M_medium(textColor: blackType1),
            ),
            Text(
              '(Kadhambasadham)',
              style: size16_M_medium(textColor: blackType1),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedStars = index + 1;
                    });
                  },
                  child: Icon(
                    index < selectedStars ? Icons.star : Icons.star_border,
                    size: 40,
                    color: index < selectedStars
                        ? primaryOrange
                        : const Color.fromARGB(113, 44, 44, 44),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                setState(() {
                  isDropdownExpanded = !isDropdownExpanded;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(85, 105, 102, 102), width: 1),
                  borderRadius: BorderRadius.circular(15),
                  color: colorWhite,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add a detailed review',
                          style: size14_M_medium(textColor: blackType1),
                        ),
                        Icon(
                          isDropdownExpanded
                              ? Icons.keyboard_arrow_up_outlined
                              : Icons.keyboard_arrow_down_outlined,
                          color: addressColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    if (isDropdownExpanded)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: reviewController,
                            decoration: InputDecoration(
                              hintText:
                                  'Tell us about the food you ordered here...',
                              hintStyle: size14_M_regular(
                                textColor:
                                    const Color.fromARGB(124, 105, 102, 102),
                              ),
                              border: InputBorder.none,
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final request = OrderReviewRequest(
                      orderId: widget.orderId,
                      rating: selectedStars,
                      review: reviewController.text);
                  reviewRatingController.addReview(request);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryOrange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: size14_M_bold(textColor: colorWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
