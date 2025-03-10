import 'package:flutter/material.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/core/widgets/custome_search_bar.dart';
import 'package:foods_hub/widgets/custom_app_bar_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Search location to add my address'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SearchInputField(
              height: 55,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 17, horizontal: 35),
              validator: (p0) {},
              hintText: 'Try Ayyapa  Society Road etc...',
              borderColor: borderColor,
              border: Border.all(width: 2),
              suffixIcon: const Icon(
                Icons.search,
                size: 30,
                color: borderColor,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: 3.14 / 4,
                  child: const Icon(
                    Icons.navigation,
                    color: primaryOrange,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Use my current location',
                  style: size16_M_bold(textColor: primaryOrange),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
