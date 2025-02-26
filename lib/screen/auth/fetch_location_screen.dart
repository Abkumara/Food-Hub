import 'package:flutter/material.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/screen/tab_controller.dart';

class FetchLocationScreen extends StatefulWidget {
  const FetchLocationScreen({super.key, required this.location});
  final String location;

  @override
  State<FetchLocationScreen> createState() => _FetchLocationScreenState();
}

class _FetchLocationScreenState extends State<FetchLocationScreen> {
  bool isFetch = true;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        isFetch = false;
      });
    });
    Future.delayed(const Duration(milliseconds: 5000), () {
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TabScreen(),
            ));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/location.png'),
            const SizedBox(
              height: 24,
            ),
            isFetch
                ? Text(
                    'Fetching your Address...',
                    style: size16_M_regular().copyWith(color: primaryOrange),
                  )
                : Text(
                    'Your Address is',
                    style: size16_M_regular().copyWith(color: primaryOrange),
                  ),
            const SizedBox(
              height: 24,
            ),
            !isFetch
                ? SizedBox(
                    width: 180,
                    child: Center(
                      child: Text(
                        widget.location,
                        style: size16_M_bold().copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
