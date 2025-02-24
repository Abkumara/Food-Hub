import 'package:flutter/material.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/screens/home/cart_page/cart_page.dart';
import 'package:ksn_mobile_customer/screens/home/home_page/home_page.dart';
import 'package:ksn_mobile_customer/core/widgets/bottom_nav_bar.dart';
import 'package:ksn_mobile_customer/screens/home/notification/notification_page.dart';
import 'package:ksn_mobile_customer/screens/home/order_detail/order_details_page.dart';
import 'package:ksn_mobile_customer/screens/home/wish_list/wish_list_page.dart';

class TabScreen extends StatefulWidget {
  final int? index;
  const TabScreen({super.key, this.index});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late ValueNotifier<int> selectedIndex;

  @override
  void initState() {
    if (widget.index != null) {
      selectedIndex = ValueNotifier(widget.index!);
    } else {
      selectedIndex = ValueNotifier(0);
    }
    super.initState();
  }

  onItemTapped(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const NotificationPage(),
    const CartPage(),
    const  WishListPage(),
    const  OrderDetailPage(),

  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          body: _widgetOptions[selectedIndex.value],
          bottomNavigationBar: Container(
              color: primaryOrange,
              child: BottomNavBarWidget(
                selectedIndex: selectedIndex,
                onTapCallBack: (value) {
                  onItemTapped(value);
                },
              )),
        );
      },
    );
  }
}
