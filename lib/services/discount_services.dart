import 'package:foods_hub/model/discount_banner_model.dart';
import 'package:foods_hub/network/api/api_client.dart';
import 'package:foods_hub/network/api/api_endpoints.dart';

class DiscountService {
  final DioClientWithToken _apiClient = DioClientWithToken();

  Future<List<DiscountModel>> fetchDiscount() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.discountBanner);
      if (response.statusCode == 200 && response.data['success']) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => DiscountModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch discount banner");
      }
    } catch (e) {
      throw Exception("Error fetching discount banner: $e");
    }
  }
}
