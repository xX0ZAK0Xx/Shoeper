import 'package:flutter/material.dart';
import 'package:shoeper/consts/appstyle.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Profile Page", style: appStyle(Colors.black, 40, FontWeight.bold),),
      ),
    );
  }
}