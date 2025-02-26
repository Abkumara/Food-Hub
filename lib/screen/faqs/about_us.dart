import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:foods_hub/controller/api_controller/about_us_controller.dart';
import 'package:foods_hub/core/widgets/loading_widgets.dart';
import 'package:foods_hub/screen/faqs/widgets/faq_app_bar.dart';
import 'package:get/get.dart';

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
                  const SizedBox(height: 4),
                ],
              ),
            );
          }
        }));
  }
}
