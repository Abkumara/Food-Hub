class RefundResponse {
  final bool success;
  final String message;
  final List<Refund> data;

  RefundResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RefundResponse.fromJson(Map<String, dynamic> json) {
    return RefundResponse(
      success: json['success'],
      message: json['message'],
      // If 'data' is empty, initialize it as an empty list to avoid errors
      data: (json['data'] != null && json['data'].isNotEmpty)
          ? List<Refund>.from(json['data'].map((x) => Refund.fromJson(x)))
          : [], // Safely handle empty data by returning an empty list
    );
  }
}

class Refund {
  final String orderId;
  final String refundFrom;
  final String amount;
  final String status;
  final String? completedDate;
  final List<RefundStatus> statuses;

  Refund({
    required this.orderId,
    required this.refundFrom,
    required this.amount,
    required this.status,
    this.completedDate,
    required this.statuses,
  });

  factory Refund.fromJson(Map<String, dynamic> json) {
    return Refund(
      orderId: json['order_id'],
      refundFrom: json['refund_from'],
      amount: json['amount'],
      status: json['status'],
      completedDate: json['completed_date'],
      statuses: json['statuses'] != null
          ? List<RefundStatus>.from(
              json['statuses'].map((x) => RefundStatus.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "order_id": orderId,
      "refund_from": refundFrom,
      "amount": amount,
      "status": status,
      "completed_date": completedDate,
      "statuses": statuses.map((x) => x.toJson()).toList(),
    };
  }
}

class RefundStatus {
  final String status;
  final String completedDate;

  RefundStatus({
    required this.status,
    required this.completedDate,
  });

  factory RefundStatus.fromJson(Map<String, dynamic> json) {
    return RefundStatus(
      status: json['status'],
      completedDate: json['completed_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "completed_date": completedDate,
    };
  }
}
