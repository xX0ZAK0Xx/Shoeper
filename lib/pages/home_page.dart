import 'package:flutter/material.dart';
import 'package:shoeper/consts/appstyle.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Homepage", style: appStyle(Colors.black, 40, FontWeight.bold),),
      ),
    );
  }
}