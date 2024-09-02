import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:piscine_mobile/Modulel02/data_service.dart';

class Searcher extends StatefulWidget {
  const Searcher({super.key});

  @override
  State<Searcher> createState() => _SearcherState();
}

class _SearcherState extends State<Searcher> {
  final TextEditingController controller = TextEditingController();
  int currentIndex = 0;
  String location = "";
  Position? position;
  bool isDenied = false;
  String searchCity = "";
  List<String> list = ["Paris, ile de france, France",
  "Ullamco do ex id amet anim",
  "Officia cupidatat laboris excepteur"];


  @override
  void initState() {
    super.initState();
  }
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
        preferredSize: Size(MediaQuery.of(context).size.width, 80),
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
                        isDenied = false;
                        location = value;
                        searchCity = value;
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
              IconButton(onPressed: () async {
                await _determinePosition();
              }, 
                icon: const Icon(CupertinoIcons.location_fill, color: Colors.white,))
              ]  
              ),
            ],
          ),),
      ),
      body: searchCity.isEmpty ? 
        pages[currentIndex] 
        : searcherList() ,
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
      child:  isDenied == false ?  Column(
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
      ) : const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Geolocation is not available, please enable",
              style: TextStyle(
                fontSize: 17,
                color: Colors.red
              ),),
            Text("it in your settings app",
              style: TextStyle(
                fontSize: 17,
                color: Colors.red
              ),),
          ],
        ),
      ),
    );
  }
  Widget todayMeteoPage() {
    return  Center(
      child: isDenied == false ? Column(
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
      ) : const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Geolocation is not available, please enable",
              style: TextStyle(
                fontSize: 17,
                color: Colors.red
              ),),
            Text("it in your settings app",
              style: TextStyle(
                fontSize: 17,
                color: Colors.red
              ),),
          ],
        ),
      ),
    );
  }

  Widget weeklyMeteoPage() {
    return  Center(
      child: isDenied == false ? Column(
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
      ) : const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Geolocation is not available, please enable",
              style: TextStyle(
                fontSize: 17,
                color: Colors.red
              ),),
            Text("it in your settings app",
              style: TextStyle(
                fontSize: 17,
                color: Colors.red
              ),),
          ],
        ),
      ),
    );
  }

   Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          isDenied = true;
        });
        return;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        isDenied = true;
      });
      return ;
    } 
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high
    );
    final currentpos = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    setState(() {
      position = currentpos;
      location = "${position?.latitude} ${position?.longitude}";
      isDenied = false;
    });
  }

  Widget searcherList() {
    return FutureBuilder(
      future: DataService().getCities(searchCity),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('this city does not exist'));
        }
        return ListView.separated(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            List<dynamic> cities = snapshot.data;
              return Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(137, 255, 255, 255)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Text(cities[index]['name'], style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),),
                      const SizedBox(width: 8,),
                      Text("${cities[index]['admin1']}, ", 
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16
                        ) ,),
                     cities[index]['country'] != null ?
                      Text(cities[index]['country'], 
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16
                        ) ,) : const SizedBox.shrink()
                    ],
                  ),
                )
              );
            },
          separatorBuilder: (context, index) => const Divider(
            height: 2,
          ),
        );
      }
    );
  }
}