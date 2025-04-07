import 'package:dio/dio.dart';
import 'package:match_maker/core/constants/api_end_points.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiEndPoints.baseUrl,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    headers: {
      "Content-Type": "application/json",
    },
  ));

  static Dio get dio => _dio;

  // ** Function to update auth token
  static void updateAuthToken({required String token}) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
    print("Updated Headers: ${_dio.options.headers}");
  }
}
