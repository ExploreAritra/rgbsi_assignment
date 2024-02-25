import 'package:assignment/src/core/network/interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiBaseHelper {

  late final Dio _dio;

  ApiBaseHelper({required Dio dio, bool isTest = false}) {
    _dio = dio;
    if(!isTest) {
      _dio.options.connectTimeout = const Duration(milliseconds: 10000); //10s
      _dio.options.receiveTimeout = const Duration(milliseconds: 10000);
      _dio.interceptors.addAll([ErrorInterceptor()]);
    }
  }

  Future<Response?> getRequest(String endPoint,
      {Map<String, dynamic>? queryParameters}) async {
    Response? response;
    try {
      response = await _dio.get(endPoint, queryParameters: queryParameters);
    } on DioException catch (error, _) {
      debugPrint("Exception occurred: $error");
    }
    return response;
  }

  Future<Response?> postRequest(String endPoint, dynamic payload) async {
    Response? response;
    try {
      response = await _dio.post(endPoint, data: payload);
    } on DioException catch (error, _) {
      debugPrint("Exception occurred: $error");
    }
    return response;
  }

}
