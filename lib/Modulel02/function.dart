

import 'package:piscine_mobile/Modulel02/constant.dart';

String? getWeatherCondition(int code) {
  for (var map in weatherDescriptions)  {
    if (map['code'] == code) {
      return map['description'];
    }
  }
  return null;
}