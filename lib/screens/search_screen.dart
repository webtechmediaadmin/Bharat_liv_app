import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/bio_models.dart';
import '../routes/api_routes.dart';
import '../services/trending_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TrendingController trendingController = Get.find();

  TextEditingController searchController = TextEditingController();

  List<BioData> _content = [];

  @override
  void initState() {
    super.initState();
    trendingController.trendingFetch(ApiRoutes.bannerApi, isBanner: true);
  }

  List<BioData> searchContent(String query) {
    return trendingController.trendingDataList.where((item) {
      final title = item.title?.toLowerCase() ?? '';
      final userName = item.user?.name?.toLowerCase() ?? '';
      return title.contains(query.toLowerCase()) ||
          userName.contains(query.toLowerCase());
    }).toList();
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
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Color(0xffFFFFFF),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: searchController,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText:
                                              'Which is your favorite....',
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder
                                              .none, // Remove underline color when focused
                                          enabledBorder: InputBorder.none ),
                                      onChanged: (value) {
                                        setState(() {
                                          _content = searchContent(
                                              searchController.text);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
                      "Searches",
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.01), // 1% height space
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _content.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = _content[index];
                        return ListTile(
                          title: Text(item.title.toString(), style: TextStyle(color: Colors.white),),
                          subtitle: Text(item.user!.name.toString(), style: TextStyle(color: Colors.white)),
                          // Add more content information as needed
                        );
                      },
                    ),
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
