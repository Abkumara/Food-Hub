import 'package:ksn_mobile_customer/model/refund_history_model.dart';
import 'package:ksn_mobile_customer/network/api/api_client.dart';
import 'package:ksn_mobile_customer/network/api/api_endpoints.dart';

class RefundService {
  final DioClientWithToken _dioClient = DioClientWithToken();

  Future<RefundResponse?> fetchRefunds() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.refundHistory);
      return RefundResponse.fromJson(response.data);
    } catch (e) {
      print("Error fetching refunds: $e");
      return null;
    }
  }
}
