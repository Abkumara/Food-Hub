import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksn_mobile_customer/controller/api_controller/banner_controller.dart';
import 'package:ksn_mobile_customer/controller/api_controller/product_controller.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/core/constant/urls.dart';
import 'package:ksn_mobile_customer/screens/home/home_page/widget/bottom_sheet.dart';

class HomeSliderView extends StatefulWidget {
  final double borderRadius;
  final double buttonRadius;
  final int numberOfSlides;
  final Color activeIndicatorColor;
  final Color inactiveIndicatorColor;

  const HomeSliderView({
    super.key,
    this.borderRadius = 20.0,
    this.buttonRadius = 8.0,
    this.numberOfSlides = 3,
    this.activeIndicatorColor = titleColor,
    this.inactiveIndicatorColor = bannerDot,
  });

  @override
  State<HomeSliderView> createState() => _HomeSliderViewState();
}

class _HomeSliderViewState extends State<HomeSliderView> {
  final bannerController = Get.put(BannerController());
  final productController = Get.put(ProductController());

  late PageController _pageController;
  late Timer _autoPlayTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    bannerController.fetchBanners();
    _pageController = PageController(initialPage: 0);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % bannerController.banners.length;
        });
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoPlayTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (bannerController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (bannerController.errorMessage.isNotEmpty) {
          return Center(child: Text(bannerController.errorMessage.value));
        }
        if (bannerController.banners.isEmpty) {
          return const Center(child: Text('No banners available'));
        }
        return Column(
          children: [
            SizedBox(
              height: 130,
              child: PageView.builder(
                controller: _pageController,
                itemCount: bannerController.banners.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final banner = bannerController.banners[index];
                  return _buildSlide(
                    title: banner.title,
                    description: banner.description,
                    imageUrl: Urls.imageUrl + banner.image,
                    slideColor: _parseColor(banner.bannerColor.rectangleColor),
                    index: index,
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                bannerController.banners.length,
                (index) => _buildIndicator(index == _currentIndex),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSlide({
    required String title,
    required String description,
    required String imageUrl,
    required Color slideColor,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        _showBannerDetails(index);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: slideColor,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 13, bottom: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      title,
                      style: size14_M_bold(),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    description,
                    style: size12_M_regular(),
                  ),
                  const SizedBox(height: 3),
                  SizedBox(
                    height: 21,
                    width: 86,
                    child: ElevatedButton(
                      onPressed: () {
                        _showBannerDetails(index);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                      ),
                      child: Text(
                        "Order Now",
                        style: size10_M_bold(textColor: primaryOrange),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBannerDetails(int index) {
    final banner = bannerController.banners[index];

    productController.fetchProductById(banner.productId);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: true,
      builder: (BuildContext context) {
        return Obx(() {
          if (productController.isLoading.value) {
            return const SizedBox(
              height: 300,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (productController.errorMessage.isNotEmpty) {
            return Center(child: Text(productController.errorMessage.value));
          }

          if (productController.product.value == null) {
            return const Center(child: Text('No product available'));
          }

          final product = productController.product.value!;
          return CustomBottomSheet(
            initialFavorite: false,
            productId: product.id,
            description: product.description,
            price: product.inputPrice.toString(),
            rating: product.rating.toString(),
            image: Urls.imageUrl + product.image,
            productName: product.name,
          );
        });
      },
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive
            ? widget.activeIndicatorColor
            : widget.inactiveIndicatorColor,
        borderRadius: BorderRadius.circular(widget.buttonRadius),
      ),
    );
  }

  Color _parseColor(String hexColor) {
    return Color(int.parse('0xFF${hexColor.substring(1)}'));
  }
}
