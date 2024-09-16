

import 'package:flutter/cupertino.dart';
import 'package:piscine_mobile/Module03/constant.dart';

String? getWeatherCondition(int code) {
  for (var map in weatherDescriptions)  {
    if (map['code'] == code) {
      return map['description'];
    }
  }
  return null;
}

Widget getImageByWeather(int code) {
  if (code == 0) {
    return Image.asset('assets/images/sunny.png', width: 200, height: 200);
  }
  else if (code> 0 && code <= 3) {
      return Image.asset('assets/images/cloudy.png', width: 200, height: 200);
  }
  else if (code >= 45 && code <= 48) {
      return Image.asset('assets/images/small_rain.png', width: 200, height: 200);
  }
  else if (code>= 51 && code <= 55) {
      return Image.asset('assets/images/small_rain.png', width: 200, height: 200);
  }
  else if (code>= 61 && code <= 75) {
      return Image.asset('assets/images/rain.png', width: 200, height: 200);
  }
  else if (code>= 61 && code <= 75) {
      return Image.asset('assets/images/rain.png', width: 200, height: 200);
  }
  else if (code == 77 || (code >= 85 && code <= 86)) {
      return Image.asset('assets/images/snowfall.png', width: 200, height: 200);
  }
  else if (code >= 80 && code <= 82) {
      return Image.asset('assets/images/rain.png', width: 200, height: 200);
  }
  else {
    return Image.asset('assets/images/thunder.png', width: 200, height: 200);
  }
}

double getMaxTemp(List<dynamic> temperature) {
  double max = temperature[0];
  for (var temp in temperature) {
    if (max < temp) {
      max = temp;
    }
  }
  return max;
}
double getMinTemp(List<dynamic> temperature) {
  double min = temperature[0];
  for (var temp in temperature) {
    if (min > temp) {
      min = temp;
    }
  }
  return min;
}