import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/screens/my_account/edit_location_screen.dart';

class SaveAddressWidget extends StatelessWidget {
  const SaveAddressWidget({
    super.key,
    required this.phoneNumber,
    required this.location,
    required this.type,
    required this.onTap,
    required this.isDefault,
    required this.layerTap,
    required this.locationId,
  });
  final Function layerTap;
  final String phoneNumber;
  final String location;
  final String type;
  final Function onTap;
  final bool isDefault;
  final String locationId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isDefault ? () => layerTap() : () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.home,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          type,
                          style: size16_M_bold(textColor: blackType1),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        isDefault
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1.5, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFA8DA8B)
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  'Currently Selected',
                                  style: size10_M_bold(textColor: greenColor),
                                ))
                            : SizedBox.shrink()
                      ],
                    ),
                    Text(
                      location,
                      textAlign: TextAlign.start,
                      softWrap: true,
                      style:
                          size14_M_regular(textColor: const Color(0xff8F8B8B)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Phone number : $phoneNumber',
                      style:
                          size14_M_regular(textColor: const Color(0xff8F8B8B)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(() => EditLocationScreen(
                                locationId: locationId,
                                location: location,
                              )),
                          child: Text('EDIT',
                              style: size14_M_bold(textColor: primaryOrange)),
                        ),
                        const SizedBox(
                          width: 36,
                        ),
                        GestureDetector(
                          onTap: () => onTap(),
                          child: Text('DELETE',
                              style: size14_M_bold(textColor: primaryOrange)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            height: 10,
            color: dividerColor,
          )
        ],
      ),
    );
  }
}
