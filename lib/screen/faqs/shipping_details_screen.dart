import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:ksn_mobile_customer/controller/api_controller/shipping_controller.dart';
import 'package:ksn_mobile_customer/core/widgets/loading_widgets.dart';
import 'package:ksn_mobile_customer/screens/faqs/widgets/faq_app_bar.dart';

class ShippingDetailsScreen extends StatelessWidget {
  const ShippingDetailsScreen({Key? key}) : super(key: key);

  // Widget _buildBulletPoint(String text, {double indent = 0}) {
  //   return Padding(
  //     padding: EdgeInsets.only(left: indent),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text(
  //           '  • ',
  //           style: TextStyle(fontSize: 14, color: Colors.black),
  //         ),
  //         Expanded(
  //           child: Text(
  //             text,
  //             style: size12_M_medium(textColor: blackType1),
  //             softWrap: true,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final shippingContoller = Get.put(ShippingController());
    return FaqAppBarWidget(
        height: 120,
        title: 'Shipping Details',
        body: Obx(() {
          if (shippingContoller.isLoading.value) {
            return ShimmerLoadingWidget();
          } else {
            return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: 12,
                ),
                child: Html(data: shippingContoller.faqContent.value.data)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Effective Date: [Insert Date]',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   const SizedBox(height: 1),
//                   Text(
//                     '''
// At KSN Caterer, we are committed to delivering fresh and delicious meals promptly. This shipping policy outlines the terms and conditions for food delivery through our app.
// ''',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   Text(
//                     '1. Delivery Locations',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   const SizedBox(height: 8),
//                   _buildBulletPoint(
//                       'We deliver to areas within a [specific radius] km of our kitchen or service location.'),
//                   _buildBulletPoint(
//                       'Delivery availability may vary depending on your location and operational constraints.'),
//                   const SizedBox(height: 12),
//                   Text(
//                     '2. Delivery Timelines',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   const SizedBox(height: 8),
//                   _buildBulletPoint('Standard Delivery:'),
//                   _buildBulletPoint(
//                     'Delivery time: 30-60 minutes from the time the order is confirmed.',
//                     indent: 16,
//                   ),
//                   _buildBulletPoint('Scheduled Delivery:'),
//                   _buildBulletPoint(
//                     'Customers can select a preferred time slot for delivery (e.g., lunch, dinner).',
//                     indent: 16,
//                   ),
//                   Text(
//                     '''
// Note: Delivery times may vary during peak hours, holidays, or unforeseen circumstances like traffic or weather conditions.
// ''',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     '3. Delivery Charges',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   _buildBulletPoint('Orders above ₹500: Free delivery.'),
//                   _buildBulletPoint(
//                       'Orders below ₹500: Delivery charge of ₹30.'),
//                   _buildBulletPoint(
//                       'Express Delivery (Priority Orders): Additional ₹50.'),
//                   const SizedBox(height: 12),
//                   Text(
//                     '4. Order Tracking',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   const SizedBox(height: 8),
//                   _buildBulletPoint(
//                       'After placing your order, you will receive a confirmation notification with an estimated delivery time.'),
//                   _buildBulletPoint(
//                       'You can track your order in real-time via the KSN Caterer App.'),
//                   const SizedBox(height: 12),
//                   Text(
//                     '5. Failed Delivery',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   const SizedBox(height: 8),
//                   _buildBulletPoint(
//                       'Ensure the delivery address and contact details provided are accurate.'),
//                   _buildBulletPoint('If the delivery fails due to:'),
//                   _buildBulletPoint(
//                       'Incorrect address: The order will be canceled, and charges may apply.',
//                       indent: 16),
//                   _buildBulletPoint(
//                       'Recipient unavailability: The delivery partner will wait for a maximum of 10 minutes before moving to the next order.',
//                       indent: 16),
//                   const SizedBox(height: 12),
//                   Text(
//                     '6.   Quality Assurance',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   _buildBulletPoint(
//                       'All meals are freshly prepared and packed in insulated containers to maintain temperature and quality.'),
//                   _buildBulletPoint(
//                       'If you receive an incorrect or damaged order, please report it immediately via the app or contact our support team.'),
//                   const SizedBox(height: 12),
//                   Text(
//                     '7. Refund and Cancellation',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   _buildBulletPoint(
//                       'Orders once placed cannot be canceled after [X minutes] of confirmation.'),
//                   _buildBulletPoint(
//                       'Refunds for canceled or failed orders are processed as per our Refund Policy.'),
//                   const SizedBox(height: 12),
//                   Text(
//                     '8. Customer Support',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   Text(
//                     '''
// For assistance with your order, contact us via:
// ''',
//                     style: size12_M_medium(textColor: blackType1),
//                   ),
//                   _buildBulletPoint('Email: [Insert Email Address]'),
//                   _buildBulletPoint('Phone: [Insert Phone Number]'),
//                   _buildBulletPoint(
//                       'In-App Support: Available 24/7 through the KSN Caterer app.'),
//                 ],
//               ),

                );
          }
        }));
  }
}
