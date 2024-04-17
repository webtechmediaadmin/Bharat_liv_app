import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bharat_liv/services/bio_services.dart';
import 'bottom_nav_screen.dart';

class BioGraphScreen extends StatefulWidget {
  final String id;

  const BioGraphScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<BioGraphScreen> createState() => _BioGraphScreenState();
}

class _BioGraphScreenState extends State<BioGraphScreen> {
  final BioController bioController = Get.find();
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
     final data = bioController.bioModel.value.data;
    bioController.userProfileCategoryFetch(widget.id);
      bioController.bioFetchData(widget.id);
    if (data != null && data.isNotEmpty
        ) {
    
    } else {
      const Center(
        child: Text(
          "No Vidoes",
          style: TextStyle(
            color: Color(0xffFFFFFF),
            fontSize: 22,
          ),
        ),
      );
    }
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
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BottomNavBar(currentIndex: 0),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xffFFFFFF),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: const Color(0xffD9D9D9),
                                backgroundImage: (bioController
                                            .userProfileCategoryModel
                                            .value
                                            .data
                                            ?.image !=
                                        null)
                                    ? NetworkImage(
                                        bioController.userProfileCategoryModel
                                                .value.data?.image ??
                                            "",
                                      )
                                    : const AssetImage(
                                            'assets/images/user_image.png')
                                        as ImageProvider,
                                radius: 50,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bioController.userProfileCategoryModel.value
                                            .data?.name ??
                                        "Username",
                                    style: const TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "${ bioController.bioModel.value.count ?? 0} Videos",
                                    style: const TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Text(
                          isExpanded
                              ? bioController.userProfileCategoryModel.value
                                              .data?.bio ??
                                  "bio"
                              : (bioController.userProfileCategoryModel.value
                                              .data?.bio ??
                                              "bio")
                                          .length >=
                                      100
                                  ? (bioController.userProfileCategoryModel.value
                                              .data?.bio ??
                                          "bio")
                                      .substring(0, 100)
                                  : bioController.userProfileCategoryModel.value
                                              .data?.bio ??
                                      "bio",
                          style: const TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    if (!isExpanded) ...[
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = true;
                          });
                        },
                        child: const Text(
                          "Know More",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ] else ...[
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = false;
                          });
                        },
                        child: const Text(
                          "Show Less",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    const Text(
                      "Videos",
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        ),
                        itemCount:
                            bioController.bioModel.value.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return GridTile(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    bioController.bioModel.value.data?[index]
                                            .thumbNail ??
                                        "",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Center(
                                  child: Text(
                                    bioController.bioModel.value.data?[index]
                                            .title ??
                                        "",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xffFFFFFF),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
