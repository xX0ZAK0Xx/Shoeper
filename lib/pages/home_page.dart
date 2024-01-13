import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoeper/consts/appstyle.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
          height: screenHeight,
          child: Stack(children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: screenHeight * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.fill)),
              child: Container(
                padding: EdgeInsets.only(top: 8, left: 10),
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Athletic Shoes",
                        style: appStyleHeight(
                            Colors.white, 40, FontWeight.bold, 1.5)),
                    Text("Collection",
                        style: appStyleHeight(
                            Colors.white, 40, FontWeight.bold, 1)),
                    TabBar(
                      dividerHeight: 0,
                      controller: _tabController,
                      isScrollable: true, // Consider adding this
                      indicatorColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: Colors.white,
                      labelStyle: appStyle(Colors.white, 20, FontWeight.bold),
                      unselectedLabelColor: Colors.white.withOpacity(0.3),
                      tabs: [
                        Tab(text: "Men Shoes"),
                        Tab(text: "Women Shoes"),
                        Tab(text: "Kids Shoes"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.265),
              child: Container(
                padding: EdgeInsets.all(12),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                            height: screenHeight * 0.4,
                            child: ListView.builder(
                              itemCount: 6,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: screenHeight * 0.1,
                                    width: screenWidth * 0.3,
                                    color: Colors.red,
                                  ),
                                );
                              }),
                            )),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Latest Shoes",
                                    style: appStyle(
                                        Colors.black, 24, FontWeight.w700),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Show all",
                                        style: appStyle(
                                            Colors.black, 24, FontWeight.w400),
                                      ),
                                      Icon(Icons.play_arrow),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.13,
                          child: ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: screenHeight * 0.12,
                                  width: screenWidth * 0.28,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromARGB(96, 173, 173, 173),
                                          spreadRadius: 1,
                                          blurRadius: 0.8,
                                          offset: Offset(0,1),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      )),
                                  child: Image(image: NetworkImage('https://scontent.fdac99-1.fna.fbcdn.net/v/t1.15752-9/415300590_1308504523179630_2972162771891041000_n.png?_nc_cat=109&ccb=1-7&_nc_sid=8cd0a2&_nc_eui2=AeGxbJ9ZQwzecCUo2RNb0xxTP68xI6VrBKw_rzEjpWsErHSyOKy-0TJzozSDPczZuf3hucHhgTFvc5N7Y9g1QgVm&_nc_ohc=uj_wq2zgMTwAX9_Au7b&_nc_ht=scontent.fdac99-1.fna&oh=03_AdRSkE9u2Ujfxjz6iE0mVGF2t1QCOmykVdsTwxE3ZJbGsg&oe=65C9E0EC', )),
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: screenHeight * 0.4,
                          decoration: BoxDecoration(color: Colors.green),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: screenHeight * 0.4,
                          decoration: BoxDecoration(color: Colors.blue),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
