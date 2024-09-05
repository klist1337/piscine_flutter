import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'package:piscine_mobile/Modulel02/fill_the_view.dart';

class WeatherAppV2Proj extends StatefulWidget {
  const WeatherAppV2Proj({super.key});

  @override
  State<WeatherAppV2Proj> createState() => _WeatherAppV2ProjState();
}

class _WeatherAppV2ProjState extends State<WeatherAppV2Proj> {
  @override
  Widget build(BuildContext context) {
    return const FillTheView();
  }
}