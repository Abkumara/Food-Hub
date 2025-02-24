import 'package:foods_hub/model/cart_model.dart';
import 'package:foods_hub/services/cart_service.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var isLoading = false.obs;
  var cart = Rxn<CartModel>();
  var errorMessage = ''.obs;

  final CartService _cartService = CartService();

  Future<void> fetchViewCart() async {
    isLoading(true);
    try {
      final fetchedCart = await _cartService.fetchViewCart();
      cart.value = fetchedCart;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  var addCartResponse = AddCartModel(
    productId: '',
    quantity: 4,
  ).obs;

  Future<void> addCart(String productId, int quantity) async {
    try {
      isLoading.value = true;
      final response = await _cartService.addCart(productId, quantity);
      addCartResponse.value = response;
      errorMessage.value = '';
      fetchViewCart();
    } catch (e) {
      errorMessage.value = "Failed to add to cart: $e";
    } finally {
      isLoading.value = false;
    }
  }

  var removeCartResponse = RemoveCartModel(
    cartItemId: '',
  ).obs;

  Future<void> removeCart(String cartId) async {
    try {
      isLoading.value = true;
      final response = await _cartService.removeCart(cartId);
      removeCartResponse.value = response;
      errorMessage.value = '';
      fetchViewCart();
    } catch (e) {
      errorMessage.value = "Failed to remove to cart: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
