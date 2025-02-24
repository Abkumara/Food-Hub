import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:get/get.dart';

class BottomNavBarWidget extends StatefulWidget {
  final ValueNotifier<int> selectedIndex;
  final Function onTapCallBack;

  const BottomNavBarWidget(
      {super.key, required this.selectedIndex, required this.onTapCallBack});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  final CartController _cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cartController.fetchViewCart();
    });
  }

  onItemTapped(int index) {
    widget.onTapCallBack(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, -1),
            blurRadius: 4,
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showUnselectedLabels: true,
        onTap: onItemTapped,
        currentIndex: widget.selectedIndex.value,
        backgroundColor: Colors.white,
        unselectedItemColor: navTextColor,
        selectedItemColor: primaryOrange,
        showSelectedLabels: true,
        unselectedLabelStyle: size10_M_medium(),
        selectedLabelStyle: size10_M_medium(),
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                widget.selectedIndex.value == 0
                    ? 'assets/icons/home.png'
                    : 'assets/icons/home.png',
                color: widget.selectedIndex.value == 0
                    ? primaryOrange
                    : navTextColor,
                width: 20,
                height: 20,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                widget.selectedIndex.value == 1
                    ? 'assets/icons/notification.svg'
                    : 'assets/icons/notification.svg',
                color: widget.selectedIndex.value == 1
                    ? primaryOrange
                    : navTextColor,
                width: 20,
                height: 20,
              ),
              label: "Notifications"),
          BottomNavigationBarItem(
            icon: Obx(
              () {
                final cart = _cartController.cart.value;
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset(
                      widget.selectedIndex.value == 2
                          ? 'assets/icons/cart.svg'
                          : 'assets/icons/cart.svg',
                      color: widget.selectedIndex.value == 2
                          ? primaryOrange
                          : navTextColor,
                      width: 20,
                      height: 20,
                    ),
                    if (cart != null && cart.items.isNotEmpty)
                      Positioned(
                        top: -8,
                        left: -5,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: greenColor,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 15,
                            minHeight: 15,
                          ),
                          child: Text(
                            cart.items.length.toString(),
                            style: const TextStyle(
                              color: colorWhite,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                widget.selectedIndex.value == 3
                    ? 'assets/icons/watchlist.svg'
                    : 'assets/icons/watchlist.svg',
                color: widget.selectedIndex.value == 3
                    ? primaryOrange
                    : navTextColor,
                width: 20,
                height: 20,
              ),
              label: "Wishlist"),
        ],
      ),
    );
  }
}
