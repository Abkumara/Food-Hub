import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:foods_hub/controller/api_controller/user_profile_controller.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/core/widgets/loading_widgets.dart';
import 'package:foods_hub/screen/faqs/about_us.dart';
import 'package:foods_hub/screen/faqs/faq_screen.dart';
import 'package:foods_hub/screen/faqs/shipping_details_screen.dart';
import 'package:foods_hub/screen/faqs/terms_conditions.dart';
import 'package:foods_hub/screen/my_account/contact_us_screen.dart';
import 'package:foods_hub/screen/my_account/edit_profile_screen.dart';
import 'package:foods_hub/screen/my_account/my_address_screen.dart';
import 'package:foods_hub/screen/refunds/refund_status_screen.dart';
import 'package:foods_hub/screen/tab_controller.dart';
import 'package:get/get.dart';

class PastOrderWidget extends StatefulWidget {
  const PastOrderWidget(
      {super.key,
      required this.name,
      required this.address,
      required this.price,
      required this.date,
      required this.dotLine,
      required this.itemCount,
      required this.index,
      required this.onTap,
      required this.distance,
      required this.itemTotalPrice,
      required this.deliverFee,
      required this.itemDiscount,
      required this.deliveryTip,
      required this.platformFee,
      required this.gstAndResturantCharges,
      required this.billTotal});
  final String name;
  final String address;
  final String price;
  final String date;
  final Function dotLine;
  final int itemCount;
  final int index;
  final Function onTap;
  final String distance;
  final String itemTotalPrice;
  final String deliverFee;
  final String itemDiscount;
  final String deliveryTip;
  final String platformFee;
  final String gstAndResturantCharges;
  final String billTotal;

  @override
  State<PastOrderWidget> createState() => _PastOrderWidgetState();
}

class _PastOrderWidgetState extends State<PastOrderWidget> {
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: colorWhite,
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: size15_M_medium_black(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Delivered',
                        style: size10_M_medium(textColor: blackType1),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xff1CA672),
                        size: 15,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.address,
                style: size12_M_medium(textColor: accountSmallText),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.price,
                    style: size12_M_medium(textColor: accountSmallText),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isClick = !isClick;
                      });
                    },
                    child: Icon(
                      !isClick
                          ? Icons.keyboard_arrow_right
                          : Icons.keyboard_arrow_down,
                      size: 20,
                      color: accountSmallText,
                    ),
                  )
                ],
              ),
              !isClick
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.date,
                          style: size12_M_medium(textColor: accountSmallText),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: PastOrderCustomButton(
                                title: 'REORDER',
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TabScreen(
                                          index: 2,
                                        ),
                                      ));
                                },
                                color: blackType1,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: PastOrderCustomButton(
                                title: 'RATE ORDER',
                                onTap: () => widget.onTap(),
                                color: primaryOrange,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Bill Details',
                          style: size15_M_medium_black(),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Item total',
                              style:
                                  size14_M_regular(textColor: accountSmallText),
                            ),
                            Text(
                              '₹${widget.itemTotalPrice}',
                              style:
                                  size14_M_medium(textColor: accountSmallText),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Delivery Fee ',
                                  style:
                                      size14_M_regular(textColor: accountSmallText)
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationStyle:
                                                  TextDecorationStyle.dotted,
                                              decorationThickness: 2),
                                ),
                                Text(
                                  '| ',
                                  style: size14_M_regular(
                                      textColor: accountSmallText),
                                ),
                                Text(
                                  '${widget.distance} kms',
                                  style:
                                      size14_M_regular(textColor: accountSmallText)
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationStyle:
                                                  TextDecorationStyle.dotted,
                                              decorationThickness: 2),
                                )
                              ],
                            ),
                            Text(
                              '₹${widget.distance}',
                              style:
                                  size14_M_medium(textColor: accountSmallText),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        // Text(
                        //   'Order above ₹100 to save ₹5',
                        //   style: size10_M_regular(textColor: accountSmallText),
                        // ),
                        // const SizedBox(
                        //   height: 7,
                        // ),
                        const DottedLine(
                          dashColor: Color(0xffEAEAEA),
                          lineThickness: 2,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Item Discount',
                              style:
                                  size14_M_regular(textColor: accountSmallText)
                                      .copyWith(
                                          decoration: TextDecoration.underline,
                                          decorationStyle:
                                              TextDecorationStyle.dotted,
                                          decorationThickness: 2),
                            ),
                            Text(
                              '-₹${widget.itemDiscount}',
                              style: size14_M_medium(
                                  textColor: const Color(0xff00B800)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const DottedLine(
                          dashColor: Color(0xffEAEAEA),
                          lineThickness: 2,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery Tip',
                              style:
                                  size14_M_regular(textColor: accountSmallText),
                            ),
                            Text(
                              '₹${widget.deliveryTip}',
                              style:
                                  size14_M_medium(textColor: accountSmallText),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Platform fee',
                              style:
                                  size14_M_regular(textColor: accountSmallText)
                                      .copyWith(
                                          decoration: TextDecoration.underline,
                                          decorationStyle:
                                              TextDecorationStyle.dotted,
                                          decorationThickness: 2),
                            ),
                            Text(
                              '₹${widget.platformFee}',
                              style:
                                  size14_M_medium(textColor: accountSmallText),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'GST and Restaurant Charges',
                              style:
                                  size14_M_regular(textColor: accountSmallText)
                                      .copyWith(
                                          decoration: TextDecoration.underline,
                                          decorationStyle:
                                              TextDecorationStyle.dotted,
                                          decorationThickness: 2),
                            ),
                            Text(
                              '-₹${widget.gstAndResturantCharges}',
                              style:
                                  size14_M_medium(textColor: accountSmallText),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const DottedLine(
                          dashColor: Color(0xffEAEAEA),
                          lineThickness: 2,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Paid Via Upi',
                              style:
                                  size14_M_regular(textColor: accountSmallText),
                            ),
                            Text(
                              'Bill Total ₹${widget.billTotal}',
                              style:
                                  size14_M_medium(textColor: accountSmallText),
                            )
                          ],
                        ),
                      ],
                    ),
              const SizedBox(
                height: 30,
              ),
              !(widget.itemCount == widget.index + 1)
                  ? const DottedLine(
                      dashGapLength: 6,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}

