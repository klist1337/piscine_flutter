import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherProj extends StatefulWidget {
  const WeatherProj({super.key});

  @override
  State<WeatherProj> createState() => _WeatherProjState();
}

class _WeatherProjState extends State<WeatherProj> {
  List<Widget> tabs = [];
   
  @override
 
  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: AppBar(
          backgroundColor: const Color(0xFF5B5D72),
          flexibleSpace: Column(
            children: [
              SizedBox(height: isPortrait ?
              MediaQuery.of(context).size.height * 0.056 
              : MediaQuery.of(context).size.height * 0.09),
              Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: isPortrait ? 200 : 500,
                    child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Search your location",
                      prefixIcon:  Icon(Icons.search),
                    ),
                              ),
                  ),
                ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.3),
              Container(
                height: 30,
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(
                    color: Colors.white,
                    width: 2
                  ))
                ),
              ),
             const SizedBox(width: 8.0,),
              IconButton(onPressed: () {}, 
                icon: const Icon(CupertinoIcons.location_fill, color: Colors.white,))
              ]  
              ),
            ],
          ),),
      )
    );
  }
}