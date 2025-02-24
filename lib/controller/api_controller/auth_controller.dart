import 'package:flutter/material.dart';
import 'package:foods_hub/model/otp_response_model.dart';
import 'package:foods_hub/model/signup_update_model.dart';
import 'package:foods_hub/screen/auth/location_screen.dart';
import 'package:foods_hub/screen/auth/login_page.dart';
import 'package:foods_hub/screen/auth/sign_up_screen.dart';
import 'package:foods_hub/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  var isLoading = false.obs;
  var otpSendResponse = Rxn<OtpSendModel>();
  var otpVerifyResponse = Rxn<OtpVerifyModel>();
  var signupResponse = Rxn<SignupUpdateModel>();
  var errorMessage = ''.obs;
  var profile = Rxn<SignupUpdateModel>();
  Future<void> sendOtp(String phoneNumber) async {
    try {
      isLoading.value = true;
      final response = await _authService.sendOTP(phoneNumber);
      otpSendResponse.value = response;

      if (response.otpSuccess) {
        Get.snackbar("Success", response.message);
      } else {
        Get.snackbar("Error", response.message);
        print(response.message);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to send OTP: $e");
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOTP(
      String phoneNumber, String otpNumber, BuildContext context) async {
    try {
      isLoading.value = true;
      final response = await _authService.verifyOTP(phoneNumber, otpNumber);
      otpVerifyResponse.value = response;

      if (response.otpVerifySuccess) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('bearer_token', response.bearerToken);
        await preferences.setBool('isLoggedIn', true);
        print(response.bearerToken);
        Get.snackbar("Success", response.message);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpPage(
                mobileNumber: phoneNumber,
              ),
            ));
      } else {
        Get.snackbar("Error", response.message);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to verify OTP: $e");
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUpUpdate(
    String phoneNumber,
    String email,
    String name,
    bool check,
  ) async {
    try {
      isLoading.value = true;
      final response =
          await _authService.signUpUpdate(phoneNumber, email, name);
      signupResponse.value = response;

      if (response.success) {
        Get.snackbar("Success", response.message);
        if (check) Get.offAll(() => LocationScreen());
      } else {
        Get.snackbar("Error", response.message);
        print(response.message);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to send OTP: $e");
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logOut(BuildContext context) async {
    try {
      isLoading.value = true;
      bool success = await _authService.logOut();

      if (success) {
        Get.snackbar("Success", 'Logged Out Succsessfully');
        Get.offAll(() => LoginPage());
      } else {
        Get.snackbar("Error", "Failed to log out. Please try again.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to Logout: $e");
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
