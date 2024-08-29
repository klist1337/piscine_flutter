import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherProj extends StatefulWidget {
  const WeatherProj({super.key});

  @override
  State<WeatherProj> createState() => _WeatherProjState();
}

class _WeatherProjState extends State<WeatherProj> { 
  final TextEditingController controller = TextEditingController();
  int currentIndex = 0;
  String location = "";


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
   
 
  @override
  Widget build(BuildContext context) {
  List<Widget> pages = [currentMeteoPage(), todayMeteoPage(), weeklyMeteoPage() ];
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: AppBar(
          backgroundColor: const Color(0xFF5B5D72),
          flexibleSpace: Column(
            children: [
              SizedBox(height: isPortrait ?
              MediaQuery.of(context).size.height * 0.058 
              : MediaQuery.of(context).size.height * 0.09),
              Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: isPortrait ? 200 : 500,
                    child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        location = value;
                      });
                    },
                    controller: controller ,
                    decoration:  InputDecoration(
                      hintText: "Search your location",
                      hintStyle: TextStyle(
                        fontStyle:FontStyle.italic,
                        color: Colors.grey.shade500
                      ),
                      prefixIcon:  const Icon(Icons.search, color: Colors.white,),
                    ),
                              ),
                  ),
                ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.3),
              Container(
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.white
                  ))
                ),
             const SizedBox(width: 8.0,),
              IconButton(onPressed: () {}, 
                icon: const Icon(CupertinoIcons.location_fill, color: Colors.white,))
              ]  
              ),
            ],
          ),),
      ),
      body: pages[currentIndex] ,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                });
              }, 
              icon: const Icon(Icons.sunny_snowing)
              ),
            label: "Currently" 
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                 setState(() {
                  currentIndex = 1;
                });
              }, 
              icon: const Icon(Icons.today)
            ),
            label: "Today"
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 2;
                });
              }, 
              icon: const Icon(Icons.calendar_month)
              ),
            label: "Weekly"
            )
          ]

      ),
    );
  }
  Widget currentMeteoPage() {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Currently',style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),),
          Text(location, 
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),),
        ],
      ) ,
    );
  }
  Widget todayMeteoPage() {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Today',style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),),
          Text(location, 
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),),
        ],
      ) ,
    );
  }
  Widget weeklyMeteoPage() {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Weekly',style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),),
          Text(location, 
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),),
        ],
      ) ,
    );
  }
}