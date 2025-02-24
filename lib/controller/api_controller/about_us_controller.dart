import 'package:foods_hub/model/static_model.dart';
import 'package:foods_hub/network/api/api_client.dart';
import 'package:foods_hub/network/api/api_endpoints.dart';
import 'package:get/get.dart';

class AboutUsController extends GetxController {
  final DioClient apiClientWithToken = DioClient();

  var faqContent = FaqContentModel(success: false, message: '', data: '').obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchAboutUsContent();
    super.onInit();
  }

  Future<void> fetchAboutUsContent() async {
    try {
      isLoading(true);
      var response = await apiClientWithToken.get(ApiEndpoints.aboutUs);
      var jsonResponse = response.data;

      if (jsonResponse['success'] == true) {
        faqContent.value = FaqContentModel.fromJson(jsonResponse);
      } else {
        throw Exception("Failed to fetch FAQ: ${jsonResponse['message']}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
