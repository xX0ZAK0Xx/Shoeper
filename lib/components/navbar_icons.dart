import 'package:flutter/material.dart';

class NavBarIcon extends StatelessWidget {
  final IconData? icon;
  final void Function()? onTap;
  bool? hasFocus;
  NavBarIcon({
    super.key,
    this.hasFocus,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 36,
        width: 36,
        child: GestureDetector(
          onTap: onTap,
          child: Icon(
            icon,
            size: hasFocus! ? 30 : 25,
            color: Colors.white,
          ),
        ));
  }
}
