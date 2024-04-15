import 'dart:ui';

import 'package:bharat_liv/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'download_screen.dart';
import 'humberg_screen.dart';
import 'search_screen.dart';

class BottomNavBar extends StatefulWidget {
  int currentIndex;
  BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    DownloadScreen(),
    HumbergerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[widget.currentIndex],
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            height: 70,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 7,
                    blurRadius: 6,
                    offset: Offset(3, 0),
                  ),
                ],
                color: Colors.black.withOpacity(0.3),
              ),
              child: ClipPath(
                clipper: MyCustomClipper(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 17, sigmaX: 17),
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildNavBarItem(0, "assets/images/home.png"),
                        buildNavBarItem(1, "assets/images/search.png"),
                        buildNavBarItem(2, "assets/images/download.png"),
                        buildNavBarItem(3, "assets/images/humberger.png"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavBarItem(int index, String iconPath) {
    return GestureDetector(
      onTap: () {
        print('Tapped on index $index');
        setState(() {
          widget.currentIndex = index;
        });
      },
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: widget.currentIndex == index ? 35 : 25,
              color: Colors.white,
            ),
            const SizedBox(height: 1),
            Image.asset(
              "assets/images/navbar.png",
              width: 40,
              color: widget.currentIndex == index
                  ? Colors.white
                  : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.width);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

@override
Path getClip(Size size) {
  // TODO: implement getClip
  Path path = Path();
  path.moveTo(0, 0);
  path.lineTo(size.width, 0);
  path.lineTo(size.width, size.width);
  path.lineTo(0, size.height);
  path.lineTo(0, 0);
  path.close();
  return path;
}

@override
bool shouldReclip(CustomClipper<Path> oldClipper) {
  // TODO: implement shouldReclip
  return false;
}
