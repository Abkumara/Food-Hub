import 'package:foods_hub/model/profile_info_model.dart';
import 'package:foods_hub/network/api/api_client.dart';
import 'package:foods_hub/network/api/api_endpoints.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  final DioClientWithToken apiClientWithToken = DioClientWithToken();
  var userProfile = UserProfile().obs;
  var isLoading = false.obs;
  Future<void> fetchUserProfile() async {
    try {
      isLoading(true);
      var response = await apiClientWithToken.get(ApiEndpoints.profileInfo);
      var jsonResponse = response.data;

      if (jsonResponse['success'] == true) {
        userProfile.value = UserProfile.fromJson(jsonResponse['data']);
      } else {
        throw Exception(
            "Failed to fetch user profile: ${jsonResponse['message']}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
