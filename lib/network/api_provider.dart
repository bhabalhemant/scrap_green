import 'package:scrap_green/utils/constants.dart' as Constants;
import 'package:dio/dio.dart';

import 'custom_exception.dart';

class ApiProvider {
  ApiProvider._privateConstructor();

  static final ApiProvider instance = ApiProvider._privateConstructor();

  final Dio _dio = getDio();

  static Dio getDio() {
    Dio _dio = new Dio();
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    _dio.options.headers["Authorization"] =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.IlVuaXRlIFdlYnNpdGUhIg.J4xWoxsZ3DkDT_9Lh22afX53ZFzMbdfl_IlnfKmfXdY";
    return _dio;
  }

  final String _baseUrl = Constants.BASE_URL + "api/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await _dio.get(_baseUrl + url);
      if (response.statusCode == 200) {
        responseJson = response.data;
      } else {
        responseJson = _response(response);
      }
    } catch (error) {
      if (error is DioError) {
        throw FetchDataException(error.response.statusMessage);
      } else {
        throw FetchDataException('No Internet connection');
      }
    }
    return responseJson;
  }

  Future<dynamic> getQueryParam(String url, String queryParam) async {
    var responseJson;
    try {
      final response = await _dio.get(_baseUrl + url + "/" + queryParam);
      if (response.statusCode == 200) {
        responseJson = response.data;
      } else {
        responseJson = _response(response);
      }
    } catch (error) {
      if (error is DioError) {
        throw FetchDataException(error.response.statusMessage);
      } else {
        throw FetchDataException('No Internet connection');
      }
    }
    return responseJson;
  }

  Future<dynamic> getQueryParamKeyValue(
      String url, String key, String value) async {
    var responseJson;
    try {
      final response = await _dio.get(_baseUrl + url + "?" + key + "=" + value);
      if (response.statusCode == 200) {
        responseJson = response.data;
      } else {
        responseJson = _response(response);
      }
    } catch (error) {
      if (error is DioError) {
        throw FetchDataException(error.response.statusMessage);
      } else {
        throw FetchDataException('No Internet connection');
      }
    }
    return responseJson;
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    var responseJson;
    try {
      final response = await _dio.post(_baseUrl + url, data: body);
      if (response.statusCode == 200) {
        responseJson = response.data;
      } else {
        responseJson = _response(response);
      }
    } catch (error) {
      if (error is DioError) {
        throw FetchDataException(error.response.statusMessage);
      } else {
        throw FetchDataException('No Internet connection');
      }
    }
    return responseJson;
  }

  Future<dynamic> postFormData(String url, FormData body) async {
    var responseJson;
    try {
      final response = await _dio.post(_baseUrl + url, data: body);
      if (response.statusCode == 200) {
        responseJson = response.data;
      } else {
        responseJson = _response(response);
      }
    } catch (error) {
      if (error is DioError) {
        throw FetchDataException(error.response.statusMessage);
      } else {
        throw FetchDataException('No Internet connection');
      }
    }
    return responseJson;
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException('Bad request');
      case 401:
      case 403:
        throw UnauthorisedException('Unauthorized');
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
