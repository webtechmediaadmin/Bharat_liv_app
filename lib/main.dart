import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'screens/splash_screen.dart';
import 'services/bio_services.dart';
import 'services/categories_services.dart';
import 'services/speakers_services.dart';
import 'services/trending_services.dart';
import 'services/user_profile.dart';
import 'widget/custom_animation.dart';

void main() {
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 4000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(0, 10, 9, 9),  // Ensure text color contrast
        ),
      
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(UserProfileController());
        Get.put(CategoriesController());
        Get.put(SpeakersController());
        Get.put(TrendingController());
        Get.put(BioController());
      }),
      home: const SplashScreen(),
    );
  }
}
