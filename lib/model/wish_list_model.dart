import 'dart:convert';

class WishListModel {
  String id;
  String productId;
  Product product;

  WishListModel({
    required this.id,
    required this.productId,
    required this.product,
  });

  factory WishListModel.fromRawJson(String str) =>
      WishListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
        id: json["id"],
        productId: json["product_id"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product": product.toJson(),
      };
}

class Product {
  String id;
  String name;
  String image;
  String description;
  String categoryId;
  int rating;
  dynamic ratingCount;
  String time;
  int price;
  String address;
  bool isDeliveryFree;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.categoryId,
    required this.rating,
    required this.ratingCount,
    required this.time,
    required this.price,
    required this.address,
    required this.isDeliveryFree,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        categoryId: json["category_id"],
        rating: json["rating"],
        ratingCount: json["rating_count"],
        time: json["time"],
        price: json["price"],
        address: json["address"],
        isDeliveryFree: json["is_delivery_free"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "category_id": categoryId,
        "rating": rating,
        "rating_count": ratingCount,
        "time": time,
        "price": price,
        "address": address,
        "is_delivery_free": isDeliveryFree,
      };
}

class AddWishListModel {
  String? productId;

  AddWishListModel({
    this.productId,
  });

  factory AddWishListModel.fromRawJson(String str) =>
      AddWishListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddWishListModel.fromJson(Map<String, dynamic> json) =>
      AddWishListModel(
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
      };
}

class RemoveWishListModel {
  String? productId;

  RemoveWishListModel({
    this.productId,
  });

  factory RemoveWishListModel.fromRawJson(String str) =>
      RemoveWishListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RemoveWishListModel.fromJson(Map<String, dynamic> json) =>
      RemoveWishListModel(
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
      };
}
