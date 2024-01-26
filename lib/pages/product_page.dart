// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shoeper/components/checkout_btn.dart';
import 'package:shoeper/consts/appstyle.dart';
import 'package:shoeper/controller/product_provider.dart';
import 'package:shoeper/models/sneakers_model.dart';
import 'package:shoeper/services/helper.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});
  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  final _cartBox = Hive.box('cart_box');
  late Future<Sneaker> _sneaker;

  void getShoes() {
    if (widget.category == "Men's Running") {
      _sneaker = Helper().getMaleSneakersByID(widget.id);
    } else if (widget.category == "Women's Running") {
      _sneaker = Helper().getFemaleSneakersByID(widget.id);
    } else {
      _sneaker = Helper().getKidsSneakersByID(widget.id);
    }
  }

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShoes();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: FutureBuilder<Sneaker>(
            future: _sneaker,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                print("Error: ${snapshot.error}");
                return Text("Error: ${snapshot.error}");
              } else {
                final sneaker = snapshot.data;
                return Consumer<ProductProvider>(
                  builder:
                      (BuildContext context, productNotifier, Widget? child) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          leadingWidth: 0,
                          title: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    productNotifier.activePage = 0;
                                    // productNotifier.shoeSizes.clear();
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.close),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(Icons.menu_rounded),
                                )
                              ],
                            ),
                          ),
                          pinned: true,
                          snap: false,
                          floating: true,
                          backgroundColor: Colors.transparent,
                          expandedHeight: screenHeight,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.5,
                                  width: screenWidth,
                                  child: PageView.builder(
                                      itemCount: sneaker!.imageUrl.length,
                                      controller: pageController,
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (page) {
                                        productNotifier.activePage = page;
                                      },
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          children: [
                                            Container(
                                              height: screenHeight * 0.39,
                                              width: screenWidth,
                                              color: Colors.grey.shade300,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    sneaker.imageUrl[index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                                top: screenHeight * 0.1,
                                                right: 15,
                                                child: Icon(
                                                  Icons.favorite_border_rounded,
                                                  color: Colors.grey,
                                                )),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                height: screenHeight * 0.3,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children:
                                                      List<Widget>.generate(
                                                          sneaker
                                                              .imageUrl.length,
                                                          (index) => Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            4),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 5,
                                                                  backgroundColor: productNotifier
                                                                              .activePage !=
                                                                          index
                                                                      ? Colors
                                                                          .grey
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                              )),
                                                )),
                                          ],
                                        );
                                      }),
                                ),
                                Positioned(
                                    bottom: 0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                      child: Container(
                                        height: screenHeight * 0.65,
                                        width: screenWidth,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.all(12),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(sneaker.name,
                                                    style: appStyle(
                                                        Colors.black,
                                                        35,
                                                        FontWeight.bold)),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      sneaker.category,
                                                      style: appStyle(
                                                          Colors.grey,
                                                          20,
                                                          FontWeight.w500),
                                                    ),
                                                    // SizedBox(width: 20,),
                                                    RatingBar.builder(
                                                      itemCount: 5,
                                                      initialRating: 4,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 1),
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemSize: 22,
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        color: Colors.black,
                                                        size: 18,
                                                      ),
                                                      onRatingUpdate:
                                                          (rating) {},
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "\$${sneaker.price}",
                                                      style: appStyle(
                                                          Colors.black,
                                                          22,
                                                          FontWeight.w600),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Color",
                                                          style: appStyle(
                                                              Colors.grey,
                                                              20,
                                                              FontWeight
                                                                  .normal),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor:
                                                              Colors.black,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Select Size",
                                                          style: appStyle(
                                                              Colors.black,
                                                              22,
                                                              FontWeight.bold),
                                                        ),
                                                        Text(
                                                          "View Size Guide",
                                                          style: appStyle(
                                                              Colors.grey,
                                                              22,
                                                              FontWeight
                                                                  .normal),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  child: ListView.builder(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      itemCount: productNotifier
                                                          .shoeSizes.length,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final sizes =
                                                            productNotifier
                                                                    .shoeSizes[
                                                                index];
                                                        return Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: ChoiceChip(
                                                            showCheckmark:
                                                                false,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          60),
                                                              side:
                                                                  const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 1,
                                                                style:
                                                                    BorderStyle
                                                                        .solid,
                                                              ),
                                                            ),
                                                            disabledColor:
                                                                Colors.white,
                                                            selectedColor:
                                                                Colors.black,
                                                            label: Text(
                                                              sizes['size'],
                                                              style: appStyle(
                                                                sizes['isSelected']
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                                18,
                                                                FontWeight.w400,
                                                              ),
                                                            ), 
                                                            selected: sizes[ 'isSelected'],
                                                            onSelected:(newState) {
                                                              if (newState) {
                                                                for (int i = 0; i < productNotifier.shoeSizes.length; i++) {
                                                                  if (i != index) {
                                                                    productNotifier.shoeSizes[i]['isSelected'] = false;
                                                                  }else{
                                                                    productNotifier.shoeSizes[i]['isSelected'] = true;
                                                                  }
                                                                }
                                                              }
                                                              productNotifier.toggleCheck(index);
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                const Divider(
                                                  indent: 10,
                                                  endIndent: 10,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.8,
                                                  child: Text(
                                                    sneaker.title,
                                                    style: appStyle(
                                                        Colors.black,
                                                        22,
                                                        FontWeight.w700),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                    height: 60,
                                                    child:
                                                        SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            child: Text(
                                                              sneaker
                                                                  .description,
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                              style: appStyle(
                                                                  Colors
                                                                      .black54,
                                                                  14,
                                                                  FontWeight
                                                                      .normal),
                                                            ))),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: CheckOutButton(
                                                    label: 'Add to Cart',
                                                    onTap: () async {
                                                      _createCart({
                                                        'id': sneaker.id,
                                                        'sizes': productNotifier.shoeSizes
                                                            .where((element) => element['isSelected'])
                                                            .map((e) => e['size'])
                                                            .toString(),
                                                        'name': sneaker.name,
                                                        'category':
                                                            sneaker.category,
                                                        'imageUrl':
                                                            sneaker.imageUrl,
                                                        'price': sneaker.price,
                                                        'qty': 1
                                                      });
                                                      productNotifier.sizes
                                                          .clear();
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            })));
  }
}
