import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksn_mobile_customer/controller/api_controller/refund_history_contoller.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/core/widgets/loading_widgets.dart';
import 'package:ksn_mobile_customer/screens/faqs/widgets/faq_app_bar.dart';
import 'package:ksn_mobile_customer/screens/refunds/widgets/refund_card.dart';

class RefundStatusScreen extends StatefulWidget {
  const RefundStatusScreen({Key? key}) : super(key: key);

  @override
  State<RefundStatusScreen> createState() => _RefundStatusScreenState();
}

class _RefundStatusScreenState extends State<RefundStatusScreen> {
  bool showOlderRefunds = false;
  RefundController refundController = Get.put(RefundController());

  @override
  void initState() {
    super.initState();
    refundController.getRefunds(); // Fetch refunds on screen load
  }

  @override
  Widget build(BuildContext context) {
    return FaqAppBarWidget(
      height: 120,
      title: 'Refund Status',
      body: Obx(() {
        if (refundController.isLoading.value) {
          return ShimmerLoadingWidget(); // Show loading widget while fetching data
        } else {
          // Ensure refunds list is not empty before building the UI
          var refunds = refundController.refunds.value;

          return Container(
            color: const Color.fromARGB(249, 230, 230, 230),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Completed Refunds',
                    style: size14_M_bold(textColor: blackType1),
                  ),
                  const SizedBox(height: 16),
                  // Check if there are any refunds to display
                  if (refunds.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: showOlderRefunds
                          ? refunds.length
                          : 1, // Show only 1 refund if not expanded
                      itemBuilder: (context, index) {
                        var refundApi = refunds[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: RefundCard(
                            statusComplete: refundApi.status,
                            amount: refundApi.amount,
                            completeDate: refundApi.completedDate ?? '',
                            orderId: refundApi.orderId,
                            paymentMethod: 'UPI',
                            refundFormName: refundApi.refundFrom,
                            status: refundApi.statuses,
                          ),
                        );
                      },
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Center(
                        child: Text(
                          'No refunds available',
                          style: size14_M_bold(textColor: blackType1),
                        ),
                      ),
                    ),
                  if (!showOlderRefunds)
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showOlderRefunds =
                                true; // Show older refunds on button click
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryOrange,
                          minimumSize:
                              Size(MediaQuery.of(context).size.width - 32, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Show Older Refunds',
                          style: size14_M_bold(textColor: colorWhite),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
