class FaqContentModel {
  final bool success;
  final String message;
  final String data;

  FaqContentModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FaqContentModel.fromJson(Map<String, dynamic> json) {
    return FaqContentModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }
}
