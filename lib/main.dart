import 'package:flutter/material.dart';
import 'package:piscine_mobile/Module03/weatherfinal_proj.dart';
import 'package:piscine_mobile/Modulel02/weather_app_v2_proj.dart';



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
      home: const WeatherAppV2Proj(),
    );
  }
}

