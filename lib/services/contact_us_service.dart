import 'package:get/get.dart';
import 'package:ksn_mobile_customer/model/contact_us_model.dart';
import 'package:ksn_mobile_customer/network/api/api_client.dart';
import 'package:ksn_mobile_customer/network/api/api_endpoints.dart';

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
