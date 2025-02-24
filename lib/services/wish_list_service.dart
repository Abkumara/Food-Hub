import 'package:ksn_mobile_customer/model/wish_list_model.dart';
import 'package:ksn_mobile_customer/network/api/api_client.dart';
import 'package:ksn_mobile_customer/network/api/api_endpoints.dart';

class WishListService {
  final DioClientWithToken _apiClient = DioClientWithToken();

  Future<List<WishListModel>> fetchWishList() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.wishList);
      if (response.statusCode == 200 && response.data['success']) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => WishListModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch wishlist");
      }
    } catch (e) {
      throw Exception("Error fetching wishlist: $e");
    }
  }

  Future<AddWishListModel> addWishList(String id) async {
    final response = await _apiClient.post(
      ApiEndpoints.addWishList,
      data: {'product_id': id},
    );
    if (response.statusCode == 200) {
      return AddWishListModel.fromJson(response.data ?? {});
    } else {
      throw Exception(
          "Failed to add wishlist. Status Code: ${response.statusCode}");
    }
  }

  Future<RemoveWishListModel> removeWishList(String id) async {
    final response = await _apiClient.delete(
      ApiEndpoints.removeWishList,
      data: {'product_id': id},
    );
    if (response.statusCode == 200) {
      return RemoveWishListModel.fromJson(response.data ?? {});
    } else {
      throw Exception(
          "Failed to remove wishlist. Status Code: ${response.statusCode}");
    }
  }
}
