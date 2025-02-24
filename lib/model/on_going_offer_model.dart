import 'dart:convert';

class OnGoingOfferModel {
  String image;
  String productId;
  String type;
  String discount;
  dynamic expiryDate;

  OnGoingOfferModel({
    required this.image,
    required this.productId,
    required this.type,
    required this.discount,
    required this.expiryDate,
  });

  factory OnGoingOfferModel.fromRawJson(String str) =>
      OnGoingOfferModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OnGoingOfferModel.fromJson(Map<String, dynamic> json) =>
      OnGoingOfferModel(
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
