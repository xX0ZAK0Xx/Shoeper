import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoeper/components/new_shoes.dart';
import 'package:shoeper/components/stagger_tile.dart';
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

  Future<List<Sneaker>> _shoeList = Helper().getMaleSneakers();

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
                              Navigator.pop(context);
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
              padding:
                  EdgeInsets.only(top: screenHeight * 0.2, left: 10, right: 10),
              child: TabBarView(controller: _tabController, children: [
                FutureBuilder(
                    future: _shoeList,
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        print("Error: ${snapshot.error}");
                        return Text("Error: ${snapshot.error}");
                      } else {
                        final male = snapshot.data;
                        return GridView.builder(
                          itemCount: male!.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            final maleShoe = snapshot.data![index];
                            return StaggerTile(
                                imageUrl: maleShoe.imageUrl[1],
                                name: maleShoe.name,
                                price: maleShoe.price);
                          },
                        );
                      }
                    })),
                Container(
                  height: 500,
                  width: 300,
                  color: Colors.red,
                ),
                Container(
                  height: 500,
                  width: 300,
                  color: Colors.blue,
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
