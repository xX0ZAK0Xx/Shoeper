import 'package:flutter/material.dart';

class NewShoe extends StatelessWidget {
  const NewShoe({
    super.key,
    required this.screenHeight,
    required this.screenWidth, required this.imageUrl,
  });

  final double screenHeight;
  final double screenWidth;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.12,
      width: screenWidth * 0.28,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              blurRadius: 0.8,
              offset: Offset(0, 1),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      child: Image(
          image: NetworkImage(imageUrl)),
    );
  }
}
