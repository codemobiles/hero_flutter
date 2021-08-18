import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hero_flutter/src/constants/network_api.dart';
import 'package:hero_flutter/src/models/product.dart';

class NetworkService {
  NetworkService._internal();

  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;

  static final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.baseUrl = NetworkAPI.baseURL;
          print(options.baseUrl + options.path);
          print(options.data);
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          await Future.delayed(Duration(seconds: 2));
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          switch (e.response?.statusCode) {
            case 301:
              break;
            case 401:
              break;
            default:
          }
          return handler.next(e);
        },
      ),
    );

  Future<List<Product>> getProduct() async {
    final response = await _dio.get(NetworkAPI.product);
    if (response.statusCode == 200) {
      return productFromJson(jsonEncode(response.data));
    }
    throw Exception();
  }
}
