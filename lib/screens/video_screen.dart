import 'dart:ui';

import 'package:bharat_liv/models/bio_models.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../constant/constant.dart';
import '../services/bio_services.dart';
import '../services/like_comments_services.dart';
import '../services/user_profile.dart';
import 'biography_screen.dart';
import 'bottom_nav_screen.dart';
import 'profile/subscription.dart';

class VideoApp extends StatefulWidget {
  String id;
  String videoTitle;
  String videoName;
  String? mainImage;
  String? mainName;
  List<BioData>? recommendedVideos;
  List<Like>? likes;
  String? userId;
  VideoApp(
      {super.key,
      required this.id,
      required this.videoTitle,
      required this.videoName,
      this.mainImage,
      this.mainName,
      this.recommendedVideos,
      this.likes,
      this.userId});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  final UserProfileController userProfileController = Get.find();
  final LikeCommentController likeCommentController = Get.find();
  final TextEditingController _commentController = TextEditingController();
  final BioController bioController = Get.find();
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool bottomSheetShown = false;
  late List<BioData> filteredVideo;
  late List<Like> filteredLikes;
  final FocusNode _focusNode = FocusNode();
  bool _isKeyboardVisible = false;
  final RxBool isCommentEmpty = true.obs;

  Map<String, int> likesCounts = {};

