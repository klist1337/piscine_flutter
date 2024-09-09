import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:piscine_mobile/Modulel02/data_service.dart';
import 'package:piscine_mobile/Modulel02/function.dart';
// ignore: must_be_immutable
class FillTheView extends StatefulWidget {
  FillTheView({super.key, this.city, this.startIndex});
  dynamic city;
  int? startIndex;

  @override
  State<FillTheView> createState() => _FillTheViewState();
}

class _FillTheViewState extends State<FillTheView> {
  final TextEditingController controller = TextEditingController();
  int currentIndex = 0;
  List<String> locations = List.generate(3, (index) => "");
  String location = "";
  Position? position;
  bool isDenied = false;
  String searchCity = "";



  @override
  void initState() {
    super.initState();
    _determinePosition();
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
    if (widget.city != null) {
      locations[0] = widget.city['name'];
      locations[1] = widget.city['admin1'];
      locations[2] = widget.city['country'];
    }
    if (widget.startIndex != null) {
      currentIndex = widget.startIndex!; 
    }
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
                widget.city = null;
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
                  widget.startIndex = 0;
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
                  widget.startIndex = 1; 
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
                  widget.startIndex = 2;
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
    if (isDenied == false) {
      if (position != null) {
         return FutureBuilder(
          future: widget.city == null ? DataService().getCurrentWeather(position!.latitude, position!.longitude) :
          DataService().getCurrentWeather(widget.city['latitude'], widget.city['longitude'],),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color:  Color(0xFF5B5D72)));
            }

            else if (snapshot.hasError) {
              return const Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Could not find any result for the supplied",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red
                  ),),
                Text("address or coordinates",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red
                  ),),
              ],
            ));
            }
            else if (!snapshot.hasData) {
              return const Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("the service connection is lost, please check", 
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16
                ),),
                Text("your internet connection or try again", 
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16
                ),),
              ],
            ));
            }
            else {
              final currentWeather = snapshot.data;
              String? weatherCondition = getWeatherCondition(currentWeather['current']['weather_code']);
              double temperature = currentWeather['current']['apparent_temperature']; 
              double windSpeed = currentWeather['current']['wind_speed_10m'];
              return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Text(locations[0], 
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(locations[1], 
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(locations[2], 
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  Text("$temperature °C",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(weatherCondition!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  Text("$windSpeed km/h",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                ],
              ),
            );
            }
            
          }
        );
      }
       else {
        return const Center(child:CircularProgressIndicator(color: Color(0xFF5B5D72),));
       }
    }
    return const Center(
      child:   Padding(
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
     if (isDenied == false) {
      if (position != null) {
         return FutureBuilder(
          future: widget.city == null ? DataService().getTodayWeather(position!.latitude, position!.longitude) :
          DataService().getTodayWeather(widget.city['latitude'], widget.city['longitude'],),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color:  Color(0xFF5B5D72)));
            }
            else if (snapshot.hasError) {
              return const Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Could not find any result for the supplied",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red
                  ),),
                Text("address or coordinates",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red
                  ),),
              ],
            ));
            }
            else if (!snapshot.hasData) {
              return const Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("the service connection is lost, please check", 
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16
                ),),
                Text("your internet connection or try again", 
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16
                ),),
              ],
            ));
            }
            else {
              final todayWeatherTime = snapshot.data['hourly']['time'];
              final todayWeatherTemp = snapshot.data['hourly']['temperature_2m'];
              final todayWeatherCode = snapshot.data['hourly']['weather_code'];
              final todayWindSpeed = snapshot.data['hourly']['wind_speed_10m'];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Text(locations[0], 
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(locations[1], 
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(locations[2], 
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  Expanded(
                    child: ListView.builder(
                    itemCount: todayWeatherTime.length,
                    itemBuilder:(context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(todayWeatherTime[index].split('T')[1]),
                          //const SizedBox(width: 10,),
                          Text("${todayWeatherTemp[index]} °C"),
                          //const SizedBox(width: 20,),
                          Text(getWeatherCondition(todayWeatherCode[index])!.split(':')[0]),
                          Text("${todayWindSpeed[index]} km/h")
                      ]);
                    }))
                ], 
              );
            }
            
          }
        );
      }
       else {
        return const Center(child:CircularProgressIndicator(color: Color(0xFF5B5D72),));
       }
    }
    return const Center(
      child:   Padding(
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
     if (isDenied == false) {
      if (position != null) {
         return FutureBuilder(
          future: widget.city == null ? DataService().getWeeklyWeather(position!.latitude, position!.longitude) :
          DataService().getWeeklyWeather(widget.city['latitude'], widget.city['longitude'],),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color:  Color(0xFF5B5D72)));
            }
            else if (snapshot.hasError) {
              return const Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Could not find any result for the supplied",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red
                  ),),
                Text("address or coordinates",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red
                  ),),
              ],
            ));
            }
            else if (!snapshot.hasData) {
              return const Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("the service connection is lost, please check", 
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16
                ),),
                Text("your internet connection or try again", 
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16
                ),),
              ],
            ));
            }
            else {
              final todayWeatherTime = snapshot.data['daily']['time'];
              final todayTempMax = snapshot.data['daily']['temperature_2m_min'];
              final todayTempMin = snapshot.data['daily']['temperature_2m_max'];
              final todayWeatherCode = snapshot.data['daily']['weather_code'];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Text(locations[0], 
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(locations[1], 
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(locations[2], 
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  Expanded(
                    child: ListView.builder(
                    itemCount: todayWeatherTime.length,
                    itemBuilder:(context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(todayWeatherTime[index]),
                          //const SizedBox(width: 10,),
                          Text("${todayTempMin[index]} °C"),
                          //const SizedBox(width: 20,),
                          Text("${todayTempMax[index]} °C"),
                          Text(getWeatherCondition(todayWeatherCode[index])!.split(':')[0]),
                      ]);
                    }))
                ], 
              );
            }
            
          }
        );
      }
       else {
        return const Center(child:CircularProgressIndicator(color: Color(0xFF5B5D72),));
       }
    }
    return const Center(
      child:   Padding(
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
    final placeMarks = await getPlaceMarks(currentpos);
    setState(() {
      position = currentpos;
      if (placeMarks != null) {
        locations[0] = placeMarks[0].locality!;
        locations[1] = placeMarks[0].administrativeArea!;
        locations[2] = placeMarks[0].country!;
      }
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
        else if (snapshot.hasError) {
            return const Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Could not find any result for the supplied",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red
                  ),),
                Text("address or coordinates",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red
                  ),),
              ],
            ));
        }
        else if (!snapshot.hasData || snapshot.data.isEmpty) {
          return const Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("the service connection is lost, please check", 
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16
              ),),
              Text("your internet connection or try again", 
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16
              ),),
            ],
          ));
        }
        return ListView.separated(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            List<dynamic> cities = snapshot.data;
              return GestureDetector(
                onTap: () async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => FillTheView(city: cities[index], startIndex: currentIndex,))
                  );
                  // if (!context.mounted) return;
                  // Navigator.pop(context);
                },
                child: Container(
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
                ),
              );
            },
          separatorBuilder: (context, index) => const Divider(
            height: 2,
          ),
        );
      }
    );
  }
  Future<List<Placemark>?> getPlaceMarks(Position pos) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    if (placeMarks.isNotEmpty) {
      return placeMarks;
    }
    return null;

  }
}