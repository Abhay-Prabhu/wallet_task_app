import 'package:flutter/material.dart';
import 'package:match_maker/core/utils/enum.dart';
import 'package:match_maker/features/wallet/models/delete_redeem_detail_model.dart';
import 'package:match_maker/features/wallet/models/initiate_delete_redeem_details.dart';
import 'package:match_maker/features/wallet/models/redeem_details_model.dart';
import 'package:match_maker/features/wallet/services/wallet_service.dart';

class RedeemDetailsProvider extends ChangeNotifier {
  ViewState _state = ViewState.initial;
  ViewState get state => _state;

  ReedemDetailsModel? _redeemDetails;
  String? _errorMessage;

  ReedemDetailsModel? get redeemDetails => _redeemDetails;
  String? get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isAccountNull = false;
  bool _isUpiNull = false;

  bool get isBankAccountNull => _isAccountNull;
  bool get isBankUpiNull => _isUpiNull;

  bool _otpVerificationSuccessful = false;
  bool get otpVerificationSuccessful => _otpVerificationSuccessful;

  void setOtpVerificationSuccessful(bool value) {
    _otpVerificationSuccessful = value;
    notifyListeners();
  }

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  setFlags(bool isAccountNull, bool isUpiNull) {
    _isAccountNull = isAccountNull;
    _isUpiNull = isUpiNull;
    print("print from set flags bank - $_isAccountNull, upi $isUpiNull");
  }

  Future<void> fetchRedeemDetails() async {
    _isLoading = true;
    _setState(ViewState.loading);
    notifyListeners();

    try {
      final result = await WalletService.redeemDetails();
      notifyListeners();
      if (result != null) {
        print(
            "print from fetch redeem details - bank ${result.data!.every((element) => element.bankAccountDetails == null)}, upi - ${result.data!.every((element) => element.upi == null)}");
        setFlags(
            result.data!.every((element) => element.bankAccountDetails == null),
            result.data!.every((element) => element.upi == null));
        _redeemDetails = result;
        _errorMessage = null;
        _setState(ViewState.loaded);
        notifyListeners();
      } else {
        _errorMessage = 'Failed to load redeem details....';
        _setState(ViewState.error);
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ViewState.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  InitiateDeleteRedeemDetailModel? initiateDeleteModel;
  ViewState _initiateDeleteState = ViewState.initial;
  String? _initiateDeleteError;

  ViewState get initiateDeleteState => _initiateDeleteState;
  String? get initiateDeleteError => _initiateDeleteError;

  Future<void> initiateDelete(String paymentMethod) async {
    _initiateDeleteState = ViewState.loading;
    notifyListeners();

    try {
      final response = await WalletService.initiateDeletePayment(
        paymentMethod: paymentMethod,
      );

      if (response != null) {
        initiateDeleteModel = response;
        _initiateDeleteError = null;
        _initiateDeleteState = ViewState.loaded;
      } else {
        _initiateDeleteError = 'Failed to initiate delete';
        _initiateDeleteState = ViewState.error;
      }
    } catch (e) {
      _initiateDeleteError = e.toString();
      _initiateDeleteState = ViewState.error;
    }

    notifyListeners();
  }

  DeleteRedeemDetailModel? _deleteRedeemDetailModel;
  ViewState _deleteRedeemState = ViewState.initial;
  String? _deleteRedeemError;

  DeleteRedeemDetailModel? get deleteRedeemDetailModel =>
      _deleteRedeemDetailModel;
  ViewState get deleteRedeemState => _deleteRedeemState;
  String? get deleteRedeemError => _deleteRedeemError;

  Future<void> deleteRedeem() async {
    _deleteRedeemState = ViewState.loading;
    try {
      if (initiateDeleteModel!.hashedOtp == null) {
        throw Exception("Token not initialized");
      }

      final response = await WalletService.deleteRedeemDetail(
          initialDeleteModel: initiateDeleteModel!);
      if (response != null) {
        _deleteRedeemDetailModel = response;
        _deleteRedeemError = null;
        _deleteRedeemState = ViewState.loaded;
      } else {
        _deleteRedeemError = 'Failed to initiate delete';
        _deleteRedeemState = ViewState.error;
      }
    } catch (e) {
      _deleteRedeemError = e.toString();
      _deleteRedeemState = ViewState.error;
    }

    notifyListeners();
  }
}
