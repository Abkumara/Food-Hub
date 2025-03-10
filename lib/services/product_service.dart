import 'package:foods_hub/model/product_model.dart';
import 'package:foods_hub/network/api/api_client.dart';
import 'package:foods_hub/network/api/api_endpoints.dart';

class ProductService {
  final DioClientWithToken _apiClient = DioClientWithToken();

  // Fetch product list
  Future<List<ProductListModel>> fetchProducts() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.productList);
      if (response.statusCode == 200 && response.data['success'] == true) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => ProductListModel.fromJson(json)).toList();
      } else {
        throw Exception(response.data['message'] ?? "Failed to fetch products");
      }
    } catch (e) {
      throw Exception("Error fetching products: ${e.toString()}");
    }
  }

  // Fetch top products
  Future<List<TopProductModel>> fetchTopProducts() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.topProduct);
      if (response.statusCode == 200 && response.data['success'] == true) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => TopProductModel.fromJson(json)).toList();
      } else {
        throw Exception(
            response.data['message'] ?? "Failed to fetch top products");
      }
    } catch (e) {
      throw Exception("Error fetching top products: ${e.toString()}");
    }
  }

  // Fetch past order products
  Future<List<PastOrderProductModel>> fetchPastOrderProducts() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.pastOrderProduct);
      if (response.statusCode == 200 && response.data['success'] == true) {
        List<dynamic> data = response.data['data'];
        return data
            .map((json) => PastOrderProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            response.data['message'] ?? "Failed to fetch past order products");
      }
    } catch (e) {
      throw Exception("Error fetching past order products: ${e.toString()}");
    }
  }

  Future<ProductIdModel> fetchProductById(String productId) async {
    try {
      final response =
          await _apiClient.get("${ApiEndpoints.productById}/$productId");

      if (response.statusCode == 200 && response.data['success'] == true) {
        return ProductIdModel.fromJson(response.data['data']);
      } else {
        throw Exception(
            response.data['message'] ?? "Failed to fetch product details");
      }
    } catch (e) {
      throw Exception("Error fetching product details: ${e.toString()}");
    }
  }
}
