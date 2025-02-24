import 'package:flutter/material.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/screens/tab_controller.dart';

class NotificationAppBarWidget extends StatelessWidget {
  const NotificationAppBarWidget({
    super.key,
    required this.height,
    required this.title,
    required this.listView,
  });
  final double height;
  final String title;
  final Widget listView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height,
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TabScreen(),
                    ),
                  );
                },
              ),
              titleSpacing: -1,
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
          const SizedBox(height: 16),
          Expanded(child: listView),
        ],
      ),
    );
  }
}
