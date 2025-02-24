import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ksn_mobile_customer/controller/api_controller/category_controller.dart';
import 'package:ksn_mobile_customer/controller/api_controller/discount_banner_controller.dart';
import 'package:ksn_mobile_customer/controller/api_controller/on_going_offer_controller.dart';
import 'package:ksn_mobile_customer/controller/api_controller/product_controller.dart';
import 'package:ksn_mobile_customer/controller/api_controller/review_rating_controller.dart';
import 'package:ksn_mobile_customer/controller/api_controller/user_profile_controller.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/core/constant/urls.dart';
import 'package:ksn_mobile_customer/core/widgets/custome_search_bar.dart';
import 'package:ksn_mobile_customer/screens/home/home_page/widget/bottom_sheet.dart';
import 'package:ksn_mobile_customer/screens/home/home_page/widget/category_list.dart';
import 'package:ksn_mobile_customer/screens/home/home_page/widget/customer_rating_card.dart';
import 'package:ksn_mobile_customer/screens/home/home_page/widget/home_line.dart';
import 'package:ksn_mobile_customer/screens/home/home_page/widget/home_slider.dart';
import 'package:ksn_mobile_customer/screens/home/home_page/widget/items_layout.dart';
import 'package:ksn_mobile_customer/screens/home/home_page/widget/picks_grid_view.dart';
import 'package:ksn_mobile_customer/screens/home/home_page/widget/select_category_list.dart';
import 'package:ksn_mobile_customer/screens/my_account/my_account_screen.dart';
import 'package:ksn_mobile_customer/screens/my_account/my_address_screen.dart';
import 'package:ksn_mobile_customer/screens/tab_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController _productController = Get.put(ProductController());
  final CategoryController _categoryController = Get.put(CategoryController());
  final ReviewRatingController _reviewRatingController =
      Get.put(ReviewRatingController());
  final OnGoingOfferController _onGoingOfferController =
      Get.put(OnGoingOfferController());
  final DiscountBannerController _discountBannerController =
      Get.put(DiscountBannerController());

  int _selectedIndex = -1;
  bool isBreakfast = false;
  String selectedCategoryName = "";

  late final List<String> animatedHints;
  late int currentHintIndex;
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

  final List<String> categories = [
    "Breakfast",
    "Lunch",
    "Sweets",
    "Snacks",
    "Dinner",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productController.fetchTopProducts();
      _productController.fetchPastOrderProducts();
      _productController.fetchProducts();
      _categoryController.fetchCategories();
      _reviewRatingController.fetchReview();
      _onGoingOfferController.fetchOnGoingBanner();
      _discountBannerController.fetchDiscount();
    });

    animatedHints = ['"Biriyani"', '"Punagu"', '"Dosa"'];
    currentHintIndex = 0;
    Future.delayed(Duration.zero, cycleHints);

    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });

    userProfileController.fetchUserProfile();
  }

  void cycleHints() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && !_isSearchFocused) {
        setState(() {
          currentHintIndex = (currentHintIndex + 1) % animatedHints.length;
        });
        cycleHints();
      }
    });
  }

  final TextEditingController _searchController = TextEditingController();
  RxString searchQuery = ''.obs;

  void filterProducts(String query) {
    searchQuery.value = query.toLowerCase();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 80),
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          automaticallyImplyLeading: false,
          title: _buildTitleSection(),
          bottom: _buildSearchSection(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_isSearchFocused) ...[
              const SizedBox(height: 14),
              _buildProductList(),
            ] else ...[
              const SizedBox(height: 14),
              const HomeSliderView(
                activeIndicatorColor: titleColor,
                inactiveIndicatorColor: bannerDot,
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategoriesTitle(),
                    const SizedBox(height: 15),
                    _buildCategoriesButtons(),
                    const SizedBox(height: 49),
                    if (!isBreakfast) _buildCategoryList(),
                    if (isBreakfast) _buildSelectedCategoryList(),
                    const SizedBox(height: 20),
                    if (!isBreakfast) _buildTopItemsSection(),
                    const SizedBox(height: 102),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAddressInfo(),
            _buildProfileIcon(),
          ],
        ),
      ],
    );
  }

  Widget _buildAddressInfo() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyAddressScreen(),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/navigation.svg',
                width: 16,
                height: 16,
              ),
              const SizedBox(width: 5),
              Text(
                "Jubilee Hilss",
                style: size16_M_bold(textColor: titleColor),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            "Nandhini Enclave, Road no 4 , Madhapur...",
            style: size12_M_regular(textColor: addressColor),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileIcon() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyAccountScreen()),
        );
      },
      child: SizedBox(
        width: 34,
        height: 34,
        child: Obx(() {
          final user = userProfileController.userProfile.value;
          final firstLetter = (user.name?.isNotEmpty ?? false)
              ? user.name!.substring(0, 1).toUpperCase()
              : '';
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xff5F5F5F),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              firstLetter,
              style: size16_M_regular(),
            ),
          );
        }),
      ),
    );
  }

  PreferredSizeWidget _buildSearchSection() {
    return PreferredSize(
      preferredSize: const Size(0, 0),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: Stack(
          children: [
            SearchInputField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              suffixIcon: Image.asset('assets/icons/search.png'),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a search query';
                }
                return null;
              },
              onChanged: (query) {
                searchQuery.value = query.toLowerCase().trim();
              },
            ),
            if (!_isSearchFocused) _buildAnimatedHint(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedHint() {
    return Positioned(
      left: 16,
      top: 12,
      child: Row(
        children: [
          Text(
            'Search for ',
            style: size16_M_regular(textColor: navTextColor)
                .copyWith(fontSize: 15),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> anim) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: const Offset(0, 0),
                ).animate(anim),
                child: FadeTransition(opacity: anim, child: child),
              );
            },
            child: Text(
              animatedHints[currentHintIndex],
              key: ValueKey(currentHintIndex),
              style: size16_M_regular(textColor: navTextColor)
                  .copyWith(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTitle() {
    return Row(
      children: [
        Text(
          selectedCategoryName.isEmpty
              ? 'Categories'
              : categories[_selectedIndex],
          style: size12_M_medium(textColor: titleColor),
        ),
        const SizedBox(width: 12),
        const Expanded(child: HomeLine()),
      ],
    );
  }

  Widget _buildCategoriesButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(categories.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 2),
          child: SizedBox(
            width: 53,
            height: 27,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = index;
                  isBreakfast = true;
                  selectedCategoryName = categories[index];
                  _categoryController.fetchProductsByCategory(
                      _categoryController.categories[_selectedIndex].id);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedIndex == index
                    ? primaryOrange
                    : const Color(0xFFC4E1CC),
                foregroundColor: _selectedIndex == index
                    ? const Color(0xFFC4E1CC)
                    : Colors.black,
                shadowColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.fromLTRB(3, 4.54, 3, 4.54),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: size10_M_regular(
                    textColor:
                        _selectedIndex == index ? colorWhite : blackType1,
                  ).copyWith(fontSize: 9),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCategoryList() {
    return CategoryList(
      onPressed: (int index) {
        setState(() {
          _selectedIndex = index;
          isBreakfast = true;
          selectedCategoryName = categories[index];
          _categoryController.fetchProductsByCategory(
              _categoryController.categories[_selectedIndex].id);
        });
      },
    );
  }

  Widget _buildSelectedCategoryList() {
    return SelectCategoryList(
      id: _categoryController.categories[_selectedIndex].id,
    );
  }

  Widget _buildProductList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (_productController.isLoadingTopProducts.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (_productController.errorMessage.isNotEmpty) {
              return Center(
                child: Text(
                  _productController.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            final filteredProducts = _productController.productList
                .where((product) =>
                    product.name.toLowerCase().contains(searchQuery.value))
                .toList();

            if (filteredProducts.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.6, // Adjust height to center
                child: const Center(
                  child: Text(
                    "No products found.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index != filteredProducts.length - 1 ? 20 : 0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        enableDrag: false,
                        isDismissible: true,
                        builder: (BuildContext context) {
                          return CustomBottomSheet(
                            initialFavorite: false,
                            productId: product.id,
                            description: product.description.toString(),
                            price: product.inputPrice.toString(),
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
                      rating: product.ratingCount.toString(),
                      image: Urls.imageUrl + product.image,
                      address: "100 Feet Road, Madhapur, Hyderabad",
                      initialFavorite: false,
                      price: product.inputPrice.toString(),
                      productId: product.id,
                    ),
                  ),
                );
              },
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTopItemsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top items to explore',
          style: size16_M_bold(textColor: titleColor),
        ),
        const SizedBox(height: 15),
        Obx(() {
          if (_productController.isLoadingTopProducts.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_productController.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                _productController.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (_productController.productTopList.isEmpty) {
            return const Center(child: Text("Your product is empty."));
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _productController.productTopList.length,
            itemBuilder: (context, index) {
              final product = _productController.productTopList[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index != _productController.productTopList.length - 1
                      ? 20
                      : 0,
                ),
                child: GestureDetector(
                  onTap: () {
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
                    initialFavorite: false,
                    price: product.price.toString(),
                    productId: product.id,
                  ),
                ),
              );
            },
          );
        }),
        const SizedBox(height: 20),
        _buildPicksSection(),
        const SizedBox(height: 30),
        _buildOffersSection(),
        const SizedBox(height: 20),
        _buildDiscountsSection(),
        const SizedBox(height: 30),
        _buildCustomerReviewsSection(),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: size12_M_medium(textColor: titleColor),
        ),
        const SizedBox(width: 12),
        const Expanded(child: HomeLine()),
      ],
    );
  }

  Widget _buildPicksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('YOUR TRUSTED PICKS'),
        const SizedBox(height: 12),
        SizedBox(
          height: 30,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TabScreen(index: 2)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: titleColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5.4),
            ),
            child: Text(
              "Reorder",
              style: size12_M_medium(textColor: backgroundWhite),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (_productController.isLoadingPastOrders.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_productController.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                _productController.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (_productController.pastOrderList.isEmpty) {
            return const Center(
                child: Text("Your past order product is empty."));
          }
          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 9,
              mainAxisSpacing: 16,
              childAspectRatio: 0.5,
            ),
            itemCount: _productController.pastOrderList.length,
            itemBuilder: (context, index) {
              final pastOrderProduct = _productController.pastOrderList[index];
              return Picks(
                image: Urls.imageUrl + pastOrderProduct.image,
                itemName: pastOrderProduct.name,
                rating: pastOrderProduct.rating,
                price: pastOrderProduct.discountPrice.toString(),
                initialFavorite: false,
                productId: pastOrderProduct.id,
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildOffersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('ON GOING OFFERS'),
        const SizedBox(height: 25),
        Obx(
          () {
            if (_onGoingOfferController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (_onGoingOfferController.errorMessage.isNotEmpty) {
              return Center(
                child: Text(
                  _onGoingOfferController.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            if (_onGoingOfferController.offer.isEmpty) {
              return const Center(child: Text("Your offer banner is empty."));
            }
            return SizedBox(
              height: 125,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _onGoingOfferController.offer.length,
                itemBuilder: (context, index) {
                  final String imageUrl =
                      _onGoingOfferController.offer[index].image;
                  final String fullImageUrl = Urls.imageUrl + imageUrl;

                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        enableDrag: false,
                        isDismissible: true,
                        builder: (BuildContext context) {
                          return Obx(() {
                            if (_productController.isLoading.value) {
                              return const SizedBox(
                                height: 300,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }

                            if (_productController.errorMessage.isNotEmpty) {
                              return Center(
                                  child: Text(
                                      _productController.errorMessage.value));
                            }

                            if (_productController.product.value == null) {
                              return const Center(
                                  child: Text('No product available'));
                            }

                            final product = _productController.product.value!;
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
                    },
                    child: Image.network(
                      fullImageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
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
                        return const Center(
                            child: Text('Failed to load image'));
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDiscountsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('DISCOUNTS'),
        const SizedBox(height: 25),
        Obx(
          () {
            if (_discountBannerController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (_discountBannerController.errorMessage.isNotEmpty) {
              return Center(
                child: Text(
                  _discountBannerController.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            if (_discountBannerController.discount.isEmpty) {
              return const Center(
                  child: Text("Your discount banner is empty."));
            }
            return SizedBox(
              height: 125,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _discountBannerController.discount.length,
                itemBuilder: (context, index) {
                  final String imageUrl =
                      _discountBannerController.discount[index].image;
                  final String fullImageUrl = Urls.imageUrl + imageUrl;

                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        enableDrag: false,
                        isDismissible: true,
                        builder: (BuildContext context) {
                          return Obx(() {
                            if (_productController.isLoading.value) {
                              return const SizedBox(
                                height: 300,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }

                            if (_productController.errorMessage.isNotEmpty) {
                              return Center(
                                  child: Text(
                                      _productController.errorMessage.value));
                            }

                            if (_productController.product.value == null) {
                              return const Center(
                                  child: Text('No product available'));
                            }

                            final product = _productController.product.value!;
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
                    },
                    child: Image.network(
                      fullImageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
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
                        return const Center(
                            child: Text('Failed to load image'));
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCustomerReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('CUSTOMERS REVIEWS'),
        const SizedBox(height: 25),
        Obx(() {
          if (_reviewRatingController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_reviewRatingController.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                _reviewRatingController.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (_reviewRatingController.reviewList.isEmpty) {
            return const Center(child: Text("Your review is empty."));
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _reviewRatingController.reviewList.length,
            itemBuilder: (context, index) {
              final review = _reviewRatingController.reviewList[index];
              return Padding(
                padding: EdgeInsets.only(bottom: index != 1 ? 30 : 0),
                child: CustomerReviewCard(
                  userName: review.customer.name,
                  rating: review.rating,
                  message: review.review,
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
