import 'dart:convert';

class DiscountModel {
  String image;
  String productId;
  String type;
  String discount;
  dynamic expiryDate;

  DiscountModel({
    required this.image,
    required this.productId,
    required this.type,
    required this.discount,
    required this.expiryDate,
  });

  factory DiscountModel.fromRawJson(String str) =>
      DiscountModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiscountModel.fromJson(Map<String, dynamic> json) => DiscountModel(
        image: json["image"],
        productId: json["product_id"],
        type: json["type"],
        discount: json["discount"],
        expiryDate: json["expiry_date"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "product_id": productId,
        "type": type,
        "discount": discount,
        "expiry_date": expiryDate,
      };
}
