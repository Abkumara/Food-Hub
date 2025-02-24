import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksn_mobile_customer/controller/api_controller/wish_list_controller.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';

class Picks extends StatefulWidget {
  const Picks({
    super.key,
    required this.image,
    required this.itemName,
    required this.price,
    required this.rating,
    required this.initialFavorite,
    required this.productId,
    this.color,
  });

  final String image;
  final String itemName;
  final String price;
  final double rating;
  final bool initialFavorite;
  final String productId;
  final Color? color;

  @override
  State<Picks> createState() => _PicksState();
}

class _PicksState extends State<Picks> {
  late bool isFavorite;
  final WishListController _wishListController = Get.put(WishListController());

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageSection(),
        const SizedBox(height: 5),
        _buildItemName(),
        _buildRatingRow(),
      ],
    );
  }

  /// Builds the image section including product image, wishlist icon, and price tag.
  Widget _buildImageSection() {
    return SizedBox(
      width: 112,
      height: 147,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            _buildProductImage(),
            _buildFavoriteIcon(),
            _buildPriceTag(),
          ],
        ),
      ),
    );
  }

  /// Loads the product image with loading and error handling.
  Widget _buildProductImage() {
    return Image.network(
      widget.image,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) => const Center(
        child: Icon(Icons.error, color: Colors.red),
      ),
    );
  }

  /// Builds the favorite icon at the top-right corner.
  Widget _buildFavoriteIcon() {
    return Positioned(
      top: 12,
      right: 12,
      child: GestureDetector(
        onTap: _toggleFavorite,
        child: SizedBox(
          height: 24,
          width: 30,
          child: SvgPicture.asset(
            'assets/icons/favorite.svg',
            color: isFavorite ? Colors.red : widget.color,
          ),
        ),
      ),
    );
  }

  /// Builds the price tag displayed at the bottom-left of the image.
  Widget _buildPriceTag() {
    return Positioned(
      bottom: 10,
      left: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ITEMS",
            style: size10_M_bold().copyWith(fontWeight: FontWeight.w700),
          ),
          Row(
            children: [
              Text(
                "AT",
                style: size12_M_bold().copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                " ₹${widget.price}",
                style: GoogleFonts.prompt(
                  color: colorWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the item name text.
  Widget _buildItemName() {
    return Text(
      widget.itemName,
      style: size14_M_bold(textColor: blackType1),
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Builds the rating row with the star icon and rating text.
  Widget _buildRatingRow() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/rating.svg',
          width: 11,
          height: 11,
        ),
        const SizedBox(width: 5),
        Text(
          '${widget.rating}',
          style: size10_M_medium(textColor: titleColor),
        ),
      ],
    );
  }

  /// Toggles the favorite state and updates the wishlist.
  Future<void> _toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      await _wishListController.addProductToWishList(widget.productId);
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
      await _wishListController.removeProductToWishList(widget.productId);
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
  }
}
