import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoeper/components/new_shoes.dart';
import 'package:shoeper/components/product_card.dart';
import 'package:shoeper/consts/appstyle.dart';
import 'package:shoeper/models/sneakers_model.dart';
import 'package:shoeper/pages/all_products.dart';

class HomeShoeCard extends StatelessWidget {
  const HomeShoeCard({
    super.key,
    required this.screenHeight,
    required Future<List<Sneaker>> gender,
    required this.screenWidth, required this.tabIndex,
  }) : _shoeList = gender;

  final double screenHeight;
  final Future<List<Sneaker>> _shoeList;
  final double screenWidth;

  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        SizedBox(
            height: screenHeight * 0.4,
            child: FutureBuilder(
                future: _shoeList,
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return Text("Error: ${snapshot.error}");
                  } else {
                    final shoeGender = snapshot.data;
                    return ListView.builder(
                      itemCount: shoeGender!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        final shoe = snapshot.data![index];
                        return ProductCard(
                            price: shoe.price,
                            category: shoe.category,
                            id: shoe.id,
                            name: shoe.name,
                            image: shoe.imageUrl[0]);
                      }),
                    );
                  }
                }))),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Shoes",
                    style: appStyle(Colors.black, 24, FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllProducts(tabIndex: tabIndex,)));
                    },
                    child: Row(
                      children: [
                        Text(
                          "Show all",
                          style: appStyle(Colors.black, 24, FontWeight.w400),
                        ),
                        Icon(Icons.play_arrow),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
            height: screenHeight * 0.13,
            child: FutureBuilder(
                future: _shoeList,
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return Text("Error: ${snapshot.error}");
                  } else {
                    final male = snapshot.data;
                    return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        final maleShoe = snapshot.data![index];
                        return Padding(
                            padding: EdgeInsets.all(10),
                            child: NewShoe(
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                                imageUrl: maleShoe.imageUrl[1]));
                      }),
                    );
                  }
                })))
      ],
    );
  }
}
