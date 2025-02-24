import 'dart:convert';

class CartModel {
  String cartId;
  int itemTotal;
  int itemDiscount;
  int deliveryFee;
  String deliveryDistance;
  int deliveryTips;
  int platformFee;
  double gstAmount;
  int restaurantCharges;
  double gstAndRestorenCharge;
  double toPayAmount;
  List<Item> items;

  CartModel({
    required this.cartId,
    required this.itemTotal,
    required this.itemDiscount,
    required this.deliveryFee,
    required this.deliveryDistance,
    required this.deliveryTips,
    required this.platformFee,
    required this.gstAmount,
    required this.restaurantCharges,
    required this.gstAndRestorenCharge,
    required this.toPayAmount,
    required this.items,
  });

  factory CartModel.fromRawJson(String str) =>
      CartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        cartId: json["cart_id"],
        itemTotal: json["item_total"],
        itemDiscount: json["item_discount"],
        deliveryFee: json["delivery_fee"],
        deliveryDistance: json["delivery_distance"],
        deliveryTips: json["delivery_tips"],
        platformFee: json["platform_fee"],
        gstAmount: json["gst_amount"]?.toDouble(),
        restaurantCharges: json["restaurant_charges"],
        gstAndRestorenCharge: json["gst_and_restoren_charge"]?.toDouble(),
        toPayAmount: json["to_pay_amount"]?.toDouble(),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "item_total": itemTotal,
        "item_discount": itemDiscount,
        "delivery_fee": deliveryFee,
        "delivery_distance": deliveryDistance,
        "delivery_tips": deliveryTips,
        "platform_fee": platformFee,
        "gst_amount": gstAmount,
        "restaurant_charges": restaurantCharges,
        "gst_and_restoren_charge": gstAndRestorenCharge,
        "to_pay_amount": toPayAmount,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  String id;
  String cartId;
  int quantity;
  String originalPrice;
  String discountPrice;
  String totalPrice;
  String totalDiscountPrice;
  String productId;
  String productName;
  String productImage;

  Item({
    required this.id,
    required this.cartId,
    required this.quantity,
    required this.originalPrice,
    required this.discountPrice,
    required this.totalPrice,
    required this.totalDiscountPrice,
    required this.productId,
    required this.productName,
    required this.productImage,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        cartId: json["cart_id"],
        quantity: json["quantity"],
        originalPrice: json["original_price"],
        discountPrice: json["discount_price"],
        totalPrice: json["total_price"],
        totalDiscountPrice: json["total_discount_price"],
        productId: json["product_id"],
        productName: json["product_name"],
        productImage: json["product_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cart_id": cartId,
        "quantity": quantity,
        "original_price": originalPrice,
        "discount_price": discountPrice,
        "total_price": totalPrice,
        "total_discount_price": totalDiscountPrice,
        "product_id": productId,
        "product_name": productName,
        "product_image": productImage,
      };
}

class AddCartModel {
  String productId;
  int quantity;

  AddCartModel({
    required this.productId,
    required this.quantity,
  });

  factory AddCartModel.fromRawJson(String str) =>
      AddCartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddCartModel.fromJson(Map<String, dynamic> json) => AddCartModel(
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
      };
}

class RemoveCartModel {
  String cartItemId;

  RemoveCartModel({
    required this.cartItemId,
  });

  factory RemoveCartModel.fromRawJson(String str) =>
      RemoveCartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RemoveCartModel.fromJson(Map<String, dynamic> json) =>
      RemoveCartModel(
        cartItemId: json["cart_item_id"],
      );

  Map<String, dynamic> toJson() => {
        "cart_item_id": cartItemId,
      };
}
