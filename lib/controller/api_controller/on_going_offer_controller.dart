import 'package:foods_hub/model/on_going_offer_model.dart';
import 'package:foods_hub/services/on_going_offer_services.dart';
import 'package:get/get.dart';

class OnGoingOfferController extends GetxController {
  var offer = <OnGoingOfferModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final OnGoingOfferService _offerService = OnGoingOfferService();

  Future<void> fetchOnGoingBanner() async {
    isLoading(true);
    try {
      final fetchedOffer = await _offerService.fetchOnGoingBanner();
      offer.assignAll(fetchedOffer);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
