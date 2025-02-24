import 'package:foods_hub/model/order_model.dart';
import 'package:foods_hub/services/order_service.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var orders = <Order>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final OrderService _orderService = OrderService();

  Future<void> fetchOrders() async {
    isLoading(true);
    try {
      final fetchedOrders = await _orderService.fetchOrders();
      orders.assignAll(fetchedOrders);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  var orderCheckoutResponse = OrderCheckOutModel(
    deliveryType: '',
  ).obs;
  Future<void> orderCheckOut(String type) async {
    try {
      isLoading.value = true;
      final response = await _orderService.orderCheckOut(type);
      orderCheckoutResponse.value = response;
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = "Failed to order checkout: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
