import 'package:flutter/material.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/screen/auth/fetch_location_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ksn_mobile_customer/controller/api_controller/location_controller.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/model/location_model.dart';
import 'package:ksn_mobile_customer/screens/auth/fetch_location_screen.dart';
import 'package:ksn_mobile_customer/widgets/custom_button.dart';
import 'package:ksn_mobile_customer/widgets/custom_text_field.dart';

class AddressManuallyScreen extends StatefulWidget {
  const AddressManuallyScreen({super.key});

  @override
  State<AddressManuallyScreen> createState() => _AddressManuallyScreenState();
}

class _AddressManuallyScreenState extends State<AddressManuallyScreen> {
  final TextEditingController _houseNoController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LocationController locationController = Get.put(LocationController());

  //fetch current location
  Future<void> _useCurrentLocation() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.always &&
            permission != LocationPermission.whileInUse) {
          // If permission is still not granted, show a message and exit.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location permission is required.")),
          );
          return;
        }
      }
      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Reverse geocode to get placemarks (addresses)
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Use the first placemark from the list
      Placemark place = placemarks.first;

      // Build a human-readable address string.
      // Adjust the fields as per your requirement.
      String currentAddress = '';
      if (place.name != null && place.name!.isNotEmpty) {
        currentAddress += '${place.name}, ';
      }
      if (place.thoroughfare != null && place.thoroughfare!.isNotEmpty) {
        currentAddress += '${place.thoroughfare}, ';
      }
      if (place.subLocality != null && place.subLocality!.isNotEmpty) {
        currentAddress += '${place.subLocality}, ';
      }
      if (place.locality != null && place.locality!.isNotEmpty) {
        currentAddress += '${place.locality}, ';
      }
      if (place.postalCode != null && place.postalCode!.isNotEmpty) {
        currentAddress += '${place.postalCode}, ';
      }
      if (place.country != null && place.country!.isNotEmpty) {
        currentAddress += '${place.country}';
      }

      // Remove any trailing commas and spaces if necessary.
      currentAddress = currentAddress.trim();
      if (currentAddress.endsWith(',')) {
        currentAddress = currentAddress.substring(0, currentAddress.length - 1);
      }

      // Navigate to FetchLocationScreen with the fetched address.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FetchLocationScreen(location: currentAddress),
        ),
      );
    } catch (e) {
      // Handle errors (e.g., unable to fetch location, reverse geocoding failed, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching location: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryOrange,
      appBar: AppBar(
          backgroundColor: primaryBackgroundWhiteColor,
          titleSpacing: -1,
          title: Text(
            'Enter your Address',
            style: size16_M_medium().copyWith(color: Colors.black),
          ),
          centerTitle: false,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back,
              color: primaryOrange,
            ),
          )),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: const BoxDecoration(
                          color: primaryBackgroundWhiteColor,
                          borderRadius: BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(30),
                            bottomStart: Radius.circular(30),
                          )),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomTextField(
                              textEditingController: _houseNoController,
                              hintText: 'House.no / floor / building',
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextField(
                              textEditingController: _areaController,
                              hintText: 'Area / sector / locality',
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextField(
                              textEditingController: _cityController,
                              hintText: 'City',
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextField(
                              textEditingController: _pinCodeController,
                              hintText: 'Pincode',
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            CustomButton(
                              text: 'Continue',
                              onTap: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  final request = AddLocationRequest(
                                    location:
                                        '${_areaController.text},${_cityController.text}',
                                    addressUnit: _houseNoController.text,
                                    apartmentUnit: '',
                                    pincode: _pinCodeController.text,
                                    type: '',
                                  );
                                  locationController.addLocation(request);
                                }
                              },
                              isWhite: false,
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: CustomButton(
                        text: 'Use current location',
                        onTap: _useCurrentLocation,
                        isWhite: false,
                      ),
                    ),
                    // Positioned(
                    //   // Adjust positioning as needed.
                    //   bottom: 40,
                    //   left: 40,
                    //   right: 40,
                    //   child: CustomButton(
                    //     text: 'Use current location',
                    //     onTap:
                    //         _useCurrentLocation, // Call the async function above.
                    //     isWhite: false,
                    //   ),
                    // ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
