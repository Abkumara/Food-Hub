import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ksn_mobile_customer/controller/api_controller/faq_controller.dart';
import 'package:ksn_mobile_customer/core/widgets/loading_widgets.dart';
import 'package:ksn_mobile_customer/screens/faqs/widgets/faq_app_bar.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final faqController = Get.put(FaqController());

    return FaqAppBarWidget(
        height: 120,
        title: 'FAQ',
        body: Obx(() {
          if (faqController.isLoading.value) {
            return ShimmerLoadingWidget();
          } else {
            return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: 12,
                ),
                child: Html(
                  data: faqController.faqContent.value.data,
                ));
          }
        })

//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Frequently Asked Questions (FAQs)',
//               style: size12_M_medium(textColor: blackType1),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               '1. How do I place an order?',
//               style: size12_M_medium(textColor: blackType1),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               '''
// To place an order:
// • Download and open the KSN App.
// • Browse the menu, select items, and add them to
//   your cart.
// • Proceed to checkout, enter delivery details, and make
//   the payment.
// ''',
//               style: size12_M_medium(textColor: blackType1),
//               softWrap: true,
//             ),

//             Text(
//               '2. What payment methods do you accept?',
//               style: size12_M_medium(textColor: blackType1),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               '''
// We accept:
// • Credit/Debit cards (Visa, MasterCard, etc.)
// • Digital wallets (e.g., Google Pay, Apple Pay)
// • Cash on delivery (in select locations)
// ''',
//               style: size12_M_medium(textColor: blackType1),
//               softWrap: true,
//             ),

//             Text(
//               '3. Can I cancel my order?',
//               style: size12_M_medium(textColor: blackType1),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               '''
// Yes, orders can be canceled before food preparation begins. Once preparation has started, cancellations are not allowed. Contact us immediately if you need to cancel an order
// ''',
//               style: size12_M_medium(textColor: blackType1),
//               softWrap: true,
//             ),

//             Text(
//               '4. What if my driver is delayed?',
//               style: size12_M_medium(textColor: blackType1),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               '''
// Delivery times may vary due to traffic, weather, or other unforeseen circumstances. You can track your order in the app or contact our support team for updates.
// ''',
//               style: size12_M_medium(textColor: blackType1),
//               softWrap: true,
//             ),

//             Text(
//               '5. What if I receive a wrong or damaged order?',
//               style: size12_M_medium(textColor: blackType1),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               '''
// If you receive an incorrect or damaged order, contact us within [X hours] of delivery with proof (e.g., photos). We will arrange for a replacement or refund.
// ''',
//               style: size12_M_medium(textColor: blackType1),
//               softWrap: true,
//             ),

//             Text(
//               '6. Do you offer refunds?',
//               style: size12_M_medium(textColor: blackType1),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               '''
// Refunds are provided for orders that are incorrect, damaged, or undelivered due to our error. Refund requests must be submitted within [X hours] of delivery.
// ''',
//               style: size12_M_medium(textColor: blackType1),
//               softWrap: true,
//             ),

//             Text(
//               '7. Can I schedule an order for a later time?',
//               style: size12_M_medium(textColor: blackType1),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               '''
// Yes, you can schedule an order for a preferred delivery time during checkout. Scheduled deliveries are subject to availability.
// ''',
//               style: size12_M_medium(textColor: blackType1),
//               softWrap: true,
//             ),

//             Text(
//               '8. Do you accommodate dietary preferences or allergies?',
//               style: size12_M_medium(textColor: blackType1),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               '''
// We include detailed descriptions and ingredients for each item. While we strive to accommodate dietary preferences, it is the customer’s responsibility to review the details before ordering. Contact us for special requests if needed
// ''',
//               style: size12_M_medium(textColor: blackType1),
//               softWrap: true,
//             ),

//             Text(
//               '9. Where do you deliver?',
//               style: size12_M_medium(textColor: blackType1),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               '''
// We currently deliver to [specific cities/regions]. Delivery availability may vary based on your location. Enter your address during checkout to confirm.
// ''',
//               style: size12_M_medium(textColor: blackType1),
//               softWrap: true,
//             ),

//             Text(
//               '10. Do you charge for delivery?',
//               style: size12_M_medium(textColor: blackType1),
//             ),
//             Text(
//               '''
// Delivery charges depend on your location and order total. Free delivery is available for orders above [specific amount] in [specific areas].
// ''',
//               style: size12_M_medium(textColor: blackType1),
//               softWrap: true,
//             ),

//             Text(
//               '11. How do I track my order?',
//               style: size12_M_medium(textColor: blackType1),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               '''
// Once your order is placed, you will receive a tracking link via email or app notifications. Use this link to monitor your order status in real-time.
// ''',
//               style: size12_M_medium(textColor: blackType1),
//               softWrap: true,
//             ),

//             Text(
//               '12. How do I contact customer support?',
//               style: size12_M_medium(textColor: blackType1),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               '''
// For any inquiries or issues, you can reach us via:
// • Email [Your Email]
// • Phone [Your Phone Number]
// • Live Chat (available in the app)
// ''',
//               style: size12_M_medium(textColor: blackType1),
//               softWrap: true,
//             ),

//             const SizedBox(height: 16),
//           ],
//         ),

        //     ),
        );
  }
}
