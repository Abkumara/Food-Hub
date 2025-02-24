import 'package:foods_hub/model/refund_history_model.dart';
import 'package:foods_hub/services/refund_history_service.dart';
import 'package:get/get.dart';

class RefundController extends GetxController {
  final RefundService _refundService = RefundService();
  var refunds = <Refund>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getRefunds();
  }

  void getRefunds() async {
    isLoading(true);
    final response = await _refundService.fetchRefunds();
    if (response != null && response.success) {
      refunds.assignAll(response.data);
    }
    isLoading(false);
  }
}
