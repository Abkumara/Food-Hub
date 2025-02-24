import 'package:ksn_mobile_customer/model/banner_model.dart';
import 'package:ksn_mobile_customer/network/api/api_client.dart';
import 'package:ksn_mobile_customer/network/api/api_endpoints.dart';

class BannerService {
  final DioClientWithToken _apiClient = DioClientWithToken();

  Future<List<BannerModel>> getBanners() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.banners);
      if (response.statusCode == 200 && response.data['success']) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => BannerModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch banners");
      }
    } catch (e) {
      throw Exception("Error fetching banners: $e");
    }
  }
}
