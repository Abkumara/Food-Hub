class OtpSendModel {
  final String message;
  final bool otpSuccess;

  final String data;

  OtpSendModel(
      {required this.message, required this.otpSuccess, required this.data});

  factory OtpSendModel.fromJson(Map<String, dynamic> json) {
    return OtpSendModel(
      message: json['message'] ?? '',
      otpSuccess: json['success'],
      data: json['data'] ?? '',
    );
  }
}

class OtpVerifyModel {
  final String message;
  final bool otpVerifySuccess;
  final String bearerToken;

  OtpVerifyModel(
      {required this.message,
      required this.otpVerifySuccess,
      required this.bearerToken});

  factory OtpVerifyModel.fromJson(Map<String, dynamic> json) {
    return OtpVerifyModel(
      message: json['message'] ?? '',
      otpVerifySuccess: json['success'],
      bearerToken: json['data']['token'] ?? '',
    );
  }
}
