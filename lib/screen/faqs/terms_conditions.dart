import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:ksn_mobile_customer/controller/api_controller/terms_condition_controller.dart';
import 'package:ksn_mobile_customer/core/widgets/loading_widgets.dart';
import 'package:ksn_mobile_customer/screens/faqs/widgets/faq_app_bar.dart';
import 'package:ksn_mobile_customer/screens/faqs/widgets/footer_widget.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({Key? key}) : super(key: key);

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
    final termsConditionContorller = Get.put(TermsConditionController());
    return FaqAppBarWidget(
        height: 120,
        title: 'Terms & Conditions',
        body: Obx(() {
          if (termsConditionContorller.isLoading.value) {
            return ShimmerLoadingWidget();
          } else {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Html(
                              data: termsConditionContorller
                                  .faqContent.value.data)),
                      const SizedBox(height: 20),
                      const FooterWidget(),
                    ],
                  ),
                );
              },
            );
          }
        }));
  }
}


//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 10),
//                       Text(
//                         'Welcome to KSN',
//                         style: size12_M_medium(textColor: blackType1),
//                       ),
//                       Text(
//                         '''
// These Terms and Conditions outline the rules and regulations for using KSN. By accessing or using our app, you agree to comply with these terms. If you disagree with any part, please discontinue use immediately.
// ''',
//                         style: size12_M_medium(textColor: blackType1),
//                       ),
//                       Text(
//                         '1. Use of the App',
//                         style: size12_M_medium(textColor: blackType1),
//                       ),
//                       _buildBulletPoint(
//                           'You must be at least 18 years old to use our app or have parental/guardian consent.'),
//                       _buildBulletPoint(
//                           'You agree to provide accurate and complete information during registration and ordering.'),
//                       _buildBulletPoint(
//                           'You are responsible for maintaining the confidentiality of your account credentials.'),
//                       Text(
//                         '2. Orders and Payments',
//                         style: size12_M_medium(textColor: blackType1),
//                       ),
//                       _buildBulletPoint(
//                           'Placing Orders: All orders placed through the app are subject to acceptance and availability.'),
//                       _buildBulletPoint(
//                           'Pricing: Prices for items are displayed in the app and may include applicable taxes and delivery charges. Prices are subject to change without prior notice.'),
//                       _buildBulletPoint(
//                           'Payments: Payments must be made via the methods provided in the app. We use secure payment gateways to protect your information.'),
//                       // Add more sections here...
//                       Text(
//                     '3. Delivery Policy',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   _buildBulletPoint(
//                       'Delivery Times: Estimated delivery times are provided in the app but may vary due to unforeseen circumstances.'),
//                   _buildBulletPoint(
//                       'Customer Responsibility: Ensure someone is available to receive the order at the specified address.'),
//                   _buildBulletPoint(
//                       'Incorrect Addresses: If an order cannot be delivered due to incorrect or incomplete address details, additional charges may apply for re-delivery '),


//                   Text(
//                     '4. Refund and Cancellation Policy',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   const SizedBox(height: 8),
//                   _buildBulletPoint(
//                       'Cancellations: Orders can be canceled before the preparation process begins. Once food preparation has started, cancellations are not allowed.'),
//                   _buildBulletPoint(
//                       'Refunds: Refunds are only provided for orders that are incorrect, damaged, or undelivered due to our error.'),
//                   _buildBulletPoint(
//                       'Claims: Any claims regarding order issues must be reported within [X hours] of delivery with appropriate proof (e.g., photos).'),

//                   Text(
//                     '5. Food Quality and Allergies',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   const SizedBox(height: 8),
//                  _buildBulletPoint(
//                       'We ensure the quality and freshness of all food items. However, we are not liable for adverse reactions caused by food allergies.'),
//                   _buildBulletPoint(
//                       'It is the customer’s responsibility to review item descriptions and ingredient details provided in the app before placing an order.'),

//                   Text(
//                     '6.  Intellectual Property',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   _buildBulletPoint(
//                       'All content in the app, including logos, designs, text, and images, is the intellectual property of [Food App Name] and protected by applicable copyright laws.'),
//                   _buildBulletPoint(
//                       'Unauthorized use, reproduction, or distribution of app content is strictly prohibited.'),

//                   Text(
//                     '7.  Limitation of Liability',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   _buildBulletPoint(
//                       '[Food App Name] is not liable for delays, errors, or losses caused by circumstances beyond our control, such as weather, traffic, or third-party courier issues.'),
//                   _buildBulletPoint(
//                       'Our maximum liability for any claim is limited to the order value.'),
                
//                   Text(
//                     '8. Refund and Cancellation Policy',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   _buildBulletPoint(
//                       'You agree not to misuse the app for fraudulent activities or violate any laws.'),
//                   _buildBulletPoint(
//                       'We reserve the right to suspend or terminate accounts that breach these terms.'),


//                        Text(
//                     '9. Refund and Cancellation Policy',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   _buildBulletPoint(
//                       'Your personal information is handled per our Privacy Policy. By using the app, you consent to our collection and use of data as outlined in the Privacy Policy.'),

//                        Text(
//                     '10. Refund and Cancellation Policy',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   _buildBulletPoint(
//                       'We reserve the right to update or modify these Terms and Conditions at any time. Changes will be effective immediately upon posting in the app. Continued use of the app signifies your acceptance of the revised terms.'),

//                        Text(
//                     '11. Refund and Cancellation Policy',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   _buildBulletPoint(
//                       'These Terms and Conditions are governed by the laws of [Country/Region]. Any disputes will be resolved under the jurisdiction of [applicable courts].'),
                  
//                     ],
//                   ),
               