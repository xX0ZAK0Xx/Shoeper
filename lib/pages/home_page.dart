import 'package:flutter/material.dart';
import 'package:shoeper/components/home_shoe_card.dart';
import 'package:shoeper/consts/appstyle.dart';
import 'package:shoeper/models/sneakers_model.dart';
import 'package:shoeper/services/helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);
  late Future<List<Sneaker>> _male;
  late Future<List<Sneaker>> _female;
  late Future<List<Sneaker>> _kids;

  void getMale() {
    _male = Helper().getMaleSneakers();
  }

  void getFemale() {
    _female = Helper().getFemaleSneakers();
  }

  void getKids() {
    _kids = Helper().getKidsSneakers();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMale();
    getFemale();
    getKids();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: SingleChildScrollView(
        child: SizedBox(
            height: screenHeight,
            child: Stack(children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 45, 0, 0),
                height: screenHeight * 0.45,
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
                      HomeShoeCard(screenHeight: screenHeight, gender: _male, screenWidth: screenWidth, tabIndex: 0,),
                      HomeShoeCard(screenHeight: screenHeight, gender: _female, screenWidth: screenWidth, tabIndex: 1,),
                      HomeShoeCard(screenHeight: screenHeight, gender: _kids, screenWidth: screenWidth, tabIndex: 2,),
                      
                    ],
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}

