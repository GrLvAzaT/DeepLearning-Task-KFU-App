import 'package:flutter/material.dart';
import 'package:design1/screens/home.dart';
import 'package:design1/screens/sigmoid.dart';
import 'package:design1/constants/app_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторные ИИ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //`home: MainScreen(),
      routes: {
        '/': (context) => HomeScreen(),
        '/sigmoid': (context) => SigmoidScreen(),
      },
    );
  }
}
