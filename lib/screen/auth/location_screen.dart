import 'package:flutter/material.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/screen/auth/address_maually_screen.dart';
import 'package:foods_hub/screen/auth/fetch_location_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool isLocation = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        isLocation = true;
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLocation = false;
        });
      });
    });
    super.initState();
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.always &&
            permission != LocationPermission.whileInUse) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location permission is required.")),
          );
          return;
        }
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Reverse geocode to get placemark details
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      // Take the first placemark
      Placemark place = placemarks.first;

      // Format the address
      String address = "${place.name}, ${place.street}, "
          "${place.locality}, ${place.postalCode}, ${place.country}";

      // go to FetchLocationScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FetchLocationScreen(location: address),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching location: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryOrange,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: screenHeight * 0.48,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(30),
                  bottomStart: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Where do you want our service?',
                    style: size16_M_medium().copyWith(color: primaryOrange),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 650),
            curve: Curves.easeIn,
            alignment: isLocation
                ? const Alignment(0, -0.80)
                : const Alignment(0, -0.42),
            child: Image.asset('assets/images/location.png'),
          ),
          Positioned(
            bottom: screenHeight * 0.26,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  CustomButton(
                    text: 'Use current location',
                    onTap: _fetchCurrentLocation,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Enter location manually',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddressManuallyScreen(),
                      ),
                    ),
                    isWhite: false,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:ksn_mobile_customer/core/constant/colors.dart';
// import 'package:ksn_mobile_customer/core/constant/text_style.dart';
// import 'package:ksn_mobile_customer/screens/auth/address_maually_screen.dart';
// import 'package:ksn_mobile_customer/screens/auth/fetch_location_screen.dart';
// import 'package:ksn_mobile_customer/widgets/custom_button.dart';

// class LocationScreen extends StatefulWidget {
//   const LocationScreen({super.key});

//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   bool isLocation = false;

//   @override
//   void initState() {
//     Future.delayed(const Duration(milliseconds: 600), () {
//       setState(() {
//         isLocation = true;
//       });
//       Future.delayed(const Duration(seconds: 1), () {
//         setState(() {
//           isLocation = false;
//         });
//       });
//     });
//     super.initState();
//   }

//   Future<void> _fetchCurrentLocation() async {
//     try {
//       // Check for location permissions
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied ||
//           permission == LocationPermission.deniedForever) {
//         permission = await Geolocator.requestPermission();
//         if (permission != LocationPermission.always &&
//             permission != LocationPermission.whileInUse) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Location permission is required.")),
//           );
//           return;
//         }
//       }

//       // Get the current position 
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);

//       // Reverse geocode covert lagitiude alatitude to address
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );

//       // Use the first available placemark to build the address string
//       Placemark place = placemarks.first;
//       String currentAddress = '';

//       if (place.name != null && place.name!.isNotEmpty) {
//         currentAddress += '${place.name}, ';
//       }
//       if (place.thoroughfare != null && place.thoroughfare!.isNotEmpty) {
//         currentAddress += '${place.thoroughfare}, ';
//       }
//       if (place.subLocality != null && place.subLocality!.isNotEmpty) {
//         currentAddress += '${place.subLocality}, ';
//       }
//       if (place.locality != null && place.locality!.isNotEmpty) {
//         currentAddress += '${place.locality}, ';
//       }
//       if (place.postalCode != null && place.postalCode!.isNotEmpty) {
//         currentAddress += '${place.postalCode}, ';
//       }
//       if (place.country != null && place.country!.isNotEmpty) {
//         currentAddress += '${place.country}';
//       }

//       // Clean up any trailing commas or spaces
//       currentAddress = currentAddress.trim();
//       if (currentAddress.endsWith(',')) {
//         currentAddress = currentAddress.substring(0, currentAddress.length - 1);
//       }

