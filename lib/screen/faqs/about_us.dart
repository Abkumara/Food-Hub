import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:ksn_mobile_customer/controller/api_controller/about_us_controller.dart';
import 'package:ksn_mobile_customer/core/widgets/loading_widgets.dart';
import 'package:ksn_mobile_customer/screens/faqs/widgets/faq_app_bar.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  // Widget _buildBulletPoint(String text) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         ' • ',
  //         style: TextStyle(fontSize: 14, color: Colors.black),
  //       ),
  //       Expanded(
  //         child: Text(
  //           text,
  //           style: size12_M_medium(textColor: blackType1),
  //           softWrap: true,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final aboutUsContoller = Get.put(AboutUsController());
    return FaqAppBarWidget(
        height: 120,
        title: 'About Us',
        body: Obx(() {
          if (aboutUsContoller.isLoading.value) {
            return ShimmerLoadingWidget();
          } else {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 200,
                      width: 200,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Html(data: aboutUsContoller.faqContent.value.data),
//                   Text(
//                     'Welcome to KSN Caterers, where wholesome, vegetarian cuisine meets exceptional service.',
//                     style: size12_M_bold(textColor: blackType1),
//                   ),
//                   const SizedBox(height: 15),
//                   Text(
//                     'At KSN Caterers, we take pride in preparing delicious, pure vegetarian meals that cater to your dietary preferences and spiritual beliefs. Specializing in vegetarian dishes without onion and garlic, we ensure that every meal aligns with traditional and cultural values while delivering unmatched flavor and quality.',
//                     style: size12_M_medium(textColor: blackType1),
//                     softWrap: true,
//                   ),
//                   const SizedBox(height: 15),
//                   Text(
//                     'Our Mission',
//                     style: size12_M_bold(textColor: blackType1),
//                   ),
//                   Text(
//                     'To provide freshly prepared, wholesome vegetarian meals that bring people together and create joyful dining experiences.',
//                     style: size12_M_medium(textColor: blackType1),
//                     softWrap: true,
//                   ),
//                   const SizedBox(height: 15),
//                   Text(
//                     'What We offer',
//                     style: size12_M_bold(textColor: blackType1),
//                   ),
//                   const SizedBox(height: 4),
//                   _buildBulletPoint(
//                       'Customized Catering Solutions: Perfect for weddings, corporate events, religious functions, and family gatherings.'),
//                   _buildBulletPoint(
//                       'Onion- and Garlic-Free Meals: Carefully crafted dishes that maintain authenticity and adhere to specific dietary requirements.'),
//                   _buildBulletPoint(
//                       'Daily Food Delivery: Fresh, vegetarian meals delivered straight to your doorstep via our app.'),
//                   _buildBulletPoint(
//                       'Diverse Menu Options: A wide variety of cuisines, from Indian classics to innovative vegetarian recipes.'),
//                   const SizedBox(height: 15),
//                   Text(
//                     'Why Choose KSN Caterers?',
//                     style: size12_M_bold(textColor: blackType1),
//                   ),
//                   const SizedBox(height: 4),
//                   _buildBulletPoint(
//                       'Pure Vegetarian Cuisine: 100% vegetarian meals prepared without onion or garlic.'),
//                   _buildBulletPoint(
//                       'Fresh Ingredients: We use only high-quality, fresh ingredients for every dish.'),
//                   _buildBulletPoint(
//                       'Expert Chefs: Skilled in crafting flavorful vegetarian meals that satisfy all palates.'),
//                   _buildBulletPoint(
//                       'Reliable Service: Timely delivery and exceptional customer service are our top priorities.'),
//                   const SizedBox(height: 15),
//                   Text(
//                     'Join the KSN Family',
//                     style: size12_M_bold(textColor: blackType1),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '''
// Experience the joy of pure vegetarian food with KSN Caterers. Whether it’s a special occasion or a daily meal, we are here to serve you with love and dedication.
// ''',
//                     style: size12_M_medium(textColor: blackType1),
//                     softWrap: true,
//                   ),
//                   Text(
//                     'Contact Us:',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   _buildBulletPoint('Email: [Insert Email Address].'),
//                   _buildBulletPoint('Phone: [Insert Phone Number]'),
//                   _buildBulletPoint(
//                       'Expert Chefs: Skilled in crafting flavorful vegetarian meals that satisfy all palates.'),
//                   _buildBulletPoint(
//                       'App: Download the KSN Caterers App for easy ordering and delivery.'),
//                   const SizedBox(height: 15),
//                   Text(
//                     'At KSN Caterers, we don’t just serve food—we serve purity, tradition, and happiness!',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
                  const SizedBox(height: 4),
                ],
              ),
            );
          }
        }));
  }
}
