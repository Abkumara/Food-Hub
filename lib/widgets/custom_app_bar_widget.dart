import 'package:flutter/material.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBack;

  const CustomAppBar({super.key, required this.title, this.isBack = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: colorWhite,
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: -1,
      scrolledUnderElevation: 0,
      leading: isBack
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
                color: titleColor,
              ))
          : const SizedBox.shrink(),
      title: Text(
        title,
        style: size16_M_bold().copyWith(color: blackType1),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
