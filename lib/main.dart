import 'package:flutter/material.dart';
import 'package:piscine_mobile/mobileModule00/ex00.dart';
import 'package:piscine_mobile/mobileModule00/ex01.dart';
import 'package:piscine_mobile/mobileModule00/ex02.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
      ),
      home: const MyCalculator(),
    );
  }
}

