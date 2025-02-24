import 'dart:convert';

class ProductListModel {
  String id;
  String name;
  String slug;
  String image;
  Description description;
  String categoryId;
  dynamic stockCutoffDay;
  int order;
  int rating;
  int ratingCount;
  int inputPrice;
  double discountPrice;
  List<dynamic> subProducts;

  ProductListModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.description,
    required this.categoryId,
    required this.stockCutoffDay,
    required this.order,
    required this.rating,
    required this.ratingCount,
    required this.inputPrice,
    required this.discountPrice,
    required this.subProducts,
  });

  factory ProductListModel.fromRawJson(String str) =>
      ProductListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        description: descriptionValues.map[json["description"]]!,
        categoryId: json["category_id"],
        stockCutoffDay: json["stock_cutoff_day"],
        order: json["order"],
        rating: json["rating"],
        ratingCount: json["rating_count"],
        inputPrice: json["input_price"],
        discountPrice: json["discount_price"]?.toDouble(),
        subProducts: List<dynamic>.from(json["sub_products"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "description": descriptionValues.reverse[description],
        "category_id": categoryId,
        "stock_cutoff_day": stockCutoffDay,
        "order": order,
        "rating": rating,
        "rating_count": ratingCount,
        "input_price": inputPrice,
        "discount_price": discountPrice,
        "sub_products": List<dynamic>.from(subProducts.map((x) => x)),
      };
}

enum Description { DEFAULT_PRODUCT_DESCRIPTION }

final descriptionValues = EnumValues(
    {"Default product description": Description.DEFAULT_PRODUCT_DESCRIPTION});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class TopProductModel {
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

  TopProductModel({
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

  factory TopProductModel.fromRawJson(String str) =>
      TopProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopProductModel.fromJson(Map<String, dynamic> json) =>
      TopProductModel(
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

class PastOrderProductModel {
  String id;
  String name;
  String slug;
  String image;
  String description;
  String categoryId;
  int order;
  String inputPrice;
  int discountPrice;
  double rating;

  PastOrderProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.description,
    required this.categoryId,
    required this.order,
    required this.inputPrice,
    required this.discountPrice,
    required this.rating,
  });

  factory PastOrderProductModel.fromRawJson(String str) =>
      PastOrderProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PastOrderProductModel.fromJson(Map<String, dynamic> json) =>
      PastOrderProductModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        description: json["description"],
        categoryId: json["category_id"],
        order: json["order"],
        inputPrice: json["input_price"],
        discountPrice: json["discount_price"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "description": description,
        "category_id": categoryId,
        "order": order,
        "input_price": inputPrice,
        "discount_price": discountPrice,
        "rating": rating,
      };
}

class ProductIdModel {
    String id;
    String name;
    String slug;
    String image;
    String description;
    String categoryId;
    dynamic stockCutoffDay;
    int order;
    int rating;
    int ratingCount;
    int inputPrice;
    double discountPrice;

    ProductIdModel({
        required this.id,
        required this.name,
        required this.slug,
        required this.image,
        required this.description,
        required this.categoryId,
        required this.stockCutoffDay,
        required this.order,
        required this.rating,
        required this.ratingCount,
        required this.inputPrice,
        required this.discountPrice,
    });

    factory ProductIdModel.fromRawJson(String str) => ProductIdModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductIdModel.fromJson(Map<String, dynamic> json) => ProductIdModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        description: json["description"],
        categoryId: json["category_id"],
        stockCutoffDay: json["stock_cutoff_day"],
        order: json["order"],
        rating: json["rating"],
        ratingCount: json["rating_count"],
        inputPrice: json["input_price"],
        discountPrice: json["discount_price"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "description": description,
        "category_id": categoryId,
        "stock_cutoff_day": stockCutoffDay,
        "order": order,
        "rating": rating,
        "rating_count": ratingCount,
        "input_price": inputPrice,
        "discount_price": discountPrice,
    };
}