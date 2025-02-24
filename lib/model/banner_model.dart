import 'dart:convert';

class BannerModel {
  String id;
  String title;
  String image;
  String description;
  String productId;
  String type;
  String discount;
  DateTime expiryDate;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;
  BannerColor bannerColor;

  BannerModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.productId,
    required this.type,
    required this.discount,
    required this.expiryDate,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.bannerColor,
  });

  factory BannerModel.fromRawJson(String str) =>
      BannerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
        productId: json["product_id"],
        type: json["type"],
        discount: json["discount"],
        expiryDate: DateTime.parse(json["expiry_date"]),
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        bannerColor: BannerColor.fromJson(json["banner_color"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "description": description,
        "product_id": productId,
        "type": type,
        "discount": discount,
        "expiry_date":
            "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "banner_color": bannerColor.toJson(),
      };
}

class BannerColor {
  String vectorColor;
  String rectangleColor;

  BannerColor({
    required this.vectorColor,
    required this.rectangleColor,
  });

  factory BannerColor.fromRawJson(String str) =>
      BannerColor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BannerColor.fromJson(Map<String, dynamic> json) => BannerColor(
        vectorColor: json["vector_color"],
        rectangleColor: json["rectangle_color"],
      );

  Map<String, dynamic> toJson() => {
        "vector_color": vectorColor,
        "rectangle_color": rectangleColor,
      };
}
