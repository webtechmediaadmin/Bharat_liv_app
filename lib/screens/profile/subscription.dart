import 'package:flutter/material.dart';

import '../bottom_nav_screen.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
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
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavBar(currentIndex: 3),
                                ),
                              );
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Color(0xffFFFFFF),
                                  size: 20,
                                ))
                          ],
                        ),
                        Center(
                          child: Text(
                            "ONLINE STREAMING",
                            style: TextStyle(
                                color: Color(0xffFFFFFF), fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            "Choose Your Plan",
                            style: TextStyle(
                                color: Color(0xffFFFFFF), fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildMainContainer("349", "12"),
                        const SizedBox(height: 10),
                        _buildMainContainer("199", "6"),
                        const SizedBox(height: 10),
                        _buildMainContainer("129", "3")
                      ],
                    ))),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContainer(String text, text1) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Color(0xffFFFFFF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xffFEFEFE).withOpacity(0.2))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
            child: Column(
              children: [
                Text(
                  "₹ $text",
                  style: TextStyle(fontSize: 16, color: Color(0xffFFFFFF)),
                ),
                Text(
                  "$text1 Months",
                  style: TextStyle(fontSize: 16, color: Color(0xffFFFFFF)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildText("Video Quality", "Better"),
          const Divider(color: Color(0xffFFFFFF)),
          const SizedBox(height: 20),
          _buildText("Resolution", "1080p"),
          const Divider(color: Color(0xffFFFFFF)),
          const SizedBox(height: 20),
          _buildText("Screen You Can Watch", "1"),
          const Divider(color: Color(0xffFFFFFF)),
          const SizedBox(height: 20),
          _buildText("No Cancellation", ""),
          const Divider(color: Color(0xffFFFFFF)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0xff990299).withOpacity(0.5))),
            child: Text(
              "Buy Now",
              style: TextStyle(fontSize: 15, color: Color(0xffFFFFFF)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildText(String text, text1) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          Icon(Icons.check, size: 15, color: Color(0xffFFFFFF)),
          const SizedBox(
            width: 30,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 15, color: Color(0xffFFFFFF)),
          )
        ],
      ),
      Text(
        text1,
        style: const TextStyle(fontSize: 15, color: Color(0xffFFFFFF)),
      )
    ]);
  }
}
