import 'package:flutter/material.dart';
import 'package:shoeper/consts/appstyle.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({super.key, required this.onPress, required this.buttonColor, required this.label});
  final void Function()? onPress;
  final Color buttonColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.255,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: buttonColor,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: appStyle(buttonColor, 20, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
