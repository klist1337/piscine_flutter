import 'package:dio/dio.dart';


class HttpServices {
  static final HttpServices _singleton = HttpServices._internal();
  final _dio = Dio();

  factory HttpServices() {
    return _singleton;
  }
  HttpServices._internal() {
    setup();
  }

  Future<void> setup({String? bearerToken}) async {
    final headers = {
      'Content-Type':'application/json'
    };
    if (bearerToken != null) {
       headers['Authorization'] = "Bearer $bearerToken";
    }
    final option = BaseOptions(
      headers: headers,
      validateStatus: (status) {
        if (status == null) return false;
        return status < 500;
      });
      _dio.options = option;
  }

  Future<Response?> post(String path, Map data) async {
    try {
      final response = await _dio.post(
        path,
        data: data);
      return response;
    }
    catch (e) {
      return null;
    }
  }

  Future<Response?> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
    }
    catch (e) {
      return null;
    }
  }
}