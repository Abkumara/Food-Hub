import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksn_mobile_customer/controller/api_controller/cart_controller.dart';
import 'package:ksn_mobile_customer/controller/api_controller/order_controller.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/core/constant/urls.dart';
import 'package:ksn_mobile_customer/model/cart_model.dart';
import 'package:ksn_mobile_customer/screens/coupon/coupon_page.dart';
import 'package:ksn_mobile_customer/screens/home/payment_gateway/payment_page.dart';
import 'package:ksn_mobile_customer/screens/my_account/my_address_screen.dart';
import 'package:ksn_mobile_customer/screens/tab_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController _cartController = Get.put(CartController());
  final OrderController _orderController = Get.put(OrderController());
  String _selectedDeliveryType = '';
  bool _isExpanded = false;
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _orderController.fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    _cartController.fetchViewCart();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          automaticallyImplyLeading: false,
          title: _buildTitle(context),
        ),
      ),
      body: Obx(
        () {
          final cart = _cartController.cart.value;
          if (cart == null || cart.items.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _cartController.cart.value?.items.length ?? 0,
                      itemBuilder: (context, index) {
                        final cartItem =
                            _cartController.cart.value?.items[index];
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              decoration: _boxDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildProductInfo(cartItem!.productName),
                                      Row(
                                        children: [
                                          Container(
                                            width: 71,
                                            height: 22,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  spreadRadius: 1,
                                                  blurRadius: 3,
                                                  offset: const Offset(0, 0),
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 7),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  _buildQuantityButton(
                                                      'assets/icons/minus.png',
                                                      () => _updateQuantity(
                                                          -1,
                                                          cartItem.productId,
                                                          cartItem)),
                                                  Text(
                                                    cartItem.quantity
                                                        .toString(),
                                                    style: size12_M_bold(
                                                        textColor: greenColor),
                                                  ),
                                                  _buildQuantityButton(
                                                      'assets/icons/plus1.png',
                                                      () => _updateQuantity(
                                                            1,
                                                            cartItem.productId,
                                                            cartItem,
                                                          )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                            children: [
                                              Text(
                                                '₹${cartItem.totalPrice}',
                                                style: GoogleFonts.prompt(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xff626262),
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                              Text(
                                                '₹${cartItem.totalPrice}',
                                                style: GoogleFonts.prompt(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  _buildAddMoreButton(context),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 161,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: _boxDecoration1(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'COMPLETE YOUR MEAL',
                            style: size12_M_bold(
                                textColor: const Color(0xff767676)),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 109,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children:
                                  _buildCartItems(cart.items, _cartController),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 158,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTitle1(),
                          const SizedBox(height: 12),
                          _buildCouponSection(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 108,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: _containerDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery Type',
                            style: size12_M_bold(
                                textColor: const Color(0xff767676)),
                          ),
                          const SizedBox(height: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDeliveryOption('Home Delivery'),
                              const SizedBox(height: 12),
                              _buildDeliveryOption('Pick Up Near By'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: _boxDecoration2(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(_cartController),
                          const SizedBox(height: 12),
                          if (_isExpanded)
                            _buildExpandedDetails(_cartController),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 85,
                  color: colorWhite,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₹${_cartController.cart.value?.toPayAmount ?? 0}',
                            style: GoogleFonts.prompt(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              _isExpanded = !_isExpanded;
                            }),
                            child: Text('View Detailed Bill',
                                style: size12_M_bold(textColor: greenColor)),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _orderController.orderCheckOut("pick-up-near-by");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PaymentGateWay(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: greenColor,
                          foregroundColor: colorWhite,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Proceed to Pay',
                          style: size16_M_bold(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildBackButton(context),
            const SizedBox(width: 8),
            _buildTitleContent(context),
          ],
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TabScreen()),
        );
      },
    );
  }

  Widget _buildTitleContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "KSN",
          style: size12_M_bold(textColor: Colors.black).copyWith(fontSize: 15),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyAddressScreen()),
          ),
          child: Row(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Home ",
                      style: size12_M_bold(textColor: Colors.black),
                    ),
                    TextSpan(
                      text: "| Nandhini Enclave, Road no 4 , Ma...",
                      style: size10_M_regular(textColor: Colors.black),
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
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Widget _buildProductInfo(String productName) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Image.asset(
            'assets/icons/icon1.png',
            width: 16.0,
            height: 16.0,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
              child: Text(
                productName,
                style: size18_M_bold(textColor: Colors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _buildProductType(),
          ],
        ),
      ],
    );
  }

  Widget _buildProductType() {
    return Row(
      children: [
        Text(
          'Butter dosa',
          style:
              GoogleFonts.prompt(fontSize: 10, color: const Color(0xff767676)),
        ),
        const SizedBox(width: 3),
        Image.asset(
          'assets/icons/arrow_down.png',
          width: 8,
          height: 14,
          color: const Color(0xff767676),
        ),
      ],
    );
  }

  Widget _buildQuantityButton(String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        imagePath,
        width: 12,
        height: 12,
        color: greenColor,
      ),
    );
  }

  void _updateQuantity(int increment, String productId, dynamic cartItem) {
    setState(() {
      if (cartItem.quantity > 1 || increment > 0) {
        cartItem.quantity += increment;
        _cartController.addCart(productId, cartItem.quantity);
      }
    });
  }

  Widget _buildAddMoreButton(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TabScreen()),
        ),
        icon: const Icon(Icons.add, color: Color(0xff767676), size: 16),
        label: Text('Add more items',
            style: GoogleFonts.prompt(
                fontSize: 10, color: const Color(0xff767676))),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xffCDCACA), width: 0.61),
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration1() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  List<Widget> _buildCartItems(List<Item> items, cartController) {
    if (items.isEmpty) return [];

    return List.generate(items.length, (index) {
      final item = items[index];
      return Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(item, cartController, 1),
            const SizedBox(height: 8),
            _buildProductInfo1(item),
            const SizedBox(height: 4),
            _buildPriceText(item.discountPrice),
          ],
        ),
      );
    });
  }

  Widget _buildProductImage(Item item, cartController, int increment) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            Urls.imageUrl + item.productImage.toString(),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image_not_supported),
          ),
        ),
        Positioned(
          top: -8,
          right: -8,
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (item.quantity > 1 || increment > 0) {
                  item.quantity += increment;
                  _cartController.addCart(
                      item.productId.toString(), item.quantity);
                }
              });
            },
            child: Image.asset(
              'assets/icons/add_image.png',
              width: 21,
              height: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo1(Item item) {
    return Row(
      children: [
        Image.asset('assets/icons/icon1.png', width: 12, height: 12),
        const SizedBox(width: 3),
        SizedBox(
          width: 50,
          child: Text(
            item.productName,
            style: size12_M_regular(textColor: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceText(String? price) {
    return Text(
      '₹$price',
      style: GoogleFonts.prompt(
        color: const Color(0xff7E7E7E),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTitle1() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 13, top: 10),
      child: Text(
        'SAVINGS CORNER',
        style: size12_M_bold(textColor: const Color(0xff767676)),
      ),
    );
  }

  Widget _buildCouponSection() {
    return Column(
      children: [
        _buildCouponRow(
            'Apply Coupon', 'assets/icons/tag.png', Icons.chevron_right),
        const SizedBox(height: 8),
        const Divider(color: Color(0xffF2F2F2)),
        _buildSavingsRow(),
      ],
    );
  }

  Widget _buildCouponRow(String text, String iconPath, IconData trailingIcon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(iconPath, width: 23.0, height: 23.0),
              const SizedBox(width: 12),
              Text(text, style: size14_M_medium(textColor: Colors.black)),
            ],
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CouponPage(),
                  ),
                );
              },
              child: Icon(trailingIcon, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildSavingsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/icons/tag.png', width: 23.0, height: 23.0),
              const SizedBox(width: 12),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '₹4 ',
                      style: GoogleFonts.prompt(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: 'saved with ‘item at ',
                      style: size14_M_medium(textColor: Colors.black),
                    ),
                    TextSpan(
                      text: '₹49’',
                      style: GoogleFonts.prompt(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Image.asset('assets/icons/correct.png', width: 10.5, height: 7.5),
              const SizedBox(width: 4),
              Text(
                'Applied',
                style: size12_M_bold(textColor: const Color(0xff00B800)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Widget _buildDeliveryOption(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDeliveryType = title;
        });
      },
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _selectedDeliveryType == title
                    ? primaryOrange
                    : borderColor,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: _selectedDeliveryType == title
                  ? Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryOrange,
                      ),
                    )
                  : const SizedBox(width: 12, height: 12),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: size14_M_medium(textColor: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(cartController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset('assets/icons/cart_bill.png',
                width: 23.0, height: 23.0),
            const SizedBox(width: 8.5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('To Pay ',
                        style: size14_M_bold(textColor: Colors.black)),
                    Text('₹${cartController.cart.value!.toPayAmount}',
                        style: GoogleFonts.prompt(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                Text('Incl. all taxes & charges',
                    style: size10_M_regular(textColor: Colors.black)),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Icon(
            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedDetails(cartController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Item Total', cartController.cart.value!.itemTotal),
        _buildDetailRow(
            'Delivery Fee | ${cartController.cart.value!.deliveryDistance}',
            cartController.cart.value!.deliveryFee),
        _buildSavingsRow2(),
        const SizedBox(height: 10),
        const DottedLine(lineThickness: 1, dashColor: Color(0xffEAEAEA)),
        const SizedBox(height: 10),
        _buildDetailRow(
            'Item Discount',
            -((cartController.cart.value?.itemTotal ?? 0) -
                (cartController.cart.value?.itemDiscount ?? 0)),
            isDiscount: true),
        const SizedBox(height: 10),
        const DottedLine(lineThickness: 1, dashColor: Color(0xffEAEAEA)),
        const SizedBox(height: 10),
        _buildDetailRow(
            'Delivery Tip', cartController.cart.value!.deliveryTips),
        _buildDetailRow('Platform Fee', cartController.cart.value!.platformFee),
        _buildDetailRow('GST and Restaurant Charges',
            cartController.cart.value!.gstAndRestorenCharge),
        const SizedBox(height: 9.5),
        const DottedLine(lineThickness: 1, dashColor: Color(0xffEAEAEA)),
        const SizedBox(height: 25),
        _buildToPayRow('To Pay', cartController.cart.value!.toPayAmount,
            isTotal: true),
      ],
    );
  }

  Widget _buildDetailRow(String title, num value,
      {bool isDiscount = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: size12_M_regular(textColor: const Color(0xff646161))),
        Text(
          '₹${value.toStringAsFixed(2)}',
          style: GoogleFonts.prompt(
            color: isDiscount
                ? greenColor
                : (isTotal ? Colors.black : const Color(0xff616060)),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildToPayRow(String title, num value,
      {bool isDiscount = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: size12_M_medium(textColor: const Color(0xFF000000))),
        Text(
          '₹${value.toStringAsFixed(2)}',
          style: GoogleFonts.prompt(
            color: isDiscount
                ? greenColor
                : (isTotal ? Colors.black : const Color(0xff616060)),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSavingsRow2() {
    return Row(
      children: [
        Text('Order above ',
            style: size12_M_regular(textColor: const Color(0xff646161))),
        Text('₹100 ',
            style: GoogleFonts.prompt(
                color: const Color(0xff646161),
                fontSize: 12,
                fontWeight: FontWeight.w400)),
        Text('to save',
            style: size12_M_regular(textColor: const Color(0xff646161))),
        Text(' ₹5',
            style: GoogleFonts.prompt(
                color: const Color(0xff646161),
                fontSize: 12,
                fontWeight: FontWeight.w400)),
      ],
    );
  }

  BoxDecoration _boxDecoration2() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
