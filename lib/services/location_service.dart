import 'package:get/get.dart';
import 'package:ksn_mobile_customer/model/location_model.dart';
import 'package:ksn_mobile_customer/network/api/api_client.dart';
import 'package:ksn_mobile_customer/network/api/api_endpoints.dart';
import 'package:ksn_mobile_customer/screens/auth/fetch_location_screen.dart';

class LocationService {
  final DioClientWithToken _apiClient = DioClientWithToken();

  // Fetch locations
  Future<List<LocationModel>> fetchLocations() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.storeLocation);
      if (response.statusCode == 200 && response.data['success']) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => LocationModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch locations");
      }
    } catch (e) {
      throw Exception("Error fetching locations: $e");
    }
  }

  // Add a new location
  Future<void> addLocation(AddLocationRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.storeLocation,
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        final locationData = response.data;
        Get.to(() => FetchLocationScreen(
              location: locationData['data']['location'],
            ));
      } else {
        throw Exception("Failed to add location");
      }
    } catch (e) {
      throw Exception("Error adding location: $e");
    }
  }

  Future<void> deleteLocation(String locationId) async {
    try {
      final response =
          await _apiClient.delete('${ApiEndpoints.locationDelete}$locationId');
      if (response.statusCode != 200) {
        throw Exception("Failed to delete location");
      }
    } catch (e) {
      throw Exception("Error deleting location: $e");
    }
  }

  //update location
  // Add a new location
  Future<void> updateLocation(
    AddLocationRequest request,
    String locationId,
  ) async {
    try {
      final response = await _apiClient.put(
        '${ApiEndpoints.updateLocation}$locationId',
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        Get.back();
      } else {
        throw Exception("Failed to add location");
      }
    } catch (e) {
      throw Exception("Error adding location: $e");
    }
  }
}
