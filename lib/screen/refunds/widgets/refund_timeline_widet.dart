import 'package:flutter/material.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/model/refund_history_model.dart';

class RefundTimeline extends StatelessWidget {
  const RefundTimeline({
    super.key,
    required this.steps,
  });
  final List<RefundStatus> steps;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 1, 178, 1),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                if (index != steps.length - 1)
                  Container(
                    width: 2,
                    height: 40,
                    color: greenColor,
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    steps[index].status,
                    style: size12_M_medium(textColor: blackType1),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    steps[index].completedDate,
                    style: size10_M_regular(textColor: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    steps[index].status,
                    style: size10_M_regular(textColor: Colors.grey),
                  ),
                  if (index != steps.length - 1) const SizedBox(height: 1),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
