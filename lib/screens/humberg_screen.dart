import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/user_profile.dart';
import 'profile/history_screen.dart';
import 'profile/profile_detail.dart';
import 'profile/subscription.dart';

class HumbergerScreen extends StatefulWidget {
  const HumbergerScreen({super.key});

  @override
  State<HumbergerScreen> createState() => _HumbergerScreenState();
}

class _HumbergerScreenState extends State<HumbergerScreen> {
  final UserProfileController userProfileController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    userProfileController.fetchUserProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/homebg.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    right: MediaQuery.of(context).size.width *
                        0.03, // 5% padding horizontally
                    top: MediaQuery.of(context).size.height * 0.04,
                    bottom: MediaQuery.of(context).size.height *
                        0.07, // 2% padding vertically
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(0xffD9D9D9),
                                backgroundImage: (userProfileController
                                            .userProfile.value.data?.image !=
                                        null)
                                    ? NetworkImage(
                                        userProfileController.userProfile.value
                                                .data?.image ??
                                            "",
                                      )
                                    : const AssetImage(
                                            'assets/images/user_image.png')
                                        as ImageProvider, // User image
                                radius: 35,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userProfileController
                                            .userProfile.value.data?.name ??
                                        "Username",
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize: 20 // Username text color
                                        ),
                                  ),
                                  Text(
                                    "+91${userProfileController.userProfile.value.data?.phoneNumber ?? ""}",
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize: 14 // Username text color
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 15,
                              // Notification icon color
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProfileDetail(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Color(0xffFEFEFE).withOpacity(0.2))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Subscibe To Enjoy ",
                                  style: TextStyle(
                                      color: Color(0xffFFFFFF), fontSize: 16),
                                ),
                                Text(
                                  "Bharat Liv",
                                  style: TextStyle(
                                      color: Color(0xffFFFFFF), fontSize: 16),
                                ),
                                Text(
                                  "${userProfileController.userProfile.value.data?.phoneNumber ?? ""}",
                                  style: TextStyle(
                                      color: Color(0xffFFFFFF), fontSize: 10),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFF990299),
                                          Color(0xFF330133)
                                        ], // Example gradient colors
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "Subscribe Now",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffFFFFFF)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Plan Start At ',
                                        style: TextStyle(
                                            color: Color(0xffFFFFFF),
                                            fontSize: 10),
                                      ),
                                      TextSpan(
                                        text: '₹129',
                                        style: TextStyle(
                                            color: Color(0xffFFFFFF),
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Color(0xffFFFFFF).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color:
                                          Color(0xffFEFEFE).withOpacity(0.2))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/vec1.png",
                                    height: 15,
                                    width: 15,
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    "Playlist",
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF), fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HistoryScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Color(0xffFFFFFF).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Color(0xffFEFEFE)
                                            .withOpacity(0.2))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/vec2.png",
                                      height: 15,
                                      width: 15,
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      "History",
                                      style: TextStyle(
                                          color: Color(0xffFFFFFF),
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildText("assets/images/vec3.png", "Notifications"),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SubscriptionScreen(),
                              ),
                            );
                          },
                          child: _buildText(
                              "assets/images/vec4.png", "Plans And Offers")),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildText("assets/images/vec5.png", "Language"),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildText("assets/images/vec6.png", "Settings"),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildText("assets/images/vec7.png", "About Us"),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildText("assets/images/vec8.png", "Log Out")
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String text, text1) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color(0xffFFFFFF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xffFEFEFE).withOpacity(0.2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            text,
            height: 15,
            width: 15,
          ),
          const SizedBox(width: 20),
          Text(
            text1,
            style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16),
          ),
        ],
      ),
    );
  }
}
