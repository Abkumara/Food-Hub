import 'package:flutter/material.dart';
import 'package:foods_hub/screen/auth/login_page.dart';
import 'package:foods_hub/screen/tab_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _middleImageDrop;
  late Animation<double> _middleImageResize;
  late Animation<double> _leftImageSlide;
  late Animation<double> _rightImageSlide;
  late Animation<double> _leftImageRotation;
  late Animation<double> _rightImageRotation;

  bool showWhiteScreen = true;

  @override
  void initState() {
    super.initState();

    // Display white screen for 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showWhiteScreen = false;
      });

      // Start the animation
      _controller.forward();
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // Middle image drops from the top
    _middleImageDrop = Tween<double>(begin: -300, end: 300).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.2)),
    );

    // Middle image scales down
    _middleImageResize = Tween<double>(begin: 3.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.4)),
    );

    // Left image slides in from the left
    _leftImageSlide = Tween<double>(begin: -300, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.4)),
    );

    // Right image slides in from the right
    _rightImageSlide = Tween<double>(begin: -300, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.4)),
    );

    // Left image rotation
    _leftImageRotation = Tween<double>(begin: 3.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.4)),
    );

    // Right image rotation
    _rightImageRotation = Tween<double>(begin: -2.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.4)),
    );
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isLoggedIn = preferences.getBool('isLoggedIn') ?? false;

    await Future.delayed(const Duration(seconds: 5)); // Splash screen delay

    if (isLoggedIn) {
      Get.off(() => const TabScreen()); // Navigate to Home if logged in
    } else {
      Get.off(
          () => const LoginPage()); // Navigate to OTP screen if not logged in
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // // Redirect to LoginPage after 5 seconds
    // Future.delayed(const Duration(seconds: 5), () {
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const LoginPage(),
    //       ));
    // });

    return Scaffold(
      backgroundColor: Colors.white,
      body: showWhiteScreen
          ? const Center(child: SizedBox.shrink()) // White screen for 2 seconds
          : AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                if (_controller.value > 0.42) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: double.infinity,
                      ),
                    ),
                  );
                }

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Middle Image
                    Positioned(
                      top: _middleImageDrop.value,
                      child: Transform.scale(
                        scale: _middleImageResize.value,
                        child: Image.asset(
                          'assets/images/s.png',
                          width: screenWidth * 0.5,
                          height: screenWidth * 0.5,
                        ),
                      ),
                    ),
                    // Left Image
                    Positioned(
                      left: _leftImageSlide.value,
                      top: 300,
                      child: Transform.rotate(
                        angle: _rightImageRotation.value,
                        child: Image.asset(
                          'assets/images/k.png',
                          width: screenWidth * 0.5,
                          height: screenWidth * 0.5,
                        ),
                      ),
                    ),
                    // Right Image
                    Positioned(
                      right: _rightImageSlide.value,
                      top: 300,
                      child: Transform.rotate(
                        angle: _leftImageRotation.value,
                        child: Image.asset(
                          'assets/images/nl.png',
                          width: screenWidth * 0.5,
                          height: screenWidth * 0.5,
                        ),
                      ),
                    ),
                    // Text under the images
                    Positioned(
                      left: _leftImageSlide.value,
                      top: screenWidth * 0.5 + 160,
                      child: Image.asset(
                        'assets/images/ulogo.png',
                        width: screenWidth * 0.7,
                        height: screenWidth * 0.7,
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
