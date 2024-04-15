import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../constant/constant.dart';
import '../../services/user_profile.dart';
import '../bottom_nav_screen.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  final UserProfileController userProfileController = Get.find();

  TextEditingController nameController = TextEditingController();

  File? _image;

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    // Save the picked image to device storage
    if (_image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = pickedFile!.path.split('/').last;
      final imagePath = '${directory.path}/$fileName';
      try {
        await _image!.copy(imagePath);
        print('Image saved to: $imagePath');

        // Send only the file path to the server
        final data = {
          'image': fileName, // Send the file name or full path to the server
          // Add other data fields as needed
        };

        // Now you can send the data to the server
        // Example: make an HTTP POST request to upload the data
      } catch (e) {
        print('Failed to save image: $e');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    userProfileController.fetchUserProfile();

    super.initState();
    userProfileController.selectedGender.value =
        userProfileController.userProfile.value.data?.gender ?? "";
    print("GENDER ${userProfileController.selectedGender.value}");
  }

  void updateName(String newName) {
    // Perform any necessary validations or updates
    setState(() {
      nameController.text = newName;
      // Update the state with the new name
      userProfileController.userProfile.value.data?.name = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("${userProfileController.userProfile.value.data?.image}");
    print("${_image}");
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
                left: MediaQuery.of(context).size.width * 0.06,
                right: MediaQuery.of(context).size.width *
                    0.06, // 5% padding horizontally
                top: MediaQuery.of(context).size.height * 0.04,
                bottom: MediaQuery.of(context).size.height *
                    0.07, // 2% padding vertically
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                           Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavBar(currentIndex: 3),
                                ),
                              );
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xffFFFFFF),
                          size: 20,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Profile",
                        style:
                            TextStyle(color: Color(0xffFFFFFF), fontSize: 15),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor:
                              const Color(0xffD9D9D9).withOpacity(0.3),
                          backgroundImage: (_image != null)
                              ? FileImage(File(_image!.path))
                              : (userProfileController
                                          .userProfile.value.data?.image !=
                                      null)
                                  ? NetworkImage(
                                      userProfileController
                                              .userProfile.value.data?.image ??
                                          "",
                                    )
                                  : const AssetImage(
                                          'assets/images/user_image.png')
                                      as ImageProvider,
                          radius: 60,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                            const SizedBox(height: 5),
                            Obx(
                              () => Text(
                                userProfileController
                                        .userProfile.value.data?.phoneNumber ??
                                    "",
                                style: TextStyle(
                                    color: Color(0xffFFFFFF), fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
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
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Plan Start At ',
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF), fontSize: 10),
                                  ),
                                  TextSpan(
                                    text: '₹129',
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF), fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => _buildText(
                        userProfileController.userProfile.value.data?.name ??
                            "",
                        "assets/images/pf1.png",
                        "assets/images/pf2.png",
                        nameController,
                        (newName) => updateName(newName)),
                  ),
                  const Divider(
                    color: Color(0xffFFFFFF),
                  ),
                  const SizedBox(height: 20),
                  _buildText(
                    "2003-03-08",
                    "assets/images/pf3.png",
                    "assets/images/pf2.png",
                  ),
                  const Divider(
                    color: Color(0xffFFFFFF),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => _buildText(
                      "+91 ${userProfileController.userProfile.value.data?.phoneNumber ?? ""}",
                      "assets/images/pf4.png",
                      "assets/images/padlock.png",
                    ),
                  ),
                  const Divider(
                    color: Color(0xffFFFFFF),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Select Your Gender",
                    style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xffFFFFFF),
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("Female tapped");
                            userProfileController.selectedGender.value =
                                "Female";
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: Color(0xffFFFFFF).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: userProfileController
                                                .selectedGender.value ==
                                            'Female'
                                        ? Colors.pink
                                        : Colors.transparent)),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/female.png",
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Female",
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xffFFFFFF)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Female tapped1");
                            userProfileController.selectedGender.value = "Male";
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: Color(0xffFFFFFF).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: userProfileController
                                                .selectedGender.value ==
                                            'Male'
                                        ? Colors.blue
                                        : Colors.transparent)),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/male.png",
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Male",
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xffFFFFFF)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Female tapped2");
                            userProfileController.selectedGender.value =
                                "Others";
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: Color(0xffFFFFFF).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: userProfileController
                                                .selectedGender.value ==
                                            'Others'
                                        ? Colors.yellow
                                        : Colors.transparent)),
                            child: Row(
                              children: [
                                Text(
                                  "Others",
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xffFFFFFF)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      try {
                        Map<String, dynamic> body = {
                          "name": nameController.text,
                          "gender": userProfileController.selectedGender.value,
                        };
                        print("Request body: $body");

                        await userProfileController.editUserProfile(
                            body, _image);
                        showToast("User profile edited successfully!");
                        print("User profile edited successfully!");

                        userProfileController.fetchUserProfile();
                      } catch (e) {
                        print("Error editing user profile: $e");
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String text, image, image1,
      [TextEditingController? controller, Function(String)? onChanged]) {
    FocusNode focusNode = FocusNode();
    bool isPhoneNumber = text.contains(
        "${userProfileController.userProfile.value.data?.phoneNumber}");

    // Move cursor to the end of the text when TextField gains focus
    focusNode.addListener(() {
      if (focusNode.hasFocus && controller!.text.isNotEmpty) {
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
      }
    });

     return GestureDetector(
      onTap: () {
          if (controller != null) {
        final newPosition = controller.text.length;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: newPosition),
        );
      }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Image.asset(
                  image,
                  height: 15,
                  width: 15,
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    enabled: !isPhoneNumber,
                    onTap: () {
                      if (controller != null) {
                      final newPosition = controller.text.length;
                      controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: newPosition),
                      );
                    }
                    },
                    style: const TextStyle(fontSize: 15, color: Color(0xffFFFFFF)),
                    decoration: InputDecoration.collapsed(
                      hintText: text,
                      hintStyle: const TextStyle(fontSize: 15, color: Color(0xffFFFFFF)),
                    ),
                    onChanged: onChanged,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Image.asset(
              image1,
              height: 15,
              width: 15,
              color: Color(0xffFFFFFF),
            ),
          ),
        ],
      ),
    );}
}
