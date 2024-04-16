
import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../services/user_profile.dart';
import 'bottom_nav_screen.dart';
import 'profile/subscription.dart';

class VideoApp extends StatefulWidget {
  String id;
  String videoTitle;
  String videoName;
  String mainImage;
  String mainName;
  VideoApp(
      {super.key,
      required this.id,
      required this.videoTitle,
      required this.videoName,
      required this.mainImage,
      required this.mainName});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  final UserProfileController userProfileController = Get.find();
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool bottomSheetShown = false;

  @override
  void initState() {
    widget.id;
    super.initState();
    userProfileController.fetchUserProfile();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoTitle);
    await _videoPlayerController.initialize().then((value) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          aspectRatio: _videoPlayerController.value.aspectRatio,
          autoPlay: true, // Ensure video auto plays
          looping: false, // Ensure video doesn't loop
          allowFullScreen: true, // Allow fullscreen
          showControls: true,
        );
        //  _videoPlayerController.play();
      });
    });
    _videoPlayerController.addListener(_printVideoDuration);
  }

  void _printVideoDuration() {
    Duration? duration = _videoPlayerController.value.duration;
    Duration? position = _videoPlayerController.value.position;
    print('Video Duration: $duration, Current Time: $position');
    if (userProfileController.userProfile.value.data?.paidMember != true) {
      if (!bottomSheetShown && position >= const Duration(minutes: 5)) {
        bottomSheetShown =
            true; // Set flag to true to indicate that the bottom sheet has been shown
        _videoPlayerController.pause().then((value) {
          showPremiumBottomSheet(context);
        });
      }
    }
  }

   

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set background color to black
      body: Stack(
        children: [
          Image.asset(
            "assets/images/homebg.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          // Video player and controls
          SafeArea(
              child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xffFFFFFF),
                    size: 20,
                  ),
                ),
              ),
              _videoPlayerController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: Chewie(
                        controller: _chewieController,
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                child: Text(
                  widget.videoName,
                  style: TextStyle(
                      color: Color(0xffFFFFFF),
                      fontSize: 16 // Username text color
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              const Color(0xffD9D9D9).withOpacity(0.3),
                          backgroundImage: (widget.mainImage != null)
                              ? NetworkImage(widget.mainImage)
                              : const AssetImage('assets/images/user_image.png')
                                  as ImageProvider, // User image
                          radius: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.mainName ?? "",
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 16 // Username text color
                              ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white, // Notification icon color
                          ),
                          onPressed: () {
                            // Add your notification icon onPressed action here
                          },
                        ),
                        userProfileController.userProfile.value.data?.paidMember == true ? IconButton(
                          icon: const Icon(
                            Icons.download,
                            color: Colors.white, // Notification icon color
                          ),
                          onPressed: () {
                            print("download");
                         //  _downloadVideo();
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavBar(currentIndex: 2, 
                                     
                                  ),
                                ),
                              );
                            // Add your notification icon onPressed action here
                          },
                        ): const SizedBox(),
                        IconButton(
                          icon: const Icon(
                            Icons.share,
                            color: Colors.white, // Notification icon color
                          ),
                          onPressed: () {
                            // Add your notification icon onPressed action here
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          )),
          // Back button
        ],
      ),
    );
  }

  showPremiumBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 7,
                blurRadius: 6,
                offset: Offset(3, 0), // changes position of shadow
              ),
            ],
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: ClipPath(
            clipper: MyCustomClipper(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 17, sigmaX: 17),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Upgrade to Premium!',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFFFFFF)),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Unlock exclusive content by subscribing to our premium plan.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xffFFFFFF)),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SubscriptionScreen(),
                            ),
                          );
                        },
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
                                fontSize: 16, color: Color(0xffFFFFFF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      bottomSheetShown =
          false; // Reset the flag when the bottom sheet is closed
    });
  }
}