class PastOrderCustomButton extends StatelessWidget {
  const PastOrderCustomButton({
    super.key,
    required this.color,
    required this.onTap,
    required this.title,
  });
  final Color color;
  final Function onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 42,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: color),
            borderRadius: BorderRadius.circular(4)),
        child: Center(
            child: Text(
          title,
          style: size12_M_bold(textColor: color),
        )),
      ),
    );
  }
}

class ListOfContainers extends StatelessWidget {
  const ListOfContainers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListContainerWidget(
          title: 'Addresses',
          onTap: () {
            Get.to(() => MyAddressScreen());
          },
          isSubtitle: true,
          subTitle: 'Edit & Add New Addresses',
        ),
        ListContainerWidget(
          title: 'Refund',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RefundStatusScreen(),
              ),
            );
          },
          isSubtitle: true,
          subTitle: 'Refund Status, Refund Policy',
        ),
        ListContainerWidget(
          title: 'Contact Us',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ContactUsScreen(),
              ),
            );
          },
        ),
        ListContainerWidget(
          title: 'About Us',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AboutUs(),
              ),
            );
          },
        ),
        ListContainerWidget(
          title: 'Terms & Conditions',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TermsConditionScreen(),
              ),
            );
          },
        ),
        ListContainerWidget(
          title: 'FAQ’s',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FaqScreen(),
              ),
            );
          },
        ),
        ListContainerWidget(
          title: 'Shipping policy',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ShippingDetailsScreen(),
              ),
            );
          },
          isDivider: false,
        ),
        // ListContainerWidget(
        //   title: 'Disclaimer',
        //   onTap: () {},
        //   isDivider: false,
        // ),
      ],
    );
  }
}

class ListContainerWidget extends StatelessWidget {
  const ListContainerWidget({
    super.key,
    required this.title,
    this.subTitle = '',
    required this.onTap,
    this.isSubtitle = false,
    this.isDivider = true,
  });
  final String title;
  final String subTitle;
  final Function onTap;
  final bool isSubtitle;
  final bool isDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: size15_M_medium_black(),
                ),
                isSubtitle
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            subTitle,
                            style: size12_M_medium(textColor: accountSmallText),
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
              ],
            ),
            IconButton(
                onPressed: () => onTap(),
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13,
                  color: accountSmallText,
                ))
          ],
        ),
        isDivider
            ? const Divider(
                height: 5,
                color: dividerColor,
              )
            : const SizedBox.shrink()
      ],
    );
  }
}

class MyAccountHeadParts extends StatelessWidget {
  // const MyAccountHeadParts({
  //   super.key,
  // });
  MyAccountHeadParts({super.key}) {
    Get.lazyPut(() => UserProfileController());
  }
  final UserProfileController userProfileController =
      Get.find<UserProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = userProfileController.userProfile.value;
      if (userProfileController.isLoading.value) {
        return ShimmerLoadingWidget();
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // 'UDAY',
              user.name ?? 'No Name',
              style: size15_M_medium_black().copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Text(
              // '+91 - 9876453627  .  uday123@gmail.com',
              '${user.mobile ?? ''}  .   ${user.email ?? ''}',
              style: size12_M_medium(textColor: accountSmallText),
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
                onTap: () {
                  Get.to(() => EditProfileScreen(
                      // email: user.email ?? '',
                      // mobile: user.mobile ?? '',
                      // name: user.name ?? '',
                      ));
                },
                child: SizedBox(
                    child: Text(
                  'Edit Profile >',
                  style: size16_M_bold(textColor: primaryOrange),
                ))),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 2,
              color: blackType1,
            ),
          ],
        );
      }
    });
  }
}
