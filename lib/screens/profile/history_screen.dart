import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
                left: MediaQuery.of(context).size.width * 0.06,
                right: MediaQuery.of(context).size.width *
                    0.06, // 5% padding horizontally
                top: MediaQuery.of(context).size.height * 0.04,
                bottom: MediaQuery.of(context).size.height *
                    0.07, // 2% padding vertically
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xffFFFFFF),
                          size: 20,
                        ),
                      ),
                    
                      const Text(
                        "History",
                        style:
                            TextStyle(color: Color(0xffFFFFFF), fontSize: 15),
                      ),
                   
                      const Icon(
                          Icons.search,
                          color: Color(0xffFFFFFF),
                          size: 20,
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
              )
            )),
          ),
        ],
      ),
    );
  
  }
}