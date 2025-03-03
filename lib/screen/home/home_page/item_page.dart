import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foods_hub/controller/api_controller/category_controller.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/core/constant/urls.dart';
import 'package:foods_hub/core/widgets/custome_search_bar.dart';
import 'package:foods_hub/screen/tab_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemPage extends StatefulWidget {
  final String id;
  final Color? color;
  const ItemPage({
    super.key,
    this.color,
    required this.id,
  });

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final CategoryController _categoryController = Get.put(CategoryController());

  // This list is used to track favorite state for each sub-product.
  final List<bool> isFavoriteList = List.generate(3, (index) => false);

  @override
  void initState() {
    super.initState();
    _categoryController.fetchProductsByCategory(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildSearchBar(),
          Expanded(child: _buildProductsList()),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SearchInputField(
        suffixIcon: Image.asset('assets/icons/search.png'),
        hintText: 'Search',
        borderColor: borderColor,
        validator: (String? value) {},
      ),
    );
  }

  Widget _buildProductsList() {
    return Obx(() {
      if (_categoryController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (_categoryController.errorMessage.isNotEmpty) {
        return Center(
          child: Text(
            _categoryController.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

      final products = _categoryController.productByCategory.value?.products;
      if (products == null || products.isEmpty) {
        return const Center(child: Text("No products available"));
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        itemCount: products.length,
        itemBuilder: (context, productIndex) {
          final product = products[productIndex];
          if (product.subProducts.isEmpty) return const SizedBox();
          return Column(
            children: product.subProducts.asMap().entries.map((entry) {
              final subProductIndex = entry.key;
              final subProduct = entry.value;
              return _buildSubProductItem(subProduct, subProductIndex);
            }).toList(),
          );
        },
      );
    });
  }

  Widget _buildSubProductItem(dynamic subProduct, int subProductIndex) {
    return Container(
      height: 160,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD8D8D8),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildProductInfo(subProduct),
            _buildProductImageAndActions(subProduct, subProductIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildProductInfo(dynamic subProduct) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIcon(),
          const SizedBox(height: 5),
          Text(
            subProduct.name,
            style: size16_M_bold(textColor: Colors.black),
          ),
          const SizedBox(height: 5),
          Text(
            "₹${subProduct.inputPrice}",
            style: GoogleFonts.prompt(
              color: navTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          _buildRatingRow(subProduct),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Image.asset(
      'assets/icons/icon1.png',
      width: 16.0,
      height: 16.0,
    );
  }

  Widget _buildRatingRow(dynamic subProduct) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/rating.svg',
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 5),
        Text(
          '${subProduct.rating}',
          style: size14_M_bold(textColor: greenColor).copyWith(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildProductImageAndActions(dynamic subProduct, int subProductIndex) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        _buildProductImage(subProduct),
        _buildFavoriteIcon(subProductIndex),
        _buildAddButton(),
      ],
    );
  }

  Widget _buildProductImage(dynamic subProduct) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        Urls.imageUrl + subProduct.image,
        height: 111,
        width: 105,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildFavoriteIcon(int subProductIndex) {
    return Positioned(
      top: 8,
      right: 8,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isFavoriteList[subProductIndex] = !isFavoriteList[subProductIndex];
          });
        },
        child: SvgPicture.asset(
          'assets/icons/favorite.svg',
          height: 18,
          width: 22,
          color: isFavoriteList[subProductIndex] ? Colors.red : widget.color,
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Positioned(
      bottom: -10,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 76,
          height: 24,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TabScreen(index: 2)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorWhite,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                "ADD",
                style:
                    size12_M_bold(textColor: greenColor).copyWith(fontSize: 13),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
