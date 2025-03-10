import 'package:foods_hub/model/order_model.dart';
import 'package:foods_hub/network/api/api_client.dart';
import 'package:foods_hub/network/api/api_endpoints.dart';

class OrderService {
  final DioClientWithToken _apiClient = DioClientWithToken();

  Future<List<Order>> fetchOrders() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.orderHistory);
      if (response.statusCode == 200 && response.data['success']) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => Order.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch orders");
      }
    } catch (e) {
      throw Exception("Error fetching orders: $e");
    }
  }

  Future<OrderCheckOutModel> orderCheckOut(String type) async {
    final response = await _apiClient.post(
      ApiEndpoints.orderCheckOut,
      data: {'delivery_type': type},
    );
    if (response.statusCode == 200) {
      return OrderCheckOutModel.fromJson(response.data ?? {});
    } else {
      throw Exception(
          "Failed to order checkout. Status Code: ${response.statusCode}");
    }
  }
}
