import 'package:calculator/calculator_screen.dart';
import 'package:calculator/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Calculator',
  //     theme: ThemeData.dark(),
  //     home: const CalculatorScreen(),
  //   );
  // }
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

