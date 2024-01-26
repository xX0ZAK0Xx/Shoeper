import 'package:flutter/material.dart';
import 'package:shoeper/consts/appstyle.dart';

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({
    super.key, required this.label, required this.onTap,
  });

  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 50,
          child: Center(
            child: Text(
              label,
              style: appStyle(Colors.white, 22, FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
