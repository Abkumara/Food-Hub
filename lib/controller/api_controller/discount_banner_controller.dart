import 'package:foods_hub/model/discount_banner_model.dart';
import 'package:foods_hub/services/discount_services.dart';
import 'package:get/get.dart';

class DiscountBannerController extends GetxController {
  var discount = <DiscountModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final DiscountService _offerService = DiscountService();

  Future<void> fetchDiscount() async {
    isLoading(true);
    try {
      final fetchedDiscount = await _offerService.fetchDiscount();
      discount.assignAll(fetchedDiscount);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
