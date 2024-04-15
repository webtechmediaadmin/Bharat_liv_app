import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
                  top: MediaQuery.of(context).size.height * 0.02,
                  bottom: MediaQuery.of(context).size.height *
                      0.07, // 2% padding vertically
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    Text(
                      "Recent Searches",
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 16,
                      ),
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
                    const Text(
                      "Categories",
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.01), // 1% height space
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0, 
                        crossAxisSpacing: 10.0, 
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Image.asset(
                              "assets/images/rectangle5.png",
                              fit: BoxFit.contain,
                            ),
                          ],
                        );
                      },
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
