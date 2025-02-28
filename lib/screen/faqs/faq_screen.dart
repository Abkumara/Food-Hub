import 'package:flutter/material.dart';
import 'package:foods_hub/controller/api_controller/faq_controller.dart';
import 'package:foods_hub/core/widgets/loading_widgets.dart';
import 'package:foods_hub/screen/faqs/widgets/faq_app_bar.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';

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
        }));
  }
}
