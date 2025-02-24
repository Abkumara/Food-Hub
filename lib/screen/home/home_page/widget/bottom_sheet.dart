import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksn_mobile_customer/controller/api_controller/cart_controller.dart';
import 'package:ksn_mobile_customer/controller/api_controller/wish_list_controller.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/screens/tab_controller.dart';

class CustomBottomSheet extends StatefulWidget {
  final bool initialFavorite;
  final Color? color;
  final String productId;
  final String productName;
  final String description;
  final String price;
  final String rating;
  final String image;

  const CustomBottomSheet({
    super.key,
    required this.initialFavorite,
    this.color,
    required this.productId,
    required this.description,
    required this.price,
    required this.rating,
    required this.image,
    required this.productName,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final WishListController _wishListController = Get.put(WishListController());
  final CartController _cartController = Get.put(CartController());
  bool isTap = true;
  int value = 1;
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 26),
                  _buildTopRow(),
                  _buildProductName(),
                  const SizedBox(height: 10),
                  _buildPriceRow(),
                  const SizedBox(height: 5),
                  buildRatingRow(),
                  const SizedBox(height: 5),
                  Text(
                    widget.description,
                    style: size16_M_bold(textColor: const Color(0xFF696666)),
                  ),
                  const SizedBox(height: 15),
                  if (!isTap) _buildCartButton(context),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          child: Image.network(
            widget.image,
            height: 225,
            width: double.infinity,
            fit: BoxFit.fill,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, color: Colors.red);
            },
          ),
        ),
        Positioned(
          top: 16,
          right: 20,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.cancel,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 20,
          child: GestureDetector(
            onTap: () async {
              setState(() {
                isFavorite = !isFavorite;
              });

              if (isFavorite) {
                await _wishListController
                    .addProductToWishList(widget.productId);
                if (_wishListController.errorMessage.isNotEmpty) {
                  Get.snackbar(
                    "Error",
                    _wishListController.errorMessage.value,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                } else {
                  Get.snackbar(
                    "Success",
                    "Added to wishlist!",
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                }
              } else {
                await _wishListController
                    .removeProductToWishList(widget.productId);
                if (_wishListController.errorMessage.isNotEmpty) {
                  Get.snackbar(
                    "Error",
                    _wishListController.errorMessage.value,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                } else {
                  Get.snackbar(
                    "Removed",
                    "Removed from wishlist!",
                    backgroundColor: Colors.orange,
                    colorText: Colors.white,
                  );
                }
              }
            },
            child: SizedBox(
              height: 20,
              width: 24,
              child: SvgPicture.asset(
                'assets/icons/favorite.svg',
                color: isFavorite ? Colors.red : widget.color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          'assets/images/logo_best_seller.svg',
        ),
        isTap
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _cartController.addCart(widget.productId, value);
                    isTap = false;
                  });
                },
                child: _buildAddButton(),
              )
            : _buildCounter(),
      ],
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: 117,
      height: 34,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
        color: colorWhite,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Center(
        child: Text(
          'ADD',
          style: size18_M_bold(textColor: greenColor),
        ),
      ),
    );
  }

  Widget _buildCounter() {
    return Container(
      width: 117,
      height: 34,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
        color: colorWhite,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (value > 1) {
                  value--;
                  _cartController.addCart(widget.productId, value);
                }
              });
            },
            icon: Image.asset(
              'assets/icons/minus.png',
              color: greenColor,
              width: 20,
              height: 20,
            ),
          ),
          Text(
            value.toString(),
            style: size18_M_bold(textColor: greenColor).copyWith(fontSize: 19),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                value++;
                _cartController.addCart(widget.productId, value);
              });
            },
            icon: Image.asset(
              'assets/icons/plus.png',
              color: greenColor,
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductName() {
    return Row(
      children: [
        SizedBox(
          width: 188,
          child: Text(
            widget.productName,
            style: size20_M_bold(textColor: blackType1),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow() {
    return Row(
      children: [
        Text(
          "₹${widget.price}",
          style: GoogleFonts.prompt(
            color: blackType1,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Image.asset(
          'assets/icons/offer_tag.png',
          color: greenColor,
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 7),
        Text(
          "10% OFF USE KSN",
          style: size16_M_regular(textColor: blackType1),
        ),
      ],
    );
  }

  buildRatingRow() {
    return Row(
      children: [
        const Icon(
          Icons.stars_rounded,
          color: greenColor,
          size: 12,
        ),
        const SizedBox(width: 7),
        Text(
          widget.rating.toString(),
          style: size12_M_bold(textColor: greenColor).copyWith(fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildCartButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TabScreen(index: 2)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          height: 50,
          decoration: BoxDecoration(
            color: greenColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$value item added',
                style: size16_M_bold(),
              ),
              Text(
                'View Cart >',
                style: size16_M_bold(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
