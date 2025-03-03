import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foods_hub/controller/api_controller/wish_list_controller.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemLayout extends StatefulWidget {
  final String productId;
  final String name;
  final String? address;
  final String stars;
  final String rating;
  final String image;
  final String price;
  final Color? color;
  final bool initialFavorite;

  const ItemLayout({
    super.key,
    required this.productId,
    required this.name,
    this.address,
    required this.stars,
    required this.rating,
    required this.image,
    this.color,
    required this.initialFavorite,
    required this.price,
  });

  @override
  State<ItemLayout> createState() => _ItemLayoutState();
}

class _ItemLayoutState extends State<ItemLayout> {
  late bool isFavorite;
  final WishListController _wishListController = Get.put(WishListController());

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildImageSection(),
        const SizedBox(width: 15),
        Expanded(child: _buildDetailsSection()),
      ],
    );
  }

  /// Builds the left side image section with favorite icon and price tag.
  Widget _buildImageSection() {
    return SizedBox(
      width: 130,
      height: 171,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            _buildProductImageWithGradient(),
            _buildFavoriteIcon(),
            _buildPriceTag(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImageWithGradient() {
    return Stack(
      children: [
        Image.network(
          widget.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) =>
              const Center(child: Icon(Icons.error)),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the favorite icon in the top right corner.
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

  /// Builds the price tag at the bottom left of the image.
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
                "AT ",
                style: size14_M_bold().copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                "₹${widget.price}",
                style: GoogleFonts.prompt(
                  color: colorWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the right side details section.
  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        const SizedBox(height: 4),
        _buildRatingRow(),
        if (widget.address != null) ...[
          const SizedBox(height: 10),
          _buildAddress(),
        ],
        const SizedBox(height: 10),
        _buildDeliveryTag(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.name,
      style: size24_M_bold(textColor: Colors.black).copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildRatingRow() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/rating.svg',
          width: 20,
          height: 20,
        ),
        const SizedBox(width: 5),
        Text(
          widget.stars,
          style: size16_M_bold(textColor: titleColor),
        ),
        const SizedBox(width: 3),
        Text(
          "(${widget.rating})",
          style: size16_M_bold(textColor: titleColor),
        ),
      ],
    );
  }

  Widget _buildAddress() {
    return Text(
      widget.address!,
      style: size14_M_regular(textColor: titleColor).copyWith(
        fontWeight: FontWeight.w300,
      ),
    );
  }

  /// Builds the delivery tag button.
  Widget _buildDeliveryTag() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xffF86900).withOpacity(0.2),
              const Color(0xFFFFFFFF).withOpacity(0.2),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/delivery.svg',
              color: primaryOrange,
              width: 15,
              height: 13.5,
            ),
            const SizedBox(width: 6),
            Text(
              "FREE DELIVERY",
              style: size10_M_bold(textColor: primaryOrange),
            ),
          ],
        ),
      ),
    );
  }

  /// Toggles the favorite state and calls appropriate wishlist methods.
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
