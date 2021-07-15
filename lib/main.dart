import 'package:flutter/material.dart';
import 'package:namma_badavane/utils/bottom_navigation.dart';
import './screens/LoginScreen.dart';
import './utils/colors.dart';
import 'screens/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Invoice Stock',
      theme: ThemeData(
        primarySwatch: primary_color,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomBarExample(),

    );
  }
}
