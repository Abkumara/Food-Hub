import 'package:flutter/material.dart';
import 'package:foods_hub/controller/api_controller/location_controller.dart';
import 'package:foods_hub/controller/api_controller/user_profile_controller.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/core/widgets/custome_search_bar.dart';
import 'package:foods_hub/core/widgets/loading_widgets.dart';
import 'package:foods_hub/model/location_model.dart';
import 'package:foods_hub/screen/my_account/select_delivery_location_screen.dart';
import 'package:foods_hub/screen/my_account/widgets/my_address_screen_widget.dart';
import 'package:foods_hub/widgets/custom_app_bar_widget.dart';
import 'package:foods_hub/widgets/custom_button.dart';
import 'package:get/get.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  final LocationController locationController = Get.put(LocationController());
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      userProfileController.fetchUserProfile();
      locationController.fetchLocations();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF4F4F4),
        appBar: const CustomAppBar(title: 'ADDRESSES'),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
            child: CustomButtonWithOutline(
              bgColor: Colors.transparent,
              borderColor: greenColor,
              textColor: greenColor,
              text: 'ADD NEW ADDRESS',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectDeliveryLocationScreen(),
                  )),
              isWhite: false,
            )),
        body: Obx(() {
          if (locationController.isLoading.value &&
              userProfileController.isLoading.value) {
            return ShimmerLoadingWidget();
          } else if (locationController.locations.isEmpty) {
            return const Center(child: Text('Addreses are empty....'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: colorWhite,
                  height: 85,
                  width: double.infinity,
                  child: Center(
                    child: SearchInputField(
                      height: 55,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 17, horizontal: 35),
                      validator: (p0) {},
                      hintText: 'Search your saved Address',
                      borderColor: borderColor,
                      border: Border.all(width: 2),
                      suffixIcon: const Icon(
                        Icons.search,
                        size: 30,
                        color: borderColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'SAVED ADDRESS',
                            style: size12_M_bold(
                                textColor: const Color(0xff929295)),
                          ),
                        ),
                        Container(
                          color: colorWhite,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: locationController.locations.length,
                            itemBuilder: (context, index) {
                              var locationApi =
                                  locationController.locations.value[index];
                              var request = AddLocationRequest(
                                  location: locationApi.location,
                                  addressUnit: '',
                                  apartmentUnit: '',
                                  pincode: '',
                                  type: locationApi.type,
                                  isDefault: true);
                              return SaveAddressWidget(
                                  locationId: locationApi.id,
                                  layerTap: () {
                                    locationController.updateLocation(
                                        request, locationApi.id);
                                  },
                                  isDefault: locationApi.isDefault,
                                  type: locationApi.type,
                                  location: locationApi.location,
                                  phoneNumber: userProfileController
                                      .userProfile.value.mobile
                                      .toString(),
                                  onTap: () {
                                    locationController
                                        .deleteLocation(locationApi.id);
                                  });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }));
  }
}
