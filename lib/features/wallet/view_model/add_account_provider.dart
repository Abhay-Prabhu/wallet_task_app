import 'package:flutter/material.dart';
import 'package:match_maker/core/utils/enum.dart';
import 'package:match_maker/features/wallet/models/verify_payment_model.dart';
import 'package:match_maker/features/wallet/services/wallet_service.dart';

class AddAccountProvider extends ChangeNotifier {
  static GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  ViewState _state = ViewState.initial;

  ViewState get state => _state;

  void setstate(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  GlobalKey<FormState> get formkey => _formkey;
  VerifyPaymentModel? accountModel;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  void clearMessage() {
    _errorMessage = null;
    notifyListeners();
  }

  bool _isSubmitting = false;
  bool get isSubmittimg => _isSubmitting;

  Future<void> submitForm({
    required String walletId,
    required String paymentMethod,
    required String bankAccountNumber,
    required String confirmAccountNumber,
    required String bankIfsc,
    required String bankName,
    required String bankBranch,
  }) async {
    if (!formkey.currentState!.validate()) return;
    setstate(ViewState.loading);
    try {
      final response = await WalletService.verifyAddPayment(
          walletId: walletId,
          paymentMethod: paymentMethod,
          bankIfsc: bankIfsc,
          bankName: bankName,
          bankBranch: bankBranch);
      if (response != null) {
        accountModel = response;
        _errorMessage = null;
        print("response from submit form ${response.otp}");
        setstate(ViewState.loaded);
      } else {
        _errorMessage = 'Failed to verify payment.';
        print(
            "error while submitting the form verify add bank account -- ${errorMessage}");
        setstate(ViewState.error);
      }
    } catch (e) {
      _errorMessage = e.toString();
      setstate(ViewState.error);
    }
  }
}
