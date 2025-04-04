import 'package:flutter/material.dart';
import 'package:match_maker/core/services/local_storage.dart';
import 'package:match_maker/features/wallet/models/check_balance_model.dart';
import 'package:match_maker/features/wallet/services/verify_add_payment_service.dart';

enum CheckBalanceStatus { initial, loading, success, error }

class CheckBalance extends ChangeNotifier {
  CheckBalanceModel? _checkBalanceData;
  bool _isLoading = false;
  String? _error;
  CheckBalanceStatus _status = CheckBalanceStatus.initial;

  CheckBalanceModel? get checkBalanceData => _checkBalanceData;
  bool get isLoading => _isLoading;
  String? get error => _error;
  CheckBalanceStatus get status => _status;

  // **** check balance ***** //
  Future<void> checkBalance() async {
    _status = CheckBalanceStatus.loading;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await WalletService.checkBalance();
      _checkBalanceData = response;

      if (response.data != null && response.data!.sId!.isNotEmpty) {
        await LocalStorage.saveWalletId(response.data?.sId ?? "");
      } else {
        _error = "something went wrong";
      }
    } catch (e) {
      _status = CheckBalanceStatus.error;
      _error = "Failed to fetch wallet balance ${e.toString()}";
    }

    _isLoading = false;
    notifyListeners();
  }
}
