import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:xyba/network/api_constant.dart';

class ApiClient {
  late Dio _dio;
  ApiClient() {
    _dio = getApiClient();
  }
  Dio getApiClient() {
    Dio _dio = Dio();
    _dio.options = BaseOptions(connectTimeout: 50000, receiveTimeout: 50000);
    _dio.interceptors.clear();
    // _dio.options.headers["content-type"] = "application/json";
    // _dio.options.headers["accept"] = "application/json";
    _dio.options.baseUrl = BASE_URL;
    return _dio;
  }

  Future<dynamic> registerUser(Map<String, dynamic>? data) async {
    try {
      Response response = await _dio.post(REGISTER_URL,
          data: data, options: Options(responseType: ResponseType.plain));
      var data1 = json.decode(response.data);
      return data1;
    } on DioError catch (e) {
      print(e.response!.data);
      return e.response!.data;
    }
  }
}
