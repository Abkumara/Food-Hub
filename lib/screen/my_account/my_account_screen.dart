import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksn_mobile_customer/controller/api_controller/auth_controller.dart';
import 'package:ksn_mobile_customer/controller/api_controller/order_controller.dart';
import 'package:ksn_mobile_customer/controller/api_controller/user_profile_controller.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/core/widgets/loading_widgets.dart';
import 'package:ksn_mobile_customer/screens/my_account/widgets/my_account_home_screen_widget.dart';
import 'package:ksn_mobile_customer/screens/ratings/rate_order_screen.dart';
import 'package:ksn_mobile_customer/widgets/custom_app_bar_widget.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  bool moreView = false;
  final OrderController _orderController = OrderController();
  final userProfileController = Get.put(UserProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userProfileController.fetchUserProfile();
    _orderController.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEFEF),
      appBar: const CustomAppBar(title: 'My Account'),
      body: Obx(() {
        if (_orderController.isLoading.value) {
          return ShimmerLoadingWidget();
        } else {
          var pastOrders = _orderController.orders.value
              .where((order) => order.preparationStatus == 'Delivered')
              .toList();

          int itemCount = moreView ? pastOrders.length : 2;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: colorWhite,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyAccountHeadParts(),
                      const ListOfContainers(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'PAST ORDERS',
                    style: size14_M_medium(textColor: const Color(0xff262626)),
                  ),
                ),
                Container(
                    color: colorWhite,
                    child: (pastOrders.isEmpty)
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Center(
                              child: Text(
                                'No orders yet',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: itemCount,
                                itemBuilder: (context, index) {
                                  var orderApi = pastOrders[index];
                                  return PastOrderWidget(
                                    billTotal: orderApi.billTotal ?? '0.0',
                                    deliverFee: orderApi.deliveryFee ?? '0.0',
                                    deliveryTip: orderApi.deliveryTips ?? '0.0',
                                    distance:
                                        orderApi.deliveryDistance ?? '0.0',
                                    gstAndResturantCharges: orderApi
                                        .gstAndRestorenCharge
                                        .toString(),
                                    itemDiscount: orderApi.itemDiscount ?? '0',
                                    itemTotalPrice: orderApi.itemTotal ?? '0',
                                    platformFee: orderApi.platformFee ?? '0.0',
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => RateOrderScreen(
                                            orderId:
                                                orderApi.orderId.toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: itemCount,
                                    dotLine: () {
                                      setState(() {});
                                    },
                                    name: orderApi.vendorName ?? '',
                                    address: orderApi.vendorLocation ?? '',
                                    price: '₹${orderApi.billTotal.toString()}',
                                    date: orderApi.orderDate ?? '',
                                    index: index,
                                  );
                                },
                              ),
                              if (pastOrders.length >
                                  2) // Only show "View More" if orders > 2
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      moreView = !moreView;
                                    });
                                  },
                                  child: Text(
                                    moreView
                                        ? 'See Less Orders'
                                        : 'View More Orders',
                                  ),
                                ),
                            ],
                          )),
                const SizedBox(height: 35),
                GestureDetector(
                  onTap: () {
                    final authController = Get.put(AuthController());
                    authController.logOut(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    color: colorWhite,
                    child: Text(
                      'LOGOUT',
                      style: size15_M_medium_black(),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        }
      }),
    );
  }
}
