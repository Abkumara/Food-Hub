import 'package:flutter/material.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/model/refund_history_model.dart';
import 'package:ksn_mobile_customer/screens/refunds/widgets/refund_timeline_widet.dart';

class RefundCard extends StatefulWidget {
  const RefundCard({
    super.key,
    required this.refundFormName,
    required this.paymentMethod,
    required this.completeDate,
    required this.amount,
    required this.orderId,
    required this.status,
    required this.statusComplete,
  });
  final String refundFormName;
  final String paymentMethod;
  final String completeDate;
  final String amount;
  final String orderId;
  final String statusComplete;
  final List<RefundStatus> status;
  @override
  State<RefundCard> createState() => _RefundCardState();
}

class _RefundCardState extends State<RefundCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    bool isCompleted = widget.statusComplete == 'Completed';
    return Container(
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.refundFormName,
                      style: size14_M_bold(textColor: blackType1),
                    ),
                    isCompleted
                        ? Row(
                            children: [
                              Text(
                                'Completed',
                                style: size10_M_medium(
                                    textColor:
                                        const Color.fromARGB(255, 1, 178, 1)),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 1, 178, 1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: colorWhite,
                                  size: 12,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                'Pending',
                                style: size10_M_medium(textColor: Colors.red),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.pending_actions,
                                color: Colors.red,
                                size: 16,
                              ),
                            ],
                          )
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'To: ',
                                style: size12_M_bold(textColor: blackType1),
                              ),
                              TextSpan(
                                text: widget.paymentMethod,
                                style:
                                    size12_M_regular(textColor: addressColor),
                              ),
                            ],
                          ),
                        ),
                        // Text(
                        //   'To: ${widget.refund.paymentMethod}',
                        //   style: size12_M_bold(textColor: blackType1),
                        // ),
                        const SizedBox(height: 4),
                        if (isCompleted)
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Completed on: ',
                                  style: size12_M_bold(textColor: blackType1),
                                ),
                                TextSpan(
                                  text: widget.completeDate,
                                  style:
                                      size12_M_regular(textColor: addressColor),
                                ),
                              ],
                            ),
                          ),
                        // Text(
                        //   'Completed on: ${widget.refund.completedDate}',
                        //   style: size12_M_bold(textColor: blackType1),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '₹${widget.amount}',
                      style: size12_M_bold(textColor: blackType1),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          if (!isExpanded)
            InkWell(
              onTap: () {
                setState(() {
                  isExpanded = true;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    'See Details',
                    style: size14_M_bold(textColor: primaryOrange),
                  ),
                ),
              ),
            )
          else
            InkWell(
              onTap: () {
                setState(() {
                  isExpanded = false;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Order ID: ',
                            style: size12_M_bold(textColor: blackType1),
                          ),
                          TextSpan(
                            text: widget.orderId,
                            style: size12_M_regular(textColor: addressColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    const SizedBox(height: 16),
                    RefundTimeline(steps: widget.status),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
