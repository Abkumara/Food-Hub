import 'package:flutter/material.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/screens/home/order_detail/tab1_page.dart';
import 'package:ksn_mobile_customer/screens/home/order_detail/tab2_page.dart';
import 'package:ksn_mobile_customer/screens/my_account/my_address_screen.dart';
import 'package:ksn_mobile_customer/screens/tab_controller.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TabScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "KSN",
                        style:
                            size16_M_bold(textColor: const Color(0xff696666)),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyAddressScreen(),
                            )),
                        child: Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Home ",
                                    style:
                                        size12_M_bold(textColor: Colors.black),
                                  ),
                                  TextSpan(
                                    text:
                                        "| Nandhini Enclave, Road no 4 , Ma...",
                                    style: size10_M_regular(
                                        textColor: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Image.asset('assets/icons/arrow_down.png'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                padding: const EdgeInsets.all(2),
                unselectedLabelColor: Colors.white,
                labelColor: greenColor,
                indicatorColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.circular(5),
                ),
                dividerColor: Colors.transparent,
                labelStyle: size16_M_bold(textColor: colorWhite),
                controller: tabController,
                tabs: const [
                  Tab(text: 'Order Details'),
                  Tab(text: 'Past Orders'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                Tab1(),
                Tab2(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
