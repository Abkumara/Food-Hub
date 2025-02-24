class UserProfile {
  final int? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? avatar;
  final String? googleId;
  final String? facebookId;
  final int? isActive;

  UserProfile({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.avatar,
    this.googleId,
    this.facebookId,
    this.isActive,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      avatar: json['avatar'] as String?,
      googleId: json['google_id'] as String?,
      facebookId: json['facebook_id'] as String?,
      isActive: json['is_active'] as int?,
    );
  }
}
