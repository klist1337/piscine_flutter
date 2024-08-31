import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:piscine_mobile/Modulel02/searcher.dart';
import 'package:piscine_mobile/Modulel02/where_are_we.dart';

class WeatherAppV2Proj extends StatefulWidget {
  const WeatherAppV2Proj({super.key});

  @override
  State<WeatherAppV2Proj> createState() => _WeatherAppV2ProjState();
}

class _WeatherAppV2ProjState extends State<WeatherAppV2Proj> {
  @override
  Widget build(BuildContext context) {
    return const Searcher();
  }
}