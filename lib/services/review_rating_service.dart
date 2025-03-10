import 'package:foods_hub/model/review_rate_model.dart';
import 'package:foods_hub/network/api/api_client.dart';
import 'package:foods_hub/network/api/api_endpoints.dart';
import 'package:foods_hub/screen/ratings/thank_you_screen.dart';
import 'package:get/get.dart';

class ReviewRatingService {
  final DioClientWithToken _apiClient = DioClientWithToken();

  Future<List<ReviewModel>> fetchReview() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.review);
      if (response.statusCode == 200 && response.data['success']) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => ReviewModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch review");
      }
    } catch (e) {
      throw Exception("Error fetching review: $e");
    }
  }

  Future<void> addReview(OrderReviewRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.review,
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        Get.off(() => ThankYouScreen());
        Get.snackbar('Susses', 'Add review Successfully.');
      } else {
        throw Exception("Failed to add review");
      }
    } catch (e) {
      throw Exception("Error fetching review: $e");
    }
  }
}
