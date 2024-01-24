import 'package:flutter/material.dart';
import 'package:shoeper/consts/appstyle.dart';

class StaggerTile extends StatelessWidget {
  const StaggerTile(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.price});

  final String imageUrl;
  final String name;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(children: [
        Image(
          image: NetworkImage(imageUrl),
          height: 80,
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: appStyle(Colors.black, 20, FontWeight.w700),),
              Text(price, style: appStyle(Colors.black, 18, FontWeight.w500),),
            ],
          ),
        )
      ]),
    );
  }
}