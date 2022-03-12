import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:xyba/models/login_model.dart';
import 'package:xyba/models/register_model.dart';
import 'package:xyba/models/resend_otp.dart';
import 'package:xyba/models/verify_otp_model.dart';
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
  } //register a user

  Future<RegisterResponseModel> register(
      RegisterRequestModel registerRequestModel) async {
    Dio _dio = getApiClient();
    var response =
        await _dio.post(REGISTER_URL, data: registerRequestModel.toJson());
    return RegisterResponseModel.fromJson(response.data);
  }

  //for verify otp
  Future<OtpResponseModel> otpVerify(
      String userId, OtpRequestModel otpRequestModel) async {
    Dio _dio = getApiClient();

    var response = await _dio.post(VERIFY_OTP_URL + userId,
        data: otpRequestModel.toJson());

    return OtpResponseModel.fromJson(response.data);
  }

  //For login
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    Dio _dio = getApiClient();
    var response = await _dio.post(LOGIN_URL, data: loginRequestModel.toJson());
    return LoginResponseModel.fromJson(response.data);
  }

  //for resend otp
  Future<ResendOtpResponseModel> resendOtpApi(
      ResendOtpRequestModel resendOtpRequestModel) async {
    Dio _dio = getApiClient();
    var response =
        await _dio.post(RESEND_OTP_URL, data: resendOtpRequestModel.toJson());
    return ResendOtpResponseModel.fromJson(response.data);
  }
}
