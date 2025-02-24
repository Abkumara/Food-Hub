import 'package:foods_hub/model/contact_us_model.dart';
import 'package:foods_hub/services/contact_us_service.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  var contactus = <ContactRequest>[].obs; // Observable list of locations
  var isLoading = false.obs; // Loading state for UI
  var errorMessage = ''.obs; // To hold error messages

  final ContactUsService _contactUsService = ContactUsService();

  // Add a new location
  Future<void> addCustomerDetails(ContactRequest request) async {
    isLoading(true); // Show loading spinner
    try {
      await _contactUsService.addCustomerDetail(request);
    } catch (e) {
      errorMessage.value = e.toString(); // Set error message
    } finally {
      isLoading(false); // Hide loading spinner
    }
  }
}
