import 'package:ksn_mobile_customer/model/cart_model.dart';
import 'package:ksn_mobile_customer/network/api/api_client.dart';
import 'package:ksn_mobile_customer/network/api/api_endpoints.dart';

class CartService {
  final DioClientWithToken _apiClient = DioClientWithToken();

  Future<CartModel> fetchViewCart() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.viewCart);
      if (response.statusCode == 200 && response.data['success']) {
        Map<String, dynamic> data = response.data['data'];
        return CartModel.fromJson(data);
      } else {
        throw Exception("Failed to fetch cart");
      }
    } catch (e) {
      throw Exception("Error fetching cart: $e");
    }
  }

  Future<AddCartModel> addCart(String id, int quantity) async {
    final response = await _apiClient.post(
      ApiEndpoints.addCart,
      data: {
        'product_id': id,
        'quantity': quantity,
      },
    );
    if (response.statusCode == 200) {
      return AddCartModel.fromJson(response.data ?? {});
    } else {
      throw Exception(
          "Failed to add cart. Status Code: ${response.statusCode}");
    }
  }

  Future<RemoveCartModel> removeCart(String id) async {
    final response = await _apiClient.post(
      ApiEndpoints.removeCart,
      data: {'cart_item_id': id},
    );
    if (response.statusCode == 200) {
      return RemoveCartModel.fromJson(response.data ?? {});
    } else {
      throw Exception(
          "Failed to remove cart. Status Code: ${response.statusCode}");
    }
  }
}
