import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class DownloadScreen extends StatefulWidget {
  String? id;
  String? videoTitle, videoName;
  DownloadScreen({
    Key? key,
     this.id,
     this.videoName,
     this.videoTitle
  }) : super(key: key);

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {

   Future<void> _downloadVideo(String id, videoTitle, videoName) async {
    String videoUrl = videoTitle; // URL of the video to download
    String fileName = videoName; // Name of the file

    // Get temporary directory for storing the downloaded file
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    // Create file path
    String filePath = '$tempPath/$fileName';

    // Check if the file already exists
    File file = File(filePath);
    if (await file.exists()) {
      // If file already exists, show message to user
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File already downloaded'),
        ),
      );
      return;
    }

    // Download the file
    http.Client client = http.Client();
    http.Response response = await client.get(Uri.parse(videoUrl));
    if (response.statusCode == 200) {
      // Write file to local storage
      File videoFile = File(filePath);
      await videoFile.writeAsBytes(response.bodyBytes);

      // Show success message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File downloaded successfully'),
        ),
      );
    } else {
      // Show error message if download fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download file'),
        ),
      );
    }
  }

  @override
  void initState() {
    // _downloadVideo(widget.id!, widget.videoTitle, widget.videoName);
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
                  left: MediaQuery.of(context).size.width *
                      0.03,
                  right: MediaQuery.of(context).size.width *
                      0.03,     // 5% padding horizontally
                  top: MediaQuery.of(context).size.height *
                      0.02,
                   bottom : MediaQuery.of(context).size.height *
                      0.07,     // 2% padding vertically
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Download",
                          style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Add your search icon onPressed action here
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.01), // 1% height space
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.2, // 20% of screen height
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width *
                                    0.02), // 2% space between items
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/image5.png",
                                  height: 110,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "आखिर भरत जी को क्यों बनना पड़ा था मृग?\nDevkinandan Thakur Ji Facts | Katha",
                                  style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.01), // 1% height space
                    SizedBox(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height *
                                    0.02), // 2% bottom margin
                            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: Color(0xffFFFFFF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xffFEFEFE).withOpacity(0.2),
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                     height: 100,
                                      width: 130,
                                     
                                    child: Image.asset(
                                      "assets/images/image5.png",
                                      fit: BoxFit.fill,
                                   
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.04), // 2% space between image and text
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "आखिर भरत जी को क्यों बनना पड़ा था मृग?\nDevkinandan Thakur Ji Facts | Katha",
                                          style: TextStyle(
                                            color: Color(0xffFFFFFF),
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  "assets/images/user_image.png"),
                                              radius: 18,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Hi, Username",
                                              style: TextStyle(
                                                color: Color(0xffFFFFFF),
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 3),
                                              decoration: BoxDecoration(
                                                color: Color(0xff8B488B),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                "208.5 MB",
                                                style: TextStyle(
                                                  color: Color(0xffFFFFFF),
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              Icons.delete,
                                              size: 22,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
