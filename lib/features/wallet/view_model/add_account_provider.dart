import 'package:flutter/material.dart';
import 'package:match_maker/core/utils/enum.dart';
import 'package:match_maker/features/wallet/models/initiate_edit_redeem_model.dart';
import 'package:match_maker/features/wallet/models/verify_payment_model.dart';
import 'package:match_maker/features/wallet/services/wallet_service.dart';

class AccountProvider extends ChangeNotifier {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController confirmAccountNumberController =
      TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController bankBranchController = TextEditingController();

  ViewState _state = ViewState.initial;
  ViewState get state => _state;

  GlobalKey<FormState> get formKey => _formKey;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool get isSubmitting => _state == ViewState.loading;

  bool isEditMode = false;
  String? bankAccountNumber;

  VerifyPaymentModel? accountModel;
  InitiateEditPaymentModel? initiateEditModel;

  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  void clearMessage() {
    _errorMessage = null;
    notifyListeners();
  }

  void setEditMode({
    required bool editMode,
    String? existingAccountNumber,
  }) {
    isEditMode = editMode;
    bankAccountNumber = existingAccountNumber;
    notifyListeners();
  }

  void initializeFields({
    required String bankName,
    required String accountNumber,
    required String confirmAccountNumber,
    required String ifscCode,
    required String bankBranch,
  }) {
    bankNameController.text = bankName;
    accountNumberController.text = accountNumber;
    confirmAccountNumberController.text = confirmAccountNumber;
    ifscCodeController.text = ifscCode;
    bankBranchController.text = bankBranch;
  }

  Future<void> submitForm({
    required bool isEditMode,
    required String walletId,
    required String paymentMethod,
  }) async {
    if (!formKey.currentState!.validate()) return;

    setState(ViewState.loading);
    try {
      if (isEditMode) {
        final response = await WalletService.initiateEditRedeem(
          walletId: walletId,
          paymentMethod: paymentMethod,
          bankAccountNumber: bankAccountNumber ?? accountNumberController.text,
          bankIfsc: ifscCodeController.text,
          bankName: bankNameController.text,
          bankBranch: bankBranchController.text,
        );

        final updatePaymentResponse = await WalletService.updateRedeem(
          hashedOtp: response?.hashedOtp ?? "",
          hashtedDetails: response?.hashtedDetails ?? "",
          message: response?.message ?? "",
        );

        print(
            "after completing the update : ${updatePaymentResponse?.message}");
        if (response != null) {
          // accountModel = response;
          _errorMessage = null;

          setState(ViewState.loaded);
          clearControllers();
        } else {
          _errorMessage = 'Failed to verify payment.';
          setState(ViewState.error);
        }
      } else {
        print(
            "Details sent for add payment walletId: $walletId , paymentMethod: $paymentMethod, ifsc: ${ifscCodeController.text}, bank name: ${bankNameController.text}, bank branch: ${bankBranchController.text}");
        final response = await WalletService.verifyAddPayment(
          walletId: walletId,
          paymentMethod: paymentMethod,
          bankIfsc: ifscCodeController.text,
          bankName: bankNameController.text,
          bankBranch: bankBranchController.text,
        );

        if (response != null) {
          accountModel = response;
          _errorMessage = null;
          setState(ViewState.loaded);
        } else {
          _errorMessage = 'Failed to verify payment.';
          setState(ViewState.error);
        }
        // });
      }
    } catch (e) {
      _errorMessage = e.toString();
      setState(ViewState.error);
    }
  }

  void disposeControllers() {
    bankNameController.dispose();
    accountNumberController.dispose();
    confirmAccountNumberController.dispose();
    ifscCodeController.dispose();
    bankBranchController.dispose();
  }

  void clearControllers() {
    bankNameController.clear();
    accountNumberController.clear();
    confirmAccountNumberController.clear();
    ifscCodeController.clear();
    bankBranchController.clear();
  }

  bool get isFormFilled {
  return bankNameController.text.isNotEmpty &&
      accountNumberController.text.isNotEmpty &&
      confirmAccountNumberController.text.isNotEmpty &&
      ifscCodeController.text.isNotEmpty &&
      bankBranchController.text.isNotEmpty &&
      accountNumberController.text == confirmAccountNumberController.text;
}

}
