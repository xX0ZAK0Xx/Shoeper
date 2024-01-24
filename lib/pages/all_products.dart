import 'package:flutter/material.dart';
import 'package:shoeper/components/category_button.dart';
import 'package:shoeper/components/custom_spacer.dart';
import 'package:shoeper/components/latest_shoes.dart';
import 'package:shoeper/consts/appstyle.dart';
import 'package:shoeper/models/sneakers_model.dart';
import 'package:shoeper/services/helper.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  Future<List<Sneaker>> _maleShoeList = Helper().getMaleSneakers();
  Future<List<Sneaker>> _femaleShoeList = Helper().getFemaleSneakers();
  Future<List<Sneaker>> _kidsShoeList = Helper().getKidsSneakers();

  List<String> brand = [
    'assets/images/adidas.png',
    'assets/images/gucci.png',
    'assets/images/jordan.png',
    'assets/images/nike.png',
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: SizedBox(
        height: screenHeight,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: screenHeight * 0.45,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.fill)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(6, 5, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              filter();
                            },
                            icon: Icon(
                              Icons.category_rounded,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  TabBar(
                    dividerHeight: 0,
                    padding: EdgeInsets.all(0),
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: TabBarView(controller: _tabController, children: [
                  LatestShoes(shoeList: _maleShoeList),
                  LatestShoes(shoeList: _femaleShoeList),
                  LatestShoes(shoeList: _kidsShoeList),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    final double _value = 100;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black38),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      children: [
                        CustomSpacer(),
                        Text(
                          "Filter",
                          style: appStyle(Colors.black, 40, FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            CategoryButton(
                                onPress: () {},
                                buttonColor: Colors.black,
                                label: "Men"),
                            CategoryButton(
                                onPress: () {},
                                buttonColor: Colors.black,
                                label: "Women"),
                            CategoryButton(
                                onPress: () {},
                                buttonColor: Colors.black,
                                label: "Kids"),
                          ],
                        ),
                        CustomSpacer(),
                        Text(
                          "Categories",
                          style: appStyle(Colors.black, 20, FontWeight.w600),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            CategoryButton(
                                onPress: () {},
                                buttonColor: Colors.black,
                                label: "Shoes"),
                            CategoryButton(
                                onPress: () {},
                                buttonColor: Colors.black,
                                label: "Apparrels"),
                            CategoryButton(
                                onPress: () {},
                                buttonColor: Colors.black,
                                label: "Accessories"),
                          ],
                        ),
                        CustomSpacer(),
                        Text(
                          "Price",
                          style: appStyle(Colors.black, 30, FontWeight.bold),
                        ),
                        CustomSpacer(),
                        Slider(
                            value: _value,
                            activeColor: Colors.black,
                            inactiveColor: Colors.grey,
                            thumbColor: Colors.black,
                            max: 500,
                            divisions: 50,
                            label: _value.toString(),
                            secondaryTrackValue: 200,
                            onChanged: (double value) {}),
                        Text(
                          "Brand",
                          style: appStyle(Colors.black, 20, FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          height: 80,
                          child: ListView.builder(
                            itemCount: brand.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Image.asset(
                                    brand[index],
                                    height: 60,
                                    width: 80,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
