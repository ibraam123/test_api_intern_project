import 'package:dio/dio.dart';

Dio createDio() {
  Dio dio = Dio();
  dio.options.baseUrl = "https://marchaindisersbackend.onrender.com";
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);
  dio.options.headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODYzZDIwNjBkOTA2M2RjNGI3NzU5N2EiLCJpYXQiOjE3NTEzNzIyOTUsImV4cCI6MTc1OTE0ODI5NX0.3LSBcWQDdxrugBs8lA1LHoXriq2TFaKt-hnS4Z26Jsw",
  };
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestBody: true,
    responseBody: true,
    requestHeader: true,
    responseHeader: true,
    error: true,

  ));
  return dio;
}
