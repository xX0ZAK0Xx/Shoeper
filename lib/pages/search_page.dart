import 'package:flutter/material.dart';
import 'package:shoeper/consts/appstyle.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Search Page", style: appStyle(Colors.black, 40, FontWeight.bold),),
      ),
    );
  }
}