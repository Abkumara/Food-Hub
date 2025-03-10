import 'package:foods_hub/model/on_going_offer_model.dart';
import 'package:foods_hub/network/api/api_client.dart';
import 'package:foods_hub/network/api/api_endpoints.dart';

class OnGoingOfferService {
  final DioClientWithToken _apiClient = DioClientWithToken();

  Future<List<OnGoingOfferModel>> fetchOnGoingBanner() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.onGoingBanner);
      if (response.statusCode == 200 && response.data['success']) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => OnGoingOfferModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch banner");
      }
    } catch (e) {
      throw Exception("Error fetching banner: $e");
    }
  }
}
