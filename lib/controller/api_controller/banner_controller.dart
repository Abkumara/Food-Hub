import 'package:foods_hub/model/banner_model.dart';
import 'package:foods_hub/services/banner_service.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  var isLoading = false.obs;
  var banners = <BannerModel>[].obs;
  var errorMessage = ''.obs;

  final BannerService _bannerService = BannerService();

  Future<void> fetchBanners() async {
    isLoading(true);
    try {
      final fetchedBanner = await _bannerService.getBanners();
      banners.assignAll(fetchedBanner);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
