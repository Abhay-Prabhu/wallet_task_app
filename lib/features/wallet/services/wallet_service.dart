import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/api_end_points.dart';
import 'package:match_maker/core/dio_client.dart';
import 'package:match_maker/features/wallet/models/check_balance_model.dart';
import 'package:match_maker/features/wallet/models/delete_redeem_detail_model.dart';
import 'package:match_maker/features/wallet/models/initiate_delete_redeem_details.dart';
import 'package:match_maker/features/wallet/models/initiate_edit_redeem_model.dart';
import 'package:match_maker/features/wallet/models/redeem_details_model.dart';
import 'package:match_maker/features/wallet/models/save_payment_model.dart';
import 'package:match_maker/features/wallet/models/update_redeem_payment_model.dart';

import '../models/verify_payment_model.dart';

class WalletService {
  //***  dio instance
  static final Dio _dio = DioClient.dio;
  // static final Dio dio = Dio();

  // ***  Verify add payment service
  static Future<VerifyPaymentModel?> verifyAddPayment(
      {required String walletId,
      required String paymentMethod,
      required String bankIfsc,
      required String bankName,
      required String bankBranch}) async {
    try {
      final response = await _dio.post(ApiEndPoints.verifyAddPayment, data: {
        "walletId": walletId,
        "paymentMethod": paymentMethod,
        "bankAccountNumber": "0123456789012",
        "bankIfsc": bankIfsc,
        "bankName": bankName,
        "bankBranch": bankBranch
      });
      if (response.statusCode == 200) {
        print(
            "response from verify account service required otp  -- ${VerifyPaymentModel.fromJson(response.data).otp}");
        return VerifyPaymentModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

// ***  Save add payment service with providing OTP ***//
  static Future<SavePaymentModel?> savePaymentDetails({
    required String otp,
    required String hastedDetails,
    required String hastedOtp,
  }) async {
    try {
      final response = await _dio.post(ApiEndPoints.savePayment, data: {
        "otp": otp,
        "hashtedDetails": hastedDetails,
        "hashedOtp": hastedOtp,
      });
      if (response.statusCode == 201) {
        print(
            "save payments error --${response.statusCode} ${response.statusMessage}");
        print(
            "response from verify account service required otp  -- ${SavePaymentModel.fromJson(response.data).message}");
        return SavePaymentModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      print("save payments error --${e.message.toString()}");
      throw Exception(e.message);
    } catch (e) {
      print("save payments error catch error --${e.toString()}");
      throw Exception(e.toString());
    }
  }

//***  Redeem Details  ***//
  static Future<ReedemDetailsModel?> redeemDetails() async {
    try {
      final response = await _dio.get(ApiEndPoints.redeemDetail);
      if (response.statusCode == 200) {
        print(
            "Redeem Details  --${response.statusCode} ${response.statusMessage}");
        print(
            "Redeem Details data  -- ${ReedemDetailsModel.fromJson(response.data).data}");
        return ReedemDetailsModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      print("Redeem Details error --${e.message.toString()}");
      throw Exception(e.message);
    } catch (e) {
      print("Redeem Details catch error --${e.toString()}");
      throw Exception(e.toString());
    }
  }

  //********  check balance *****//
  static Future<CheckBalanceModel?> checkBalance() async {
    try {
      print("Updated Headers: ${_dio.options.headers}");
      debugPrint("check balance fn is called -- ");
      // final response1 = await dio.post(ApiEndPoints.checkBalance);
      final response = await _dio.get(ApiEndPoints.checkBalance);
      print(
          " Check balance Response ${response.statusCode} ${response.statusMessage}");
      if (response.statusCode == 200) {
        final data = CheckBalanceModel.fromJson(response.data);
        print(
            "data from check balance after .fromJson parsing  id of wallet -- ${data.data!.sId}");
        return data;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  // ***  Initiate Delete Payment ***//
  static Future<InitiateDeleteRedeemDetailModel?> initiateDeletePayment({
    required String paymentMethod,
  }) async {
    try {
      final response =
          await _dio.post(ApiEndPoints.initiateRedeemDelete, data: {
        "paymentMethod": paymentMethod,
      });
      if (response.statusCode == 200) {
        print(
            "Initiate Delete Redeem --${response.statusCode} ${response.statusMessage}");
        return InitiateDeleteRedeemDetailModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      print(
          "Initiate Delete Redeem dio exception service  --${e.message.toString()}");
      throw Exception(e.message);
    } catch (e) {
      print(
          "Initiate Delete Redeem Detail  error catch error --${e.toString()}");
      throw Exception(e.toString());
    }
  }

  DeleteRedeemDetailModel? deleteRedeemDetailModel;

  // ***   Delete Payment  ***//
  static Future<DeleteRedeemDetailModel?> deleteRedeemDetail({
    required InitiateDeleteRedeemDetailModel initialDeleteModel,
  }) async {
    try {
      String message = initialDeleteModel.message.toString();
      final regex = RegExp(r'\b\d{6}\b');
      final match = regex.firstMatch(message);

      // if (match != null) {
      String? otp = match?.group(0);
      print('OTP after masking: $otp');
      // }

      print(
          "Data sent for deleting the payment redeem --otp: $otp , token : ${initialDeleteModel.token}, hashedOtp : ${initialDeleteModel.hashedOtp} ");
      final response = await _dio.delete(
        ApiEndPoints.deleteRedeem,
        data: {
          "otp": otp,
          "token": initialDeleteModel.token,
          "hashedOtp": initialDeleteModel.hashedOtp,
        },
      );
      if (response.statusCode == 200) {
        print(
            " Delete  Redeem Permanently  --${response.statusCode} ${response.statusMessage}");
        return DeleteRedeemDetailModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      print(
          "Delete Redeem permanently dio exception service  --${e.message.toString()}");
      throw Exception(e.message);
    } catch (e) {
      print(
          "Delete Redeem Permanently Detail  error catch error --${e.toString()}");
      throw Exception(e.toString());
    }
  }

  // *** Initiate Edit Redeem Payment *** //
  static Future<InitiateEditPaymentModel?> initiateEditRedeem(
      {required String walletId,
      required String paymentMethod,
      required String bankAccountNumber,
      required String bankIfsc,
      required String bankName,
      required String bankBranch}) async {
    try {
      final response = await _dio.post(ApiEndPoints.initiateUpdate, data: {
        "walletId": walletId,
        "paymentMethod": paymentMethod,
        "bankAccountNumber": bankAccountNumber,
        "bankIfsc": bankIfsc,
        "bankName": bankName,
        "bankBranch": bankBranch
      });
      if (response.statusCode == 200) {
        print(
            "response from initiate edit redeem service otp  -- ${InitiateEditPaymentModel.fromJson(response.data).hashedOtp}");
        return InitiateEditPaymentModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // *** update Edit Redeem *** //
  static Future<UpdatePaymentModel?> updateRedeem({
    required String hashedOtp,
    required String hashtedDetails,
    required String message,
  }) async {
    try {
      print("initiate edit model details -- ");
      print(hashedOtp);
      print(hashtedDetails);
      print(message);
      final regex = RegExp(r'\b\d{6}\b');
      final match = regex.firstMatch(message);
      String? otp = match?.group(0);
      print('OTP after masking: $otp');
      print(
          "Data sent for Updating the payment redeem --otp: $otp , token : ${otp}, hashedOtp : ${hashedOtp} ");
      final response = await _dio.put(
        ApiEndPoints.updateRedeem,
        data: {
          "otp": otp,
          "hashtedDetails": hashtedDetails,
          "hashedOtp": hashedOtp,
        },
      );
      if (response.statusCode == 201) {
        print(
            " Update Redeem Payment  --${response.statusCode} ${response.statusMessage}");
        return UpdatePaymentModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      print(
          "Delete Redeem permanently dio exception service  --${e.message.toString()}");
      throw Exception(e.message);
    } catch (e) {
      print(
          "Delete Redeem Permanently Detail  error catch error --${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
