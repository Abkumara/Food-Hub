class SignupUpdateModel {
  final bool success;
  final String message;
  final UserData? data;

  SignupUpdateModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory SignupUpdateModel.fromJson(Map<String, dynamic> json) {
    return SignupUpdateModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String? googleId;
  final String? facebookId;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    this.googleId,
    this.facebookId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      googleId: json['google_id'],
      facebookId: json['facebook_id'],
    );
  }
}
