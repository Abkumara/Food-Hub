import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksn_mobile_customer/controller/api_controller/category_controller.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/core/constant/urls.dart';
import 'package:ksn_mobile_customer/screens/home/home_page/item_page_beverages.dart';

class CategoryList extends StatefulWidget {
  final void Function(int index) onPressed;

  const CategoryList({
    super.key,
    required this.onPressed,
  });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final CategoryController _categoryController = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _categoryController.fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_categoryController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (_categoryController.categories.isEmpty) {
        return const Center(child: Text("No categories available"));
      }

      return _buildCategoryGrid();
    });
  }

  Widget _buildCategoryGrid() {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 59,
      childAspectRatio: 0.86,
      shrinkWrap: true,
      children: List.generate(_categoryController.categories.length, (index) {
        final category = _categoryController.categories[index];
        return _buildCategoryItem(category, index);
      }),
    );
  }

  Widget _buildCategoryItem(dynamic category, int index) {
    return GestureDetector(
      onTap: () => _handleCategoryTap(category, index),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildCategoryContent(category, index),
          _buildCategoryImage(category),
        ],
      ),
    );
  }

  Widget _buildCategoryContent(dynamic category, int index) {
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
            Text(
              category.name,
              textAlign: TextAlign.center,
              style:
                  size10_M_bold(textColor: Colors.black).copyWith(fontSize: 8),
            ),
            const SizedBox(height: 5),
            Text(
              category.description,
              textAlign: TextAlign.center,
              style:
                  size10_M_bold(textColor: addressColor).copyWith(fontSize: 7),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryImage(dynamic category) {
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
              Urls.imageUrl + category.image,
              width: 64,
              height: 64,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  void _handleCategoryTap(dynamic category, int index) {
    if (category.name == "Bevereges") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItemPageBeverages(id: category.id),
        ),
      );
    } else {
      widget.onPressed(index);
    }
  }
}
