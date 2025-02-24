import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class DioClient {
  final Dio _dio;
  final Logger _logger = Logger();

  DioClient({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              contentType: 'application/json',
              headers: {
                'Accept': 'application/json',
                'XApiKey': 'lwYV+xrZf8wvTDVMJTvYmW8M83d7a8=',
              },
            ));

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    _logger.i('GET request to $url with query parameters: $queryParameters');
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );
      _logger.i('GET response from $url: ${response.data}');
      return response;
    } on DioError catch (e) {
      _logger.e('GET request to $url failed', error: e);
      throw _handleDioError(e);
    }
  }

  Future<Response> post(String url, {Map<String, dynamic>? data}) async {
    _logger.i('POST request to $url with data: $data');
    try {
      final response = await _dio.post(
        url,
        data: data,
      );
      _logger.i('POST response from $url: ${response.data}');
      return response;
    } on DioError catch (e) {
      _logger.e('POST request to $url failed', error: e);
      throw _handleDioError(e);
    }
  }

  Future<Response> put(String url, {Map<String, dynamic>? data}) async {
    _logger.i('PUT request to $url with data: $data');
    try {
      final response = await _dio.put(
        url,
        data: data,
      );
      _logger.i('PUT response from $url: ${response.data}');
      return response;
    } on DioError catch (e) {
      _logger.e('PUT request to $url failed', error: e);
      throw _handleDioError(e);
    }
  }

  Future<Response> patch(String url, {Map<String, dynamic>? data}) async {
    _logger.i('PATCH request to $url with data: $data');
    try {
      final response = await _dio.patch(
        url,
        data: data,
      );
      _logger.i('PATCH response from $url: ${response.data}');
      return response;
    } on DioError catch (e) {
      _logger.e('PATCH request to $url failed', error: e);
      throw _handleDioError(e);
    }
  }

  Future<Response> delete(String url, {Map<String, dynamic>? data}) async {
    _logger.i('DELETE request to $url with data: $data');
    try {
      final response = await _dio.delete(
        url,
        data: data,
      );
      _logger.i('DELETE response from $url: ${response.data}');
      return response;
    } on DioError catch (e) {
      _logger.e('DELETE request to $url failed', error: e);
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioError e) {
    if (e.response != null) {
      _logger.w('DioError [${e.response?.statusCode}]: ${e.response?.data}');
      return Exception(
          'DioError [${e.response?.statusCode}]: ${e.response?.data}');
    } else {
      _logger.w('DioError: ${e.message}');
      return Exception('DioError: ${e.message}');
    }
  }
}

class DioClientWithToken {
  final Dio _dio;
  final Logger _logger = Logger();

  DioClientWithToken({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              contentType: 'application/json',
            ));

  Future<String?> _getBearerToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('bearer_token');
      _logger.i('Retrieved bearer token: $token');
      return token;
    } catch (e) {
      _logger.e("Failed to retrieve bearer token", error: e);
      throw Exception("Failed to retrieve bearer token: ${e.toString()}");
    }
  }

  Future<Response> _requestWithToken(String method, String url,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    _logger.i(
        '$method request to $url with data: $data and query parameters: $queryParameters');
    try {
      String? token = await _getBearerToken();
      if (token == null) {
        _logger.w('Bearer token not available.');
        throw Exception("Bearer token not available.");
      }

      final options = Options(
        method: method,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'XApiKey': 'lwYV+xrZf8wvTDVMJTvYmW8M83d7a8=',
        },
      );

      final response = await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      _logger.i('$method response from $url: ${response.data}');
      return response;
    } on DioError catch (e) {
      _logger.e('$method request to $url failed', error: e);
      throw _handleDioError(e);
    }
  }

  Future<Response> post(String url, {Map<String, dynamic>? data}) {
    return _requestWithToken('POST', url, data: data);
  }

  Future<Response> get(String url, {Map<String, dynamic>? queryParameters}) {
    return _requestWithToken('GET', url, queryParameters: queryParameters);
  }

  Future<Response> put(String url, {Map<String, dynamic>? data}) {
    return _requestWithToken('PUT', url, data: data);
  }

  Future<Response> delete(String url, {Map<String, dynamic>? data}) {
    return _requestWithToken('DELETE', url, data: data);
  }

  Exception _handleDioError(DioError e) {
    if (e.response != null) {
      _logger.w('DioError [${e.response?.statusCode}]: ${e.response?.data}');
      return Exception(
          'DioError [${e.response?.statusCode}]: ${e.response?.data}');
    } else {
      _logger.w('DioError: ${e.message}');
      return Exception('DioError: ${e.message}');
    }
  }
}
