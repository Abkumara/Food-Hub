import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:foods_hub/controller/api_controller/shipping_controller.dart';
import 'package:foods_hub/core/widgets/loading_widgets.dart';
import 'package:foods_hub/screen/faqs/widgets/faq_app_bar.dart';
import 'package:get/get.dart';

class ShippingDetailsScreen extends StatelessWidget {
  const ShippingDetailsScreen({Key? key}) : super(key: key);

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
                child: Html(data: shippingContoller.faqContent.value.data));
          }
        }));
  }
}
