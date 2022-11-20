import 'package:bm_project2/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(StartApp());
}

class StartApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}