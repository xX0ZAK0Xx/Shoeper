import 'package:flutter/material.dart';
import 'package:shoeper/consts/appstyle.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Add Page", style: appStyle(Colors.black, 40, FontWeight.bold),),
      ),
    );
  }
}