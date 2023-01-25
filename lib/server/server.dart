import 'package:dio/dio.dart';

class DioServer {
  static late Dio dio;

  static init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://store.advera.ps/api',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'lang': 'ar',
      'Content-Type': 'application/json',
      'token': token,
    };
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'lang': 'ar',
      'Content-Type': 'application/json',
      'token': token,
    };
    return await dio.delete(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> getData({
    String? token,
    Map<String, dynamic>? query,
    required String url,
  }) async {
    dio.options.headers = {
      'lang': 'ar',
      'Content-Type': 'application/json',
      'token': token,
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    String? token,
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'lang': 'ar',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> getDataProduct({
    String? token,
    Map<String, dynamic>? query,
    required String url,
    required int limit,
  }) async {
    dio.options.headers = {
      'lang': 'ar',
      'Content-Type': 'application/json',
      'token': token,
      'active': 0,
      'limit': limit
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> getDataCategory(
      {String? token,
      Map<String, dynamic>? query,
      required String url,
      required categoryId}) async {
    dio.options.headers = {
      'lang': 'ar',
      'Content-Type': 'application/json',
      'token': token,
      'active': 0,
      'limit': 70,
      'category_id': categoryId,
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> getDataSearch({
    String? token,
    Map<String, dynamic>? query,
    required String url,
  }) async {
    dio.options.headers = {
      'lang': 'ar',
      'Content-Type': 'application/json',
      'token': token,
      'active': 0,
      'limit': 70,
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
