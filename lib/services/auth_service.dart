import 'package:ksn_mobile_customer/model/otp_response_model.dart';
import 'package:ksn_mobile_customer/model/signup_update_model.dart';
import 'package:ksn_mobile_customer/network/api/api_client.dart';
import 'package:ksn_mobile_customer/network/api/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final DioClient _apiClient = DioClient();
  final DioClientWithToken _apiClientWithToken = DioClientWithToken();

  Future<OtpSendModel> sendOTP(String phoneNumber) async {
    final response = await _apiClient.post(ApiEndpoints.sendOtp, data: {
      'mobile': phoneNumber,
    });
    if (response.statusCode == 200) {
      return OtpSendModel.fromJson(response.data ?? {});
    } else {
      throw Exception(
          "Failed to send OTP. Status Code: ${response.statusCode}");
    }
  }

  Future<OtpVerifyModel> verifyOTP(String phoneNumber, String otpNumber) async {
    final response = await _apiClient.post(
      ApiEndpoints.verifyOtp,
      data: {'mobile': phoneNumber, 'otp': otpNumber},
    );
    if (response.statusCode == 200) {
      return OtpVerifyModel.fromJson(response.data ?? {});
    } else {
      throw Exception(
          "Failed to verify OTP. Status Code: ${response.statusCode}");
    }
  }

  Future<SignupUpdateModel> signUpUpdate(
      String phoneNumber, String email, String name) async {
    final response = await _apiClientWithToken.post(
      ApiEndpoints.profileUpdate,
      data: {'name': name, 'email': email, 'mobile': phoneNumber},
    );
    if (response.statusCode == 200) {
      return SignupUpdateModel.fromJson(response.data ?? {});
    } else {
      throw Exception("Failed to SignUp. Status Code: ${response.statusCode}");
    }
  }

  Future<bool> logOut() async {
    final response = await _apiClientWithToken.post(
      ApiEndpoints.logOut,
      data: {},
    );
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return true;
    } else {
      throw Exception("Failed to SignUp. Status Code: ${response.statusCode}");
    }
  }
}
