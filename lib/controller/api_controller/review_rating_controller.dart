import 'package:foods_hub/model/review_rate_model.dart';
import 'package:foods_hub/services/review_rating_service.dart';
import 'package:get/get.dart';

class ReviewRatingController extends GetxController {
  var reviewList = <ReviewModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var reviewResponse = Rxn<OrderReviewResponse>();
  final ReviewRatingService _reviewRatingService = ReviewRatingService();

  Future<void> fetchReview() async {
    isLoading(true);
    try {
      final fetchedList = await _reviewRatingService.fetchReview();
      reviewList.assignAll(fetchedList);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<void> addReview(OrderReviewRequest request) async {
    isLoading(true);
    try {
      await _reviewRatingService.addReview(request);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
