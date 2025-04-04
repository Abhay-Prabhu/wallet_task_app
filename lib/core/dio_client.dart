import 'package:dio/dio.dart';
import 'package:match_maker/core/constants/api_end_points.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiEndPoints.baseUrl,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    headers: {"Content-Type": "application/json",},
    
  ));

  static Dio get dio => _dio;

  // ** Function to update auth token
  static void updateAuthToken({required String token}) {
    _dio.options.headers["Authorization"] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2N2VjYzk0OGE0NTBiYzhhOTA1OGNlMzMiLCJfcGhvbmVOdW1iZXIiOiI3NjIwMTQ2Mzc5IiwidXNlclR5cGVJZCI6IjY3MGNhMGQ0NDllNGVmOGZmODRiM2U5NyIsInVzZXJUeXBlIjoibWF0Y2htYWtlciIsImlhdCI6MTc0Mzc1NzY3NiwiZXhwIjoxNzQzNzc5Mjc2fQ.u5nk_Doj6bE8OiHOKCtdIA9WAFkCX0hFgiAmaPkIbPc";

    print("Updated Headers: ${_dio.options.headers}");
  }
}
