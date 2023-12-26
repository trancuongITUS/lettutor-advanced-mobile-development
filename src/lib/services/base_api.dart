import 'package:src/services/api_service.dart';
import 'package:dio/dio.dart';

abstract class BaseAPI {
  late CancelToken cancelToken;
  late ApiService service;

  BaseAPI(String prefix) {
    String apiBaseUrl = "https://sandbox.api.lettutor.com/";

    service = ApiService("$apiBaseUrl$prefix");
    cancelToken = CancelToken();
  }
}