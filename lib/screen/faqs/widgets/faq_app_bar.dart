import 'package:flutter/material.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';

class FaqAppBarWidget extends StatelessWidget {
  final double height;
  final String title;
  final Widget body;

  const FaqAppBarWidget({
    super.key,
    required this.height,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height,
            child: AppBar(
              leading: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.arrow_back, color: Colors.white)),
              titleSpacing: -3,
              title: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: Text(
                  title,
                  style: size20_M_bold().copyWith(color: Colors.white),
                ),
              ),
              centerTitle: false,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 90,
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  color: notificationAppBarColor,
                ),
              ),
            ),
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