  @override
  void initState() {
    //  widget.id;
    print("ID's ${widget.id}");

    super.initState();
    userProfileController.fetchUserProfile();
    bioController.bioFetchData(widget.id);

    filteredVideo = widget.recommendedVideos?.where((video) {
          print("Filtered id ${video.id}");
          return video.id != int.parse(widget.id);
        }).toList() ??
        [];

    _initializeVideoPlayer();
    _focusNode.addListener(_onFocusChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      likeCommentController.likeCount.value = widget.likes!.length;
      _checkIfUserHasLiked();
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _videoPlayerController.dispose();
    _chewieController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isKeyboardVisible = _focusNode.hasFocus;
    });
  }

  Future<void> _initializeVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoTitle);
    await _videoPlayerController.initialize().then((value) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          aspectRatio: _videoPlayerController.value.aspectRatio,
          autoPlay: true,
          looping: false,
          allowFullScreen: true,
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
        bottomSheetShown = true;
        _videoPlayerController.pause().then((value) {
          showPremiumBottomSheet(context);
        });
      }
    }
  }

  void _checkIfUserHasLiked() {
    likeCommentController.userHasLiked.value = widget.likes!.any((like) =>
        like.userId == userProfileController.userProfile.value.data!.id);
  }

  Future<void> toggleLike(String id) async {
    // Optimistically update the UI
    bool newLikeStatus = !likeCommentController.userHasLiked.value;
    likeCommentController.userHasLiked.value = newLikeStatus;
    newLikeStatus
        ? likeCommentController.likeCount.value++
        : likeCommentController.likeCount.value--;

    try {
      if (newLikeStatus) {
        await likeCommentController.likeVideo(id);
      } else {
        await likeCommentController.unlikeVideo(id);
      }

      // Fetch updated likes count
      await bioController.bioFetchData(widget.id);

      // Update the likes count from the fetched data
      BioData updatedBioData = bioController.bioModel.value.data?.firstWhere(
            (data) => data.id.toString() == widget.id,
            orElse: () => BioData(), // Provide a default BioData object
          ) ??
          BioData();

      setState(() {
        likeCommentController.likeCount.value =
            updatedBioData.likes?.length ?? 0;
        print("COUNT ${likeCommentController.likeCount.value}");
      });
    } catch (error) {
      // Revert the optimistic update in case of an error
      likeCommentController.userHasLiked.value = !newLikeStatus;
      newLikeStatus
          ? likeCommentController.likeCount.value--
          : likeCommentController.likeCount.value++;
      print('Error toggling like: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("LIKES ${likeCommentController.userHasLiked.value}");
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BioGraphScreen(
                                  id: widget.userId.toString(),
                                )));
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
                              ? NetworkImage(widget.mainImage!)
                              : const AssetImage('assets/images/user_image.png')
                                  as ImageProvider, // User image
                          radius: 25,
                        ),
                        const SizedBox(
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
                        userProfileController
                                    .userProfile.value.data?.paidMember ==
                                true
                            ? IconButton(
                                icon: const Icon(
                                  Icons.download,
                                  color:
                                      Colors.white, // Notification icon color
                                ),
                                onPressed: () {
                                  print("download");
                                  //  _downloadVideo();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BottomNavBar(
                                        currentIndex: 2,
                                      ),
                                    ),
                                  );
                                  // Add your notification icon onPressed action here
                                },
                              )
                            : const SizedBox(),
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
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                //margin: EdgeInsets.all(5),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xffFFFFFF).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Obx(() => Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            print("vIdEo ${widget.id}");
                                            toggleLike(widget.id);
                                          },
                                          child: Image.asset(
                                            likeCommentController
                                                    .userHasLiked.value
                                                ? "assets/images/likr.png"
                                                : "assets/images/like.png",
                                            key: ValueKey(likeCommentController
                                                .userHasLiked.value),
                                            height: 22,
                                            width: 22,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          "Like",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xffFFFFFF)),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Obx(() => Text(
                                              likeCommentController
                                                  .likeCount.value
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Color(0xffFFFFFF),
                                              ),
                                            )),
                                      ],
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              Container(
                                //margin: EdgeInsets.all(5),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xffFFFFFF).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset("assets/images/share.png",
                                        height: 15, width: 18),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Share",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xffFFFFFF)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 7,
                                      blurRadius: 6,
                                      offset: Offset(
                                          3, 0), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: ClipPath(
                                  clipper: MyCustomClipper1(),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaY: 17, sigmaX: 17),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15.0, top: 10.0),
                                            child: Text(
                                              "Comments",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10),
                                            height: 1,
                                            color: Colors.white.withOpacity(
                                                0.2), // Opacity added to color
                                          ),
                                          Obx(
                                            () => Expanded(
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: bioController
                                                    .bioModel
                                                    .value
                                                    .data!
                                                    .first
                                                    .comments!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              const Color(
                                                                      0xffD9D9D9)
                                                                  .withOpacity(
                                                                      0.3),
                                                          backgroundImage: (bioController
                                                                      .bioModel
                                                                      .value
                                                                      .data![0]
                                                                      .comments![
                                                                          index]
                                                                      .user!
                                                                      .image !=
                                                                  null)
                                                              ? NetworkImage(
                                                                  bioController
                                                                      .bioModel
                                                                      .value
                                                                      .data![0]
                                                                      .comments![
                                                                          index]
                                                                      .user!
                                                                      .image!)
                                                              : const AssetImage(
                                                                      'assets/images/user_image.png')
                                                                  as ImageProvider, // User image
                                                          radius: 18,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          bioController
                                                                      .bioModel
                                                                      .value
                                                                      .data![0]
                                                                      .comments![
                                                                          index]
                                                                      .text !=
                                                                  null
                                                              ? bioController
                                                                  .bioModel
                                                                  .value
                                                                  .data![0]
                                                                  .comments![
                                                                      index]
                                                                  .text!
                                                              : "",
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xffFFFFFF),
                                                              fontSize:
                                                                  16 // Username text color
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10),
                                            height: 1,
                                            color: Colors.white30.withOpacity(
                                                0.2), // Opacity added to color
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        width: 1.0),
                                                  ),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        const Color(0xffD9D9D9)
                                                            .withOpacity(0.3),
                                                    backgroundImage: (widget
                                                                .mainImage !=
                                                            null)
                                                        ? NetworkImage(
                                                            widget.mainImage!)
                                                        : const AssetImage(
                                                                'assets/images/user_image.png')
                                                            as ImageProvider, // User image
                                                    radius: 15,
                                                    // Border color
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: TextField(
                                                      focusNode: _focusNode,
                                                      controller:
                                                          _commentController,
                                                      onChanged: (value) {
                                                        isCommentEmpty.value =
                                                            value
                                                                .trim()
                                                                .isEmpty;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  "Add a comment...",
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.3), // Grey background color with transparency
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0), // Border radius
                                                                borderSide:
                                                                    BorderSide
                                                                        .none, // No border
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          10.0,
                                                                      vertical:
                                                                          0.0) // No border

                                                              ),
                                                      style: const TextStyle(
                                                          color: Colors.white)),
                                                ),
                                                Obx(
                                                  () => Visibility(
                                                    visible: _isKeyboardVisible,
                                                    child: IconButton(
                                                      icon: isCommentEmpty.value
                                                          ? Icon(
                                                              Icons
                                                                  .send_outlined,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          : Icon(
                                                              Icons.send,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      // Inside your onPressed callback for the send button
                                                      onPressed:
                                                          isCommentEmpty.value
                                                              ? null
                                                              : () async {
                                                                  print(
                                                                      "COMMENT ${_commentController.text}");
                                                                  if (_commentController
                                                                          .text
                                                                          .isEmpty ||
                                                                      _commentController
                                                                          .text
                                                                          .trim()
                                                                          .isEmpty) {
                                                                    showToast(
                                                                        "User comment should not be empty!");
                                                                  } else {
                                                                    // Call the API to post the comment
                                                                    await likeCommentController
                                                                        .fetchComment(
                                                                            widget
                                                                                .id,
                                                                            _commentController
                                                                                .text)
                                                                        .then(
                                                                            (_) {
                                                                      // Show a toast message indicating success
                                                                      showToast(
                                                                          "Comment posted successfully!");
                                                                      // Clear the text field
                                                                      _commentController
                                                                          .clear();
                                                                      // Hide the keyboard
                                                                      FocusScope.of(
                                                                              context)
                                                                          .unfocus();
                                                                      // Optionally, fetch updated data or perform any other actions
                                                                      bioController
                                                                          .bioFetchData(
                                                                              widget.id);
                                                                    }).catchError(
                                                                            (error) {
                                                                      // Handle errors if necessary
                                                                      print(
                                                                          "Error posting comment: $error");
                                                                      // Show a toast message indicating failure
                                                                      showToast(
                                                                          "Failed to post comment. Please try again later.");
                                                                    });
                                                                  }
                                                                },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     if (_commentController
                                          //         .text.isNotEmpty) {
                                          //       setState(() {
                                          //         comments
                                          //             .add(_commentController.text);
                                          //         _commentController.clear();
                                          //       });
                                          //     }
                                          //   },
                                          //   child: Text("Post Comment"),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          //margin: EdgeInsets.all(5),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: const Color(0xffFFFFFF).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Obx(() {
                            final comments = bioController.bioModel.value.data
                                ?.expand((entry) => entry.comments!)
                                .toList();
                            if (comments != null && comments.isNotEmpty) {
                              final comment = comments.first;
                              return Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: const Color(0xffD9D9D9)
                                        .withOpacity(0.3),
                                    backgroundImage: comment.user!.image != null
                                        ? NetworkImage(comment.user!.image!)
                                        : const AssetImage(
                                                'assets/images/user_image.png')
                                            as ImageProvider, // User image
                                    radius: 25,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      comment.text ?? "",
                                      maxLines: 2, // Limit text to 2 lines
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const Text(
                                "No comments available",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xffFFFFFF),
                                ),
                              );
                            }
                          }),
                        ),
                      )
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                child: Center(
                  child: Text(
                    "Recommended",
                    style: TextStyle(
                      color: Color(0xffFFFFFF),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 12.0,
                  ),
                  itemCount: filteredVideo.length,
                  itemBuilder: (BuildContext context, int index) {
                    var video = filteredVideo[index];

                    return GestureDetector(
                      onTap: () async {
                        // toggleLike(filteredVideo[index].id.toString());
                        print("RECOMMENDED VIDEO ID ${video.id}");
                        print("MAIN ID ${widget.id}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoApp(
                                id: filteredVideo[index].id.toString(),
                                videoTitle:
                                    filteredVideo[index].video.toString(),
                                videoName:
                                    filteredVideo[index].title.toString(),
                                mainImage: widget.mainImage,
                                mainName: widget.mainName,
                                recommendedVideos: widget.recommendedVideos,
                                likes: filteredVideo[index].likes!
                                // likes: widget.recommendedVideos[index].likes!
                                ),
                          ),
                        );
                      },
                      child: GridTile(
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  video.thumbNail ?? "",
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Center(
                              child: Text(
                                video.title ?? "",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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

class MyCustomClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 30); // Adjust this value as needed
    path.quadraticBezierTo(size.width / 2, size.height, 0,
        size.height - 30); // Adjust this value as needed
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
