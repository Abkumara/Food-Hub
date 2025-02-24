import 'package:foods_hub/model/wish_list_model.dart';
import 'package:foods_hub/services/wish_list_service.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  var isLoading = false.obs;
  var wishList = <WishListModel>[].obs;
  var errorMessage = ''.obs;

  final WishListService _wishListService = WishListService();

  Future<void> fetchWishList() async {
    isLoading(true);
    try {
      final fetchedList = await _wishListService.fetchWishList();
      wishList.assignAll(fetchedList);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  var addWishListResponse = AddWishListModel(
    productId: '',
  ).obs;

  Future<void> addProductToWishList(String productId) async {
    try {
      isLoading.value = true;
      final response = await _wishListService.addWishList(productId);
      addWishListResponse.value = response;
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = "Failed to add to wishlist: $e";
    } finally {
      isLoading.value = false;
    }
  }

  var removeWishListResponse = RemoveWishListModel(
    productId: '',
  ).obs;

  Future<void> removeProductToWishList(String productId) async {
    try {
      isLoading.value = true;
      final response = await _wishListService.removeWishList(productId);
      removeWishListResponse.value = response;
      errorMessage.value = '';
      fetchWishList();
    } catch (e) {
      errorMessage.value = "Failed to remove to wishlist: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
