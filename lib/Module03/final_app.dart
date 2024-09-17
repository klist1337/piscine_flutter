
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:piscine_mobile/Module03/constant.dart';
import 'package:piscine_mobile/Module03/data_service.dart';
import 'package:piscine_mobile/Module03/function.dart';
import 'package:piscine_mobile/Module03/weather_chart.dart';
import 'package:piscine_mobile/Module03/weekly_weather_chart.dart';
// ignore: must_be_immutable
class FinalApp extends StatefulWidget {
  FinalApp({super.key, this.city, this.startIndex});
  dynamic city;
  int? startIndex;

  @override
  State<FinalApp> createState() => _FinalAppState();
}

class _FinalAppState extends State<FinalApp> {
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
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.height, 80),
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: isPortrait ?
                MediaQuery.of(context).size.height * 0.058 
                : MediaQuery.of(context).size.height * 0.09),
                Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: isPortrait ? 240 : 500,
                      child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white
                      ),
                      onChanged: (value) {
                        setState(() {
                          isDenied = false;
                          location = value;
                          searchCity = value;
                        });
                      },
                      controller: controller ,
                      decoration:  InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder:const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ) ,
                        labelText: "Search your location",
                        labelStyle: TextStyle(
                          fontStyle:FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: isPortrait ? 15 : 18,
                          color: Colors.white
                        ),
                        prefixIcon:  const Icon(Icons.search, color: Colors.white,),
                      ),
                                ),
                    ),
                  ),
                SizedBox(width: isPortrait ? MediaQuery.of(context).size.width * 0.22
                          : MediaQuery.of(context).size.width * 0.31),
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
            ),
          ),),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/gradient2.jpg'),
                fit: BoxFit.fill,
                opacity: 0.85
              )
            ),
            height: double.infinity ,
          ),
          searchCity.isEmpty ? 
            pages[currentIndex] 
            : searcherList(),
        ],
      ) ,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: const Color.fromARGB(255, 248, 245, 66),
        unselectedItemColor: Colors.white,
        unselectedLabelStyle: const TextStyle(
          fontFamily: "cereal"
        ),
        selectedLabelStyle: const TextStyle(
          fontFamily: "cereal"
        ),
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
              int weatherCode = currentWeather['current']['weather_code'];
              String? weatherCondition = getWeatherCondition(currentWeather['current']['weather_code']);
              double temperature = currentWeather['current']['apparent_temperature']; 
              double windSpeed = currentWeather['current']['wind_speed_10m'];
              return SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80,),
                      Text(locations[0], 
                      style:  const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:Colors.white
                      ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${locations[1]},", 
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow
                          ),),
                          Text(locations[2], 
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),),
                        ],
                      ),
                  
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          temperature > 20.0 ? Image.asset('assets/images/hottemp.png', width: 60, height: 60,) 
                            : Image.asset('assets/images/coldtemp.png', width: 60, height: 60,),
                          Text("$temperature °C",
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 234, 227, 171)
                          ),),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Text(weatherCondition!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 92, 170, 137)
                      ),),
                      getImageByWeather(weatherCode, 200),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/wind.png',
                            width: 40,
                            height: 40,),
                          Text("$windSpeed km/h",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey
                          ),),
                        ],
                      ),
                    ],
                  ),
                              ),
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
              return SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Text(locations[0], 
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Text("${locations[1]},", 
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow
                        ),),
                        Text(locations[2], 
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const Text("Today Temperature", 
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    ),),
                    const SizedBox(height: 10,),
                    TodayWeatherChart(
                      maxTemp: getMaxTemp(todayWeatherTemp), 
                      minTemp: getMinTemp(todayWeatherTemp),
                      dayTemp: todayWeatherTemp,),
                    
                    const SizedBox(height: 10,),
                    Expanded(
                      child: ListView.separated(
                      scrollDirection: Axis.horizontal ,
                      itemCount: todayWeatherTime.length,
                      itemBuilder:(context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(todayWeatherTime[index].split('T')[1], 
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white
                            ),),
                            //const SizedBox(width: 10,),
                            Text("${todayWeatherTemp[index]} °C", 
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 234, 227, 171)
                              ),),
                            getImageByWeather(todayWeatherCode[index], 80),
                            //const SizedBox(width: 20,),
                            Text(getWeatherCondition(todayWeatherCode[index])!.split(':')[0], 
                              style: const TextStyle(
                                color:  Color.fromARGB(255, 219, 227, 53),
                                fontWeight: FontWeight.bold
                              ),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset("assets/images/wind.png", width: 30,),
                                Text("${todayWindSpeed[index]} km/h", 
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ) ,),
                              ],
                            )
                        ]);
                      },
                      separatorBuilder: (context, index) => const SizedBox(width: 10,),)),
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
              final todayWeatherDate = snapshot.data['daily']['time'];
              final todayTempMax = snapshot.data['daily']['temperature_2m_max'];
              final todayTempMin = snapshot.data['daily']['temperature_2m_min'];
              final todayWeatherCode = snapshot.data['daily']['weather_code'];
              return SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Text(locations[0], 
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${locations[1]},", 
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow
                        ),),
                        Text(locations[2], 
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const Text("Weekly temperature",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18
                      ),),
                    WeeklyWeatherChart(
                      weatherDate: todayWeatherDate, 
                      minTemp: getMinTemp(todayTempMin),
                      maxTemp: getMaxTemp(todayTempMax),
                      listMaxTemp: todayTempMax,
                      listMinTemp: todayTempMin,),
                    const SizedBox(height: 20,),
                    Expanded(
                      child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: todayWeatherDate.length,
                      itemBuilder:(context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                               formatDate(todayWeatherDate[index]), 
                                style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              
                              ),),
                            //const SizedBox(width: 10,),
                            Row(
                              children: [
                                Text("${todayTempMax[index]} °C ",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red
                                  ),),
                                const Text("max",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 8,
                                    color: Colors.red
                                  ),),
                              ],
                            ),
                              
                            //const SizedBox(width: 20,),
                            Row(
                              children: [
                                Text("${todayTempMin[index]} °C ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade300
                                  ),),
                                Text("min",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 8,
                                    color: Colors.blue.shade300
                                  ),),
                              ],
                            ),
                            getImageByWeather(todayWeatherCode[index], 80),
                            Text(getWeatherCondition(todayWeatherCode[index])!.split(':')[0], 
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,

                            ),),
                        ]);
                      },
                      separatorBuilder: (context, index) => const SizedBox(width: 10,),
                      ))
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
          itemCount: snapshot.data.length >= 5 ? 5 : snapshot.data.length,
          itemBuilder: (context, index) {
            List<dynamic> cities = snapshot.data;
              return GestureDetector(
                onTap: () async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => FinalApp(city: cities[index], startIndex: currentIndex,))
                  );
                },
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.black12
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        const Icon(
                        Icons.location_city, 
                        color: Colors.white,
                        size: 21,),
                        const SizedBox(width: 8,),
                        Text(cities[index]['name'], style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white
                        ),),
                        const SizedBox(width: 8,),
                        Text("${cities[index]['admin1']}, ", 
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13
                          ) ,),
                       cities[index]['country'] != null ?
                        Text(cities[index]['country'], 
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13
                          ) ,) : const SizedBox.shrink()
                      ],
                    ),
                  )
                ),
              );
            },
          separatorBuilder: (context, index) => const Divider(
            height: 2,
            color: Colors.black,
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