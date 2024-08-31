import 'package:piscine_mobile/Modulel02/cities_model.dart';
import 'package:piscine_mobile/Modulel02/http_services.dart';

class DataService {
  static final DataService _singleton = DataService._internal();
  final HttpServices _httpServices = HttpServices(); 
  factory DataService() {
    return _singleton;
  }
  DataService._internal();

  Future<List<Cities>?> getCities(String city) async {
    String path = "/search?name=$city&count=10&language=en&format=json";
    
    var response = await _httpServices.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      List data = response!.data;
      List<Cities> cities = data.map((city) => Cities.fromJson(city)).toList();
      return cities;  
    }
    return null;
  }

}