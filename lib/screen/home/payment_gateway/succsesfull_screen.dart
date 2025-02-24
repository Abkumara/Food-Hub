import 'package:flutter/material.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/screens/tab_controller.dart';

class SuccessfulScreen extends StatefulWidget {
  const SuccessfulScreen({super.key});

  @override
  State<SuccessfulScreen> createState() => _SuccessfulScreenState();
}

class _SuccessfulScreenState extends State<SuccessfulScreen> {
  bool _moveBike = false;
  bool _moveWords = false;
  bool _switchImages = false;
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _moveBike = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() {
        _moveWords = true;
      });
    });
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _switchImages = true;
      });
    });
    Future.delayed(const Duration(seconds: 6), () {
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TabScreen(),
            ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 120),
        child: Center(
          child: Container(
            height: 450,
            width: double.infinity,
            color: colorWhite,
            child: Stack(
              children: [
                Image.asset(
                  !_switchImages
                      ? 'assets/images/pr.png'
                      : 'assets/images/rec.png',
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                AnimatedPositioned(
                  duration: const Duration(seconds: 5),
                  curve: Curves.easeInOut,
                  bottom: _moveBike
                      ? width * 0.85
                      : -width * 0.04, // Final and initial positions
                  left: _moveBike ? width : -width * 0.43,
                  child: Image.asset(
                    'assets/images/bike.png',
                    width: 100,
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(seconds: 4),
                  curve: Curves.linear,
                  bottom: _moveWords
                      ? width * 0.5
                      : -width * 0.44, // Final and initial positions
                  left: _moveWords ? 0 : -width * 1.5, // Adjusted left position
                  child: Transform.rotate(
                    angle: 32 * (-3.14 / 180),
                    child: Container(
                      color: const Color(0xFF4C4A4A),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: const Text(
                        'Payment Successful',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          letterSpacing: 6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
