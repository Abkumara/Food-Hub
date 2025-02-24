import 'package:flutter/material.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/screens/tab_controller.dart';
import 'package:ksn_mobile_customer/widgets/custom_button.dart';

class ConfirmLocationScreen extends StatefulWidget {
  const ConfirmLocationScreen({super.key});

  @override
  State<ConfirmLocationScreen> createState() => _ConfirmLocationScreenState();
}

class _ConfirmLocationScreenState extends State<ConfirmLocationScreen> {
  String selectedButton = '';
  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: AppBar(
            flexibleSpace: Stack(
              children: [
                Positioned.fill(
                    child: Image.asset(
                  'assets/images/appbar_img.png',
                  fit: BoxFit.fill,
                )),
              ],
            ),
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_circle_left_sharp,
                  color: colorWhite,
                  size: 45,
                )),
          )),
      backgroundColor: dividerColor,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(20), topStart: Radius.circular(20)),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      width: 220,
                      child: Text(
                        softWrap: true,
                        'Nandhani enclave , Ayyapa Society ,100feet road Madhapur 500018, H... ',
                        style: size12_M_regular(
                            textColor: const Color(0xff8F8B8B)),
                      )),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'House / Flat / Floor no :',
                        labelStyle:
                            size14_M_bold(textColor: const Color(0xff777A81)),
                        floatingLabelStyle:
                            size14_M_bold(textColor: const Color(0xff777A81))),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Appartment / Road / Area (Optional)',
                        labelStyle:
                            size14_M_bold(textColor: const Color(0xff777A81)),
                        floatingLabelStyle:
                            size14_M_bold(textColor: const Color(0xff777A81))),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Save As',
                        style: size14_M_bold(textColor: accountSmallText),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: HomeWorkButton(
                              isSelected: selectedButton == 'Home',
                              icons: Icons.home_outlined,
                              title: 'Home',
                              onTap: () {
                                setState(() {
                                  selectedButton = 'Home';
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: HomeWorkButton(
                                icons: Icons.work_outline,
                                isSelected: selectedButton == 'Work',
                                title: 'Work',
                                onTap: () {
                                  setState(() {
                                    selectedButton = 'Work';
                                  });
                                },
                              )),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: keyboardHeight == 0 ? 0 : -keyboardHeight,
              left: 0,
              right: 0,
              child: CustomButton(
                opacity: selectedButton == '' ? 0.3 : 1,
                text: 'CONFIRM LOCATION',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TabScreen(),
                      ));
                },
                isWhite: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeWorkButton extends StatelessWidget {
  const HomeWorkButton({
    super.key,
    required this.title,
    required this.icons,
    required this.onTap,
    required this.isSelected,
  });
  final String title;
  final bool isSelected;
  final IconData icons;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 90,
        height: 30,
        decoration: BoxDecoration(
            color: isSelected ? primaryOrange : colorWhite,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: isSelected ? Colors.transparent : blackType1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icons,
              size: 15,
              color: isSelected ? colorWhite : blackType1,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: size14_M_bold(
                  textColor: isSelected ? colorWhite : blackType1),
            ),
          ],
        ),
      ),
    );
  }
}
