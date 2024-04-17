import 'dart:ui';

import 'package:bharat_liv/services/categories_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/api_routes.dart';
import '../services/speakers_services.dart';
import '../services/trending_services.dart';
import '../services/user_profile.dart';
import 'biography_screen.dart';
import 'video_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final UserProfileController userProfileController = Get.find();
  final CategoriesController categoriesController = Get.find();
  final SpeakersController speakersController = Get.find();
  final TrendingController trendingController = Get.find();
  PageController _pageController = PageController();
  final RxInt _currentPage = 0.obs;
  late TabController _tabController;

  int? currentIndex;
  bool _subscribed = false;

  @override
  void initState() {
    // TODO: implement initState
    userProfileController.fetchUserProfile();
    categoriesController.categoriesFetch();
    speakersController.speakersFetch();
    trendingController.trendingFetch(ApiRoutes.trendingVideosApi);
    trendingController.trendingFetch(ApiRoutes.bannerApi, isBanner: true);
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    currentIndex = 0;
    // Future.delayed(Duration(seconds: 5), () {
    //   // Check subscription status (example: assuming user hasn't subscribed)
    //   setState(() {
    //     _subscribed = false;
    //     // Show bottom sheet if user is not subscribed
    //     if (!_subscribed) {
    //       showPremiumBottomSheet(context);
    //     }
    //   });
    // });
  }

  List<String> items = [
    "Motivotional",
    "Series",
    "Songs",
    "Bhajan",
    "Speeches"
  ];

  List<String> itemsText = [
    "आखिर भरत जी को क्यों बनना पड़ा था मृग? Devkinandan Thakur Ji Facts | Katha",
    "आखिर भरत जी को क्यों बनना पड़ा था मृग? Devkinandan Thakur Ji Facts | Katha",
    "आखिर भरत जी को क्यों बनना पड़ा था मृग? Devkinandan Thakur Ji Facts | Katha"
  ];

  List<String> images = [
    "assets/images/image1.png",
    "assets/images/image2.png",
    "assets/images/image3.png"
  ];

  List<String> videos = [
    "assets/images/image4.png",
    "assets/images/image4.png",
    "assets/images/image5.png"
  ];

  @override
  Widget build(BuildContext context) {
    print("UserName ${userProfileController.userProfile.value.data?.name}");
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
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    const Color(0xffD9D9D9).withOpacity(0.3),
                                backgroundImage: (userProfileController
                                            .userProfile.value.data?.image !=
                                        null)
                                    ? NetworkImage(
                                        userProfileController
                                                .userProfile.value.data?.image ??
                                            "",
                                      )
                                    : const AssetImage(
                                            'assets/images/user_image.png')
                                        as ImageProvider, // User image
                                radius: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Hi, ${userProfileController.userProfile.value.data?.name ?? "Username"}",
                                style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 16 // Username text color
                                    ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.white, // Notification icon color
                            ),
                            onPressed: () {
                              // Add your notification icon onPressed action here
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Watch and enjoy \nYour favorite video !",
                      style: TextStyle(
                          color: Color(0xffFAFAFA),
                          fontSize: 20 // Username text color
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
                            height: 45,
                            decoration: BoxDecoration(
                                color: Color(0xffFFFFFF).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color(0xffFEFEFE).withOpacity(0.2))),
                            child: const Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Color(0xffFFFFFF),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Which is your favorite....",
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xffC3C3C3)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                            height: 45,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xffFFFFFF).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color(0xffFEFEFE).withOpacity(0.2))),
                            child: Icon(
                              Icons.mic,
                              color: Color(0xffFFFFFF),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => Center(
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage.value = index;
                              });
                            },
                            itemCount:
                                trendingController.trendingDataList.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                trendingController.trendingDataList[index]
                                            .thumbNail !=
                                        null
                                    ? (trendingController
                                        .trendingDataList[index].thumbNail!)
                                    : "assets/images/banner.png",
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                categoriesController.categoryDataList.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                width: 90,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: const Color(0xffFFFFFF)
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Color(0xffFEFEFE)
                                            .withOpacity(0.2))),
                                child: Center(
                                  child: Text(
                                    categoriesController
                                        .categoryDataList[index].title!,
                                    style: const TextStyle(
                                        fontSize: 12, color: Color(0xffFFFFFF)),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildText("Our Speakers", "View All"),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  speakersController.speakerDataList.length,
                              itemBuilder: (ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BioGraphScreen(
                                              id: speakersController.speakerDataList[index].id.toString(),
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          speakersController
                                              .speakerDataList[index].image!,
                                          height: 120,
                                          width: 150,
                                        ),
                                        const SizedBox(height: 5),
                                        Center(
                                          child: Text(
                                            speakersController
                                                .speakerDataList[index].name!,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffFFFFFF)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildText("Trending Vidoes", "View All"),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  trendingController.trendingDataList.length,
                              itemBuilder: (ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VideoApp(
                                            id: trendingController
                                                .trendingDataList[index].id
                                                .toString(),
                                            videoTitle: trendingController
                                                .trendingDataList[index].video!,
                                            videoName: trendingController
                                                .trendingDataList[index].title!,
                                            mainImage: trendingController
                                                .trendingDataList[index]
                                                .user!
                                                .image!,
                                            mainName: trendingController
                                                .trendingDataList[index]
                                                .user!
                                                .name!),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          trendingController
                                              .trendingDataList[index]
                                              .thumbNail!,
                                          height: 120,
                                          width: 150,
                                        ),
                                        const SizedBox(height: 5),
                                        Center(
                                          child: Text(
                                            trendingController
                                                .trendingDataList[index].title!,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffFFFFFF)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )),
                    _buildText("Recently Viewed", "View All"),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildTrendingVideos(images, itemsText),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContainer(String text) {
    return Container(
      width: text.length * 20,
      decoration: BoxDecoration(
        color: Color(0xffFFFFFF).withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xffFEFEFE).withOpacity(0.2),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: Color(0xffFFFFFF),
        ),
      ),
    );
  }

  Widget _buildText(String text, text1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 15, color: Color(0xffFFFFFF)),
        ),
        Text(
          text1,
          style: const TextStyle(
              fontSize: 10,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xffFFFFFF),
              color: Color(0xffFFFFFF)),
        )
      ],
    );
  }

  Widget _buildTrendingVideos(List<String> text, text1) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: text.length,
          itemBuilder: (ctx, index) {
            return Container(
              margin: const EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  Image.asset(
                    text[index],
                    height: 120,
                    width: 150,
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      text1[index],
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xffFFFFFF)),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
