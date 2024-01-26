// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:shoeper/consts/appstyle.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final _cartBox = Hive.box('cart_box');

  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "imageUrl": item['imageUrl'],
        "price": item['price'],
        "qty": item['qty'],
        "sizes": item['sizes'],
      };
    }).toList();

    cart = cartData.reversed.toList();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "My Cart",
                  style: appStyle(Colors.black, 36, FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: screenHeight * 0.65,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: cart.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final data = cart[index];
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Slidable(
                          key: const ValueKey(0),
                          child: Container(
                            height: screenHeight * 0.11,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  spreadRadius: 5,
                                  blurRadius: 0.3,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: CachedNetworkImage(
                                        imageUrl: data['imageUrl'][0],
                                        height: 70,
                                        width: 70,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 12, left: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['name'],
                                            style: appStyle(Colors.black, 16,
                                                FontWeight.bold),
                                          ),
                                          SizedBox(height:5),
                                          Text(data['category']?.toString() ?? 'Unknown Category',
                                              style: appStyle(Colors.grey, 13, FontWeight.w400),
                                          ),
                                          Row(
                                            children: [
                                              Text('\$${data['price']}'.toString(),
                                                  style: appStyle(Colors.black, 18, FontWeight.w600),
                                              ),
                                              SizedBox(width: 5),
                                              Text('Size: ${data['sizes']}'.toString(),
                                                  style: appStyle(Colors.grey, 12, FontWeight.w600),
                                              ),
                                            ],
                                          )

                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          endActionPane:
                              ActionPane(motion: ScrollMotion(), children: [
                            SlidableAction(
                              flex: 1,
                              onPressed: (BuildContext context) {},
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            )
                          ]),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
