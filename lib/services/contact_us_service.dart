import 'package:foods_hub/model/contact_us_model.dart';
import 'package:foods_hub/network/api/api_client.dart';
import 'package:foods_hub/network/api/api_endpoints.dart';
import 'package:get/get.dart';

class ContactUsService {
  final DioClientWithToken _apiClient = DioClientWithToken();

  Future<void> addCustomerDetail(ContactRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.contactUs,
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        Get.snackbar('Sucsses', 'Thank you for contacting us!');
      } else {
        throw Exception("Failed to add Contact us");
      }
    } catch (e) {
      throw Exception("Error adding Contact us: $e");
    }
  }
}
