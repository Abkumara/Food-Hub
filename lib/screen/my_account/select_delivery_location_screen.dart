import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/core/widgets/custome_search_bar.dart';
import 'package:ksn_mobile_customer/screens/my_account/confirm_location_screen.dart';
import 'package:ksn_mobile_customer/screens/my_account/search_screen.dart';
import 'package:ksn_mobile_customer/widgets/custom_app_bar_widget.dart';
import 'package:ksn_mobile_customer/widgets/custom_button.dart';

class SelectDeliveryLocationScreen extends StatefulWidget {
  const SelectDeliveryLocationScreen({super.key});

  @override
  _SelectDeliveryLocationScreenState createState() =>
      _SelectDeliveryLocationScreenState();
}

class _SelectDeliveryLocationScreenState
    extends State<SelectDeliveryLocationScreen> {
  FocusNode _searchFocusNode = FocusNode();
  double _keyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus) {
        setState(() {
          _keyboardHeight = MediaQuery.of(context)
              .viewInsets
              .bottom; 
        });
      } else {
        setState(() {
          _keyboardHeight = 0; 
        });
      }
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Select delivery location'),
      body: Stack(
        children: [
          Positioned.fill(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(7.8731, 80.7718),
                    zoom: 13,
                  ),
                  myLocationEnabled: true,
                ),
                Positioned(
                  top: 10,
                  right: 20,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: SearchInputField(
                      focusNode: _searchFocusNode,
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
                // Add your container here
              ],
            ),
          ),
          Positioned(
            bottom: keyboardHeight == 0 ? 0 : -keyboardHeight + 10,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 54,
                    width: 232,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: colorWhite,
                              blurRadius: 4,
                              offset: Offset(-1, 0),
                              spreadRadius: 0)
                        ],
                        color: colorWhite,
                        border: Border.all(color: const Color(0xffA8A4A4)),
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.my_location_rounded,
                            color: primaryOrange,
                            size: 24,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Use Current Location',
                            style: size16_M_bold(textColor: primaryOrange),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 195,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff000000),
                            blurRadius: 4,
                            offset: Offset(0, -1),
                            spreadRadius: 0)
                      ],
                      color: colorWhite,
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(20),
                          topStart: Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_sharp,
                                  color: primaryOrange,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'Jubliee Hills',
                                  style: size20_M_bold(textColor: blackType1),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 96,
                              child: CustomButtonWithOutline(
                                  text: 'CHANGE',
                                  height: 30,
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchScreen(),
                                      )),
                                  bgColor: colorWhite,
                                  borderColor: const Color(0xffA8A4A4),
                                  textColor: primaryOrange),
                            )
                          ]),
                      SizedBox(
                          width: 220,
                          child: Text(
                            softWrap: true,
                            'Nandhani enclave , Ayyapa Society ,100feet road Madhapur 500018, H... ',
                            style: size12_M_regular(
                                textColor: const Color(0xff8F8B8B)),
                          )),
                      const SizedBox(
                        height: 17,
                      ),
                      CustomButton(
                        text: 'CONFIRM LOCATION',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmLocationScreen(),
                            )),
                        isWhite: false,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
