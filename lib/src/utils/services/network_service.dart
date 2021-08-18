import 'package:dio/dio.dart';

class NetworkService {
  static final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.baseUrl = 'https://cmpos-demo.herokuapp.com/';
          print(options.baseUrl + options.path);
          print(options.data);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          switch (e.response?.statusCode){
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

  Future<Response> getProduct() async {
    final response = await _dio.get('products');
    return response;
  }


}
