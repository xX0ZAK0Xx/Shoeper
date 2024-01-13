import 'package:flutter/material.dart';
import 'package:shoeper/consts/appstyle.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Cart Page", style: appStyle(Colors.black, 40, FontWeight.bold),),
      ),
    );
  }
}