import 'package:flutter/material.dart';
import 'package:match_maker/core/utils/enum.dart';
import 'package:match_maker/features/wallet/models/save_payment_model.dart';
import 'package:match_maker/features/wallet/services/wallet_service.dart';

class SavePaymentProvider extends ChangeNotifier {
  ViewState _state = ViewState.initial;
  ViewState get state => _state;

  SavePaymentModel? _paymentModel;
  String? _errorMessage;

  bool _isSubmitting = false;

  SavePaymentModel? get paymentModel => _paymentModel;
  String? get errorMessage => _errorMessage;
  bool get isSubmitting => _isSubmitting;

  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  void clearMessage() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> savePayment({
    required String otp,
    required String hastedDetails,
    required String hastedOtp,
  }) async {
    setState(ViewState.loading);
    _isSubmitting = true;
    notifyListeners();

    try {
      final response = await WalletService.savePaymentDetails(
        otp: otp,
        hastedDetails: hastedDetails,
        hastedOtp: hastedOtp,
      );
      if (response != null) {
        _paymentModel = response;
        _errorMessage = null;
        setState(ViewState.loaded);
        return true;
      } else {
        _errorMessage = 'Failed to save payment details.';
        setState(ViewState.error);
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      print("error from verify otp provider -- ${_errorMessage}");
      setState(ViewState.error);
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
