import 'package:flutter/material.dart';
import 'package:foods_hub/controller/theme_controller/theme_controller.dart';
import 'package:foods_hub/screen/other/splash_screen.dart';
import 'package:get/get.dart';

class KsnApp extends StatefulWidget {
  const KsnApp({super.key});

  @override
  State<KsnApp> createState() => _KsnAppState();
}

class _KsnAppState extends State<KsnApp> {
  @override
  void initState() {
    super.initState();
    _initServices();
  }

  void _initServices() {
    Get.put<ThemeController>(ThemeController(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ksn catering',
      themeMode: ThemeMode.light,
      theme: themeController.theme,
      home: const SplashScreen(),
    );
  }
}
