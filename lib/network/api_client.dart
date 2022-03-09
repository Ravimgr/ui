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
      return e.response!.data;
    }
  }

  Future<dynamic> verifyOtp(String otp, String deviceId, String userId) async {
    try {
      Response response = await _dio.post(VERIFY_OTP_URL + userId,
          data: {'otp': otp, 'deviceId': deviceId},
          options: Options(responseType: ResponseType.plain));
      var data1 = json.decode(response.data);
      return data1;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> loginUser(
      String email, String deviceId, String password) async {
    try {
      Response response = await _dio.post(LOGIN_URL,
          data: {'email': email, 'deviceId': deviceId, 'password': password},
          options: Options(responseType: ResponseType.plain));
      var data1 = json.decode(response.data);
      return data1;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> resendOtp(String contactNumber) async {
    try {
      Response response = await _dio.post(RESEND_OTP_URL,
          data: {'contact_number': contactNumber},
          options: Options(responseType: ResponseType.plain));
      var data1 = json.decode(response.data);
      return data1;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
}
