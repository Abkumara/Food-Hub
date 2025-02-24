import 'package:ksn_mobile_customer/model/category_model.dart';
import 'package:ksn_mobile_customer/network/api/api_client.dart';
import 'package:ksn_mobile_customer/network/api/api_endpoints.dart';

class CategoryService {
  final DioClientWithToken _apiClient = DioClientWithToken();

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.categories);
      if (response.statusCode == 200 && response.data['success']) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch categories");
      }
    } catch (e) {
      throw Exception("Error fetching categories: $e");
    }
  }

  Future<ProductByCategoryModel> fetchProductsByCategory(String categoryId,
      {String query = ""}) async {
    try {
      final response = await _apiClient.get(
        "${ApiEndpoints.productByCategory}/$categoryId",
        queryParameters: query.isNotEmpty ? {"search": query} : null,
      );

      if (response.statusCode == 200 && response.data['success']) {
        print("API data: ${response.data['data']}");
        if (response.data['data'] == null) {
          throw Exception("Data is null");
        }
        return ProductByCategoryModel.fromJson(response.data['data']);
      } else {
        throw Exception("Failed to fetch products for category: $categoryId");
      }
    } catch (e) {
      throw Exception("Error fetching products by category: $e");
    }
  }
}
