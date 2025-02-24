import 'dart:convert';

class OrdersResponse {
  final bool success;
  final String message;
  final List<Order> data;

  OrdersResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    return OrdersResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)
              ?.map((order) => Order.fromJson(order))
              .toList() ??
          [],
    );
  }
}

class Order {
  final String? orderId;
  final String? orderDate;
  final String? itemTotal;
  final String? deliveryType;
  final String? itemDiscount;
  final int? gstAndRestorenCharge;
  final String? paymentThrough;
  final String? paymentStatus;
  final String? preparationStatus;
  final String? billTotal;
  final String? vendorName;
  final String? vendorLocation;
  final String? deliveryFee;
  final String? deliveryDistance;
  final String? deliveryTips;
  final String? platformFee;

  Order({
    this.orderId,
    this.orderDate,
    this.itemTotal,
    this.deliveryType,
    this.itemDiscount,
    this.gstAndRestorenCharge,
    this.paymentThrough,
    this.paymentStatus,
    this.preparationStatus,
    this.billTotal,
    this.vendorName,
    this.vendorLocation,
    this.deliveryFee,
    this.deliveryDistance,
    this.deliveryTips,
    this.platformFee,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'],
      orderDate: json['order_date'],
      itemTotal: json['item_total'],
      deliveryType: json['delivery_type'],
      itemDiscount: json['item_discount'],
      gstAndRestorenCharge: json['gst_and_restoren_charge'],
      paymentThrough: json['payment_through'],
      paymentStatus: json['payment_status'],
      preparationStatus: json['preparation_status'],
      billTotal: json['bill_total'],
      vendorName: json['vendor_name'],
      vendorLocation: json['vendor_location'],
      deliveryFee: json['delivery_fee'],
      deliveryDistance: json['delivery_distance'],
      deliveryTips: json['delivery_tips'],
      platformFee: json['platform_fee'],
    );
  }
}

class OrderCheckOutModel {
  String? deliveryType;

  OrderCheckOutModel({
    this.deliveryType,
  });

  factory OrderCheckOutModel.fromRawJson(String str) =>
      OrderCheckOutModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderCheckOutModel.fromJson(Map<String, dynamic> json) =>
      OrderCheckOutModel(
        deliveryType: json["delivery_type"],
      );

  Map<String, dynamic> toJson() => {
        "delivery_type": deliveryType,
      };
}
