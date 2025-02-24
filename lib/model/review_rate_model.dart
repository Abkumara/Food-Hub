import 'dart:convert';

// Model for the POST request body
class OrderReviewRequest {
  final String orderId;
  final int rating;
  final String review;

  OrderReviewRequest({
    required this.orderId,
    required this.rating,
    required this.review,
  });

  Map<String, dynamic> toJson() {
    return {
      "order_id": orderId,
      "rating": rating,
      "review": review,
    };
  }

  String toRawJson() => json.encode(toJson());
}

// Model for the POST response body
class OrderReviewResponse {
  final String message;
  final Map<String, List<String>> errors;

  OrderReviewResponse({
    required this.message,
    required this.errors,
  });

  factory OrderReviewResponse.fromJson(Map<String, dynamic> json) {
    return OrderReviewResponse(
      message: json["message"],
      errors: (json["errors"] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, List<String>.from(value)),
      ),
    );
  }

  factory OrderReviewResponse.fromRawJson(String str) =>
      OrderReviewResponse.fromJson(json.decode(str));
}

class ReviewModel {
  String id;
  int customerId;
  String orderId;
  DateTime date;
  int rating;
  String review;
  Customer customer;

  ReviewModel({
    required this.id,
    required this.customerId,
    required this.orderId,
    required this.date,
    required this.rating,
    required this.review,
    required this.customer,
  });

  factory ReviewModel.fromRawJson(String str) =>
      ReviewModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json["id"],
        customerId: json["customer_id"],
        orderId: json["order_id"],
        date: DateTime.parse(json["date"]),
        rating: json["rating"],
        review: json["review"],
        customer: Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "order_id": orderId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "rating": rating,
        "review": review,
        "customer": customer.toJson(),
      };
}

class Customer {
  int id;
  String name;
  dynamic avatar;
  String email;
  String mobile;

  Customer({
    required this.id,
    required this.name,
    required this.avatar,
    required this.email,
    required this.mobile,
  });

  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        email: json["email"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "email": email,
        "mobile": mobile,
      };
}
