import 'package:bharat_liv/screens/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../constant/app_preferences.dart';
import '../constant/constant.dart';
import 'auth_screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    getValues();
    checkUserIsLoggedInOrNot();
     _controller = VideoPlayerController.asset('assets/videos/splash.mp4')
        ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        // Video has finished playing, navigate to the next screen
        Future.delayed(const Duration(seconds: 6), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
         });
      }
    });
  }

  getValues() async {
    var token = await PreferencesApp().getAccessToken();
    MyConstant.access_token = token ?? "";
    print(
        "first time user access ${MyConstant.access_token = token ?? "empty token"}");
  }

  checkUserIsLoggedInOrNot() async {


    // print(sharedPreferences?.getBool("isLoggedIn"));
    Future.delayed(const Duration(seconds: 6), () async {
    
      bool? myBoolValue = await PreferencesApp().getIsNewUser();
      print("is new user ${myBoolValue}");
      String? userToken = await PreferencesApp().getAccessToken();
      print("token given ${userToken}");

     
      if (myBoolValue == true && userToken != null) {
        print("alllllllll");
        
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBar(currentIndex: 0)),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      }
     
    });
  }


    @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}