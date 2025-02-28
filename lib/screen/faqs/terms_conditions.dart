import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:foods_hub/controller/api_controller/terms_condition_controller.dart';
import 'package:foods_hub/core/widgets/loading_widgets.dart';
import 'package:foods_hub/screen/faqs/widgets/faq_app_bar.dart';
import 'package:foods_hub/screen/faqs/widgets/footer_widget.dart';
import 'package:get/get.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});
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
