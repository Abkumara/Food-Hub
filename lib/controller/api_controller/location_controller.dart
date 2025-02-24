import 'package:foods_hub/model/location_model.dart';
import 'package:foods_hub/services/location_service.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var locations = <LocationModel>[].obs; // Observable list of locations
  var isLoading = false.obs; // Loading state for UI
  var errorMessage = ''.obs; // To hold error messages

  final LocationService _locationService = LocationService();

  // Fetch locations from the service
  Future<void> fetchLocations() async {
    isLoading(true); // Show loading spinner
    try {
      final fetchedLocations = await _locationService.fetchLocations();
      locations.assignAll(fetchedLocations); // Update the UI state
    } catch (e) {
      errorMessage.value = e.toString(); // Set error message
    } finally {
      isLoading(false); // Hide loading spinner
    }
  }

  // Add a new location
  Future<void> addLocation(AddLocationRequest request) async {
    isLoading(true); // Show loading spinner
    try {
      await _locationService.addLocation(request);
      fetchLocations(); // Refresh the list after adding a new location
    } catch (e) {
      errorMessage.value = e.toString(); // Set error message
    } finally {
      isLoading(false); // Hide loading spinner
    }
  }

  Future<void> deleteLocation(String locationId) async {
    try {
      await _locationService.deleteLocation(locationId);
      Get.snackbar("Success", "Location Deleted Successfully!");
      fetchLocations(); // Refresh the list after deletion
    } catch (e) {
      Get.snackbar("Error", "Failed to delete location: $e");
    }
  }

  // Add a new location
  Future<void> updateLocation(
      AddLocationRequest request, String locationId) async {
    isLoading(true); // Show loading spinner
    try {
      await _locationService.updateLocation(request, locationId);
      Get.snackbar("Success", "Location Updated Successfully!");

      fetchLocations(); // Refresh the list after adding a new location
    } catch (e) {
      errorMessage.value = e.toString(); // Set error message
    } finally {
      isLoading(false); // Hide loading spinner
    }
  }
}
