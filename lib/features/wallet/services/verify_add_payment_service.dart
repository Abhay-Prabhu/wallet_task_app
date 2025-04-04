import 'package:dio/dio.dart';
import 'package:match_maker/core/constants/api_end_points.dart';
import 'package:match_maker/core/dio_client.dart';
import 'package:match_maker/features/wallet/models/check_balance_model.dart';
import 'package:match_maker/features/wallet/models/verify_payment_model.dart';

class WalletService {
  //***  dio instance
  static final Dio _dio = DioClient.dio;
  static final Dio dio = Dio();

  // ***  Verify add payment service
  static Future<VerifyAddPaymentModel?> verifyAddPayment(
      {required String walletId,
      required String paymentMethod,
      required String bankIfsc,
      required String bankName,
      required String bankBranch}) async {
    try {
      final response = await _dio.post(ApiEndPoints.verifyAddPayment, data: {
        "walletId": walletId,
        "paymentMethod": paymentMethod,
        "bankIfsc": bankIfsc,
        "bankName": bankName,
        "bankBranch": bankBranch
      });
      if (response.statusCode == 200) {
        return VerifyAddPaymentModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //********  check balance *****//
 static Future<CheckBalanceModel> checkBalance() async {
    try {
      final response1 = await dio.post("https://development.backend.matchmakers.life/api/v1/matchmaker/wallet/get-wallet-balance");
      final response = await _dio.post(ApiEndPoints.checkBalance);
      // if (response.statusCode == 200) {
        // return
        final data =  CheckBalanceModel.fromJson(response1.data);
        return data;
      // }
      // return null;
    } catch (e) {
      throw Exception(e.toString());  
    }
  }
}