//       // Navigate to FetchLocationScreen with the fetched address
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => FetchLocationScreen(location: currentAddress),
//         ),
//       );
//     } catch (e) {
//       // Handle errors (e.g., permission denied, location service disabled, etc.)
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error fetching location: $e")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: primaryOrange,
//       body: Stack(
//         children: [
//           Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 height: screenHeight * 0.48,
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                     color: colorWhite,
//                     borderRadius: BorderRadiusDirectional.only(
//                       bottomEnd: Radius.circular(30),
//                       bottomStart: Radius.circular(30),
//                     )),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       'Where do you want our service?',
//                       style: size16_M_medium().copyWith(color: primaryOrange),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     )
//                   ],
//                 ),
//               )),
//           AnimatedAlign(
//             duration: const Duration(milliseconds: 650),
//             curve: Curves.easeIn,
//             alignment: isLocation
//                 ? const Alignment(0, -0.80)
//                 : const Alignment(0, -0.42),
//             child: Image.asset('assets/images/location.png'),
//           ),
//           Positioned(
//               bottom: screenHeight * 0.26,
//               left: 0,
//               right: 0,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                 child: Column(
//                   children: [
//                     CustomButton(
//                         text: 'Use current location',
//                         onTap: _fetchCurrentLocation, // Calls the function above
//                         // onTap: () {
//                         //   Navigator.push(
//                         //       context,
//                         //       MaterialPageRoute(
//                         //         builder: (context) => FetchLocationScreen(
//                         //           location:
//                         //               'Nandhini Enclave,\n Road No 4,\nJubilee Hills , Hyderabad',
//                         //         ),
//                         //       ));
//                         // }
//                     ),
//                     const SizedBox(height: 20),
//                     CustomButton(
//                       text: 'Enter location manually',
//                       onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const AddressManuallyScreen(),
//                           )),
//                       isWhite: false,
//                     )
//                   ],
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:ksn_mobile_customer/core/constant/colors.dart';
// import 'package:ksn_mobile_customer/core/constant/text_style.dart';
// import 'package:ksn_mobile_customer/screens/auth/address_maually_screen.dart';
// import 'package:ksn_mobile_customer/screens/auth/fetch_location_screen.dart';
// import 'package:ksn_mobile_customer/widgets/custom_button.dart';

// class LocationScreen extends StatefulWidget {
//   const LocationScreen({super.key});

//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   bool isLocation = false;

//   @override
//   void initState() {
//     Future.delayed(const Duration(milliseconds: 600), () {
//       setState(() {
//         isLocation = true;
//       });
//       Future.delayed(const Duration(seconds: 1), () {
//         setState(() {
//           isLocation = false;
//         });
//       });
//     });
//     super.initState();
//   }

//     /// Fetches the current location, reverse geocodes it, and navigates to FetchLocationScreen.
//   Future<void> _fetchCurrentLocation() async {
//     try {
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied ||
//           permission == LocationPermission.deniedForever) {
//         permission = await Geolocator.requestPermission();
//         if (permission != LocationPermission.always &&
//             permission != LocationPermission.whileInUse) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Location permission is required.")),
//           );
//           return;
//         }
//       }

//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);

//       String liveLocation =
//           "Latitude: ${position.latitude}\nLongitude: ${position.longitude}";

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => FetchLocationScreen(location: liveLocation),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error fetching location: $e")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: primaryOrange,
//       body: Stack(
//         children: [
//           Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 height: screenHeight * 0.48,
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                     color: colorWhite,
//                     borderRadius: BorderRadiusDirectional.only(
//                       bottomEnd: Radius.circular(30),
//                       bottomStart: Radius.circular(30),
//                     )),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       'Where do you want our service?',
//                       style: size16_M_medium().copyWith(color: primaryOrange),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     )
//                   ],
//                 ),
//               )),
//           AnimatedAlign(
//             duration: const Duration(milliseconds: 650),
//             curve: Curves.easeIn,
//             alignment: isLocation
//                 ? const Alignment(0, -0.80)
//                 : const Alignment(0, -0.42),
//             child: Image.asset('assets/images/location.png'),
//           ),
//           Positioned(
//               bottom: screenHeight * 0.26,
//               left: 0,
//               right: 0,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                 child: Column(
//                   children: [
//                     CustomButton(
//                         text: 'Use current location',
//                         onTap: _fetchCurrentLocation, // Calls the function above
//                         // onTap: () {
//                         //   Navigator.push(
//                         //       context,
//                         //       MaterialPageRoute(
//                         //         builder: (context) => FetchLocationScreen(
//                         //           location:
//                         //               'Nandhini Enclave,\n Road No 4,\nJubilee Hills , Hyderabad',
//                         //         ),
//                         //       ));
//                         // }
//                     ),
//                     const SizedBox(height: 20),
//                     CustomButton(
//                       text: 'Enter location manually',
//                       onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const AddressManuallyScreen(),
//                           )),
//                       isWhite: false,
//                     )
//                   ],
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }
