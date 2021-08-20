import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hero_flutter/src/constants/network_api.dart';
import 'package:hero_flutter/src/models/post.dart';
import 'package:hero_flutter/src/models/product.dart';
import 'package:http_parser/http_parser.dart';

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

  Future<String> addProduct(Product product, {File? imageFile}) async {
    FormData data = FormData.fromMap({
      'name': product.name,
      'price': product.price,
      'stock': product.stock,
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });

    final response = await _dio.post(NetworkAPI.product, data: data);
    if (response.statusCode == 201) {
      return 'Add Successfully';
    }
    throw Exception();
  }

  Future<String> editProduct(Product product, {File? imageFile}) async {
    FormData data = FormData.fromMap({
      'name': product.name,
      'price': product.price,
      'stock': product.stock,
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });

    final response =
        await _dio.put('${NetworkAPI.product}/${product.id}', data: data);
    if (response.statusCode == 200) {
      return 'Edit Successfully';
    }
    throw Exception();
  }

  Future<String> deleteProduct(int id) async {
    final response = await _dio.delete('${NetworkAPI.product}/$id');
    if (response.statusCode == 204) {
      return 'Delete Successfully';
    }
    throw Exception();
  }

  Future<List<Post>> fetchPosts(int startIndex, {int limit = 10}) async {
    final url =
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit';

    final Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      return postFromJson(jsonEncode(response.data));
    }
    throw Exception();
  }
}
