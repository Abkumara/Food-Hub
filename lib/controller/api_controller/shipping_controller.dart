import 'package:foods_hub/model/static_model.dart';
import 'package:foods_hub/network/api/api_client.dart';
import 'package:foods_hub/network/api/api_endpoints.dart';
import 'package:get/get.dart';

class ShippingController extends GetxController {
  final DioClient apiClientWithToken = DioClient();

  var faqContent = FaqContentModel(success: false, message: '', data: '').obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchShippingContent();
    super.onInit();
  }

  Future<void> fetchShippingContent() async {
    try {
      isLoading(true);
      var response = await apiClientWithToken.get(ApiEndpoints.shippingPolicy);
      var jsonResponse = response.data;

      if (jsonResponse['success'] == true) {
        faqContent.value = FaqContentModel.fromJson(jsonResponse);
      } else {
        throw Exception(
            "Failed to fetch ShippingPOlicy: ${jsonResponse['message']}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
