import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foods_hub/controller/api_controller/category_controller.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/core/constant/urls.dart';
import 'package:foods_hub/screen/home/home_page/item_page.dart';
import 'package:foods_hub/screen/home/home_page/widget/bottom_sheet.dart';
import 'package:get/get.dart';

class SelectCategoryList extends StatefulWidget {
  final String id;

  const SelectCategoryList({
    super.key,
    required this.id,
  });

  @override
  State<SelectCategoryList> createState() => _SelectCategoryListState();
}

class _SelectCategoryListState extends State<SelectCategoryList> {
  final CategoryController _categoryController = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _categoryController.fetchProductsByCategory(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
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
      if (_categoryController.categories.isEmpty) {
        return const Center(child: Text("No products available"));
      }
      return _buildProductsGrid();
    });
  }

  Widget _buildProductsGrid() {
    final products = _categoryController.productByCategory.value!.products;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 59,
        childAspectRatio: 0.86,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductItem(product);
      },
    );
  }

  Widget _buildProductItem(dynamic product) {
    return GestureDetector(
      onTap: () => _handleProductTap(product),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildProductContainer(product),
          _buildProductImage(product),
        ],
      ),
    );
  }

  Widget _buildProductContainer(dynamic product) {
    return Container(
      decoration: BoxDecoration(
        color: appBarColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 32, bottom: 10, left: 9, right: 9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildRatingRow(product),
            const SizedBox(height: 5),
            Text(
              product.name,
              textAlign: TextAlign.center,
              style:
                  size10_M_bold(textColor: Colors.black).copyWith(fontSize: 8),
            ),
            const SizedBox(height: 5),
            if (product.name != 'Halwha') _buildAddButton(product),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingRow(dynamic product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/rating.svg',
          width: 7,
          height: 7,
        ),
        const SizedBox(width: 5),
        Text(
          product.rating.toString(),
          style: size10_M_bold(textColor: Colors.green).copyWith(fontSize: 9),
        ),
      ],
    );
  }

  Widget _buildAddButton(dynamic product) {
    return SizedBox(
      width: 52,
      height: 17,
      child: ElevatedButton(
        onPressed: () => _showBottomSheet(product),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorWhite,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.38),
          ),
        ),
        child: Center(
          child: Text(
            "ADD",
            style: size12_M_bold(textColor: greenColor).copyWith(fontSize: 9),
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(dynamic product) {
    return Positioned(
      top: -32,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              Urls.imageUrl + product.image,
              width: 64,
              height: 64,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  void _handleProductTap(dynamic product) {
    // Navigate to ItemPage only if the product name is "Halwha"
    if (product.name == 'Halwha') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItemPage(id: product.categoryId),
        ),
      );
    }
  }

  void _showBottomSheet(dynamic product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: true,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          initialFavorite: false,
          productId: product.id,
          description: product.description,
          price: product.discountPrice.toString(),
          rating: product.rating.toString(),
          image: Urls.imageUrl + product.image,
          productName: product.name,
        );
      },
    );
  }
}
