import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoeper/components/navbar_icons.dart';
import 'package:shoeper/consts/appstyle.dart';
import 'package:shoeper/controller/main_screen_provider.dart';
import 'package:shoeper/pages/add_page.dart';
import 'package:shoeper/pages/all_products.dart';
import 'package:shoeper/pages/cart_page.dart';
import 'package:shoeper/pages/home_page.dart';
import 'package:shoeper/pages/profile_page.dart';
import 'package:shoeper/pages/search_page.dart';

// ignore: must_be_immutable
class BasePage extends StatelessWidget {
  BasePage({super.key});
  List<Widget> pageList = const [
    MyHomePage(),
    SearchPage(),
    AddPage(),
    CartPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenProvider>(
      builder: (BuildContext context, MainScreenProvider value, Widget? child) => Scaffold(
        body: pageList[value.pageIndex],
        bottomNavigationBar: Container(
          color: Color.fromARGB(255, 240, 240, 240),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NavBarIcon(
                      icon: Icons.home,
                      hasFocus: value.pageIndex==0,
                      onTap: () { value.pageIndex = 0;},
                    ),
                    NavBarIcon(
                      icon: Icons.search,
                      hasFocus: value.pageIndex==1,
                      onTap: () { value.pageIndex = 1;},
                    ),
                    NavBarIcon(
                      icon: Icons.add,
                      hasFocus: value.pageIndex==2,
                      onTap: () { value.pageIndex = 2;},
                    ),
                    NavBarIcon(
                      icon: Icons.shopping_cart,
                      hasFocus: value.pageIndex==3,
                      onTap: () { value.pageIndex = 3;},
                    ),
                    NavBarIcon(
                      icon: Icons.person,
                      hasFocus: value.pageIndex==4,
                      onTap: () { value.pageIndex = 4;},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
