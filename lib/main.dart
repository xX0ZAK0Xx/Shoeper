import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoeper/controller/main_screen_provider.dart';
import 'package:shoeper/pages/base_page.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BasePage(),
    );
  }
}