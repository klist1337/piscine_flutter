
import 'package:piscine_mobile/Module03/constant.dart';
import 'package:piscine_mobile/Module03/http_services.dart';

class DataService {
  static final DataService _singleton = DataService._internal();
  final HttpServices _httpServices = HttpServices(); 
  factory DataService() {
    return _singleton;
  }
  DataService._internal();

  Future<List<dynamic>?> getCities(String city) async {
    String path = "$GEOCODING_API_BASE_URL/search?name=$city&count=10&language=en&format=json";
    
    var response = await _httpServices.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      List<dynamic> data = response!.data['results'];
      return data;  
    }
    return null;
  }

  Future<dynamic> getCurrentWeather(double latitude, double longitude) async {
    String path = "$WEATHER_API_BASE_URL/forecast?latitude=$latitude&longitude=$longitude&current=apparent_temperature,weather_code,wind_speed_10m";
    var response = await _httpServices.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      final data = response?.data;
      return data;
    }
    return null;
  }

  Future<dynamic> getTodayWeather(double latitude, double longitude) async {
    String path = "$WEATHER_API_BASE_URL/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,apparent_temperature,weather_code,wind_speed_10m&forecast_days=1";
    var response = await _httpServices.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      final data = response?.data;
      return data;
    }
    return null;
  }
  
  Future<dynamic> getWeeklyWeather(double latitude, double longitude) async {
    String path = "$WEATHER_API_BASE_URL/forecast?latitude=$latitude&longitude=$longitude&daily=weather_code,temperature_2m_max,temperature_2m_min";

    var response = await _httpServices.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      final data = response?.data;
      return data;
    }
    return null;
  }
}