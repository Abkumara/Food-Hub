import 'package:flutter/material.dart';
import 'package:foods_hub/controller/api_controller/wish_list_controller.dart';
import 'package:foods_hub/core/constant/urls.dart';
import 'package:foods_hub/screen/home/home_page/widget/bottom_sheet.dart';
import 'package:foods_hub/screen/home/home_page/widget/items_layout.dart';
import 'package:foods_hub/screen/tab_controller.dart';
import 'package:get/get.dart';

class WishListPage extends StatefulWidget {
  final Color? color;
  const WishListPage({super.key, this.color});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final WishListController wishListController = Get.put(WishListController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      wishListController.fetchWishList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Obx(() => _buildBody()),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 257,
      backgroundColor: Colors.transparent,
      flexibleSpace: Stack(
        children: [
          _buildBackgroundImage(),
          _buildBackButton(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Image.asset(
        'assets/images/watch_list.png',
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 8,
      left: 8,
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => _navigateToTabScreen(context),
      ),
    );
  }

  void _navigateToTabScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TabScreen()),
    );
  }

  Widget _buildBody() {
    if (wishListController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    if (wishListController.errorMessage.isNotEmpty) {
      return _buildErrorMessage();
    }
    if (wishListController.wishList.isEmpty) {
      return _buildEmptyMessage();
    }
    return _buildWishList();
  }

  Widget _buildErrorMessage() {
    return Center(
      child: Text(
        wishListController.errorMessage.value,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildEmptyMessage() {
    return const Center(child: Text("Your wishlist is empty."));
  }

  Widget _buildWishList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 30),
        shrinkWrap: true,
        itemCount: wishListController.wishList.length,
        itemBuilder: (context, index) {
          final wishListItem = wishListController.wishList[index];
          final product = wishListItem.product;
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    enableDrag: false,
                    isDismissible: false,
                    builder: (BuildContext context) {
                      return CustomBottomSheet(
                        initialFavorite: true,
                        productId: product.id,
                        description: product.description,
                        price: product.price.toString(),
                        rating: product.rating.toString(),
                        image: Urls.imageUrl + product.image,
                        productName: product.name,
                      );
                    },
                  );
                },
                child: ItemLayout(
                  name: product.name,
                  stars: product.rating.toString(),
                  rating: product.ratingCount ?? '1.3K+',
                  image: Urls.imageUrl + product.image,
                  address: product.address,
                  initialFavorite: true,
                  price: product.price.toString(),
                  productId: product.id,
                ),
              ),
              if (index != wishListController.wishList.length - 1)
                const SizedBox(height: 15),
            ],
          );
        },
      ),
    );
  }
}
