import 'dart:convert';

class CategoryModel {
  String id;
  String name;
  String slug;
  String image;
  String description;
  String iconImage;
  int order;
  DateTime createdAt;
  DateTime updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.description,
    required this.iconImage,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        description: json["description"],
        iconImage: json["icon_image"],
        order: json["order"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "description": description,
        "icon_image": iconImage,
        "order": order,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ProductByCategoryModel {
  CategoryModel category;
  List<Product> products;

  ProductByCategoryModel({
    required this.category,
    required this.products,
  });

  factory ProductByCategoryModel.fromRawJson(String str) =>
      ProductByCategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductByCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProductByCategoryModel(
        category: CategoryModel.fromJson(json["category"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  String id;
  String name;
  String slug;
  String image;
  String description;
  String categoryId;
  dynamic stockCutoffDay;
  int order;
  double rating;
  int ratingCount;
  double inputPrice;
  double discountPrice;
  List<Product> subProducts;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        description: json["description"],
        categoryId: json["category_id"],
        stockCutoffDay: json["stock_cutoff_day"],
        order: json["order"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["rating_count"],
        inputPrice: (json["input_price"] is int)
            ? (json["input_price"] as int).toDouble()
            : json["input_price"],
        discountPrice: (json["discount_price"] is int)
            ? (json["discount_price"] as int).toDouble()
            : json["discount_price"],
        subProducts: List<Product>.from(
            json["sub_products"].map((x) => Product.fromJson(x))),
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
        "sub_products": List<dynamic>.from(subProducts.map((x) => x.toJson())),
      };
}
