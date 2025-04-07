import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';
import 'package:match_maker/core/services/local_storage.dart';
import 'package:match_maker/core/utils/enum.dart';
import 'package:match_maker/core/validations/validations.dart';
import 'package:match_maker/core/widgets/button.dart';
import 'package:match_maker/features/wallet/services/wallet_service.dart';
import 'package:match_maker/features/wallet/view/verify_otp.dart';
import 'package:match_maker/features/wallet/view_model/add_account_provider.dart';
import 'package:match_maker/features/wallet/view_model/save_payment_model.dart';
import 'package:match_maker/features/wallet/widgets/important_note.dart';
import 'package:provider/provider.dart';

import '../../../core/app_theme.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/divider.dart';

class AddBankAccount extends StatelessWidget {
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController confirmAccountNumberController =
      TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController bankBranchController = TextEditingController();

  AddBankAccount({super.key});

  void verifyBankAccountDetails({
    required String bankName,
    required String accountNumber,
    required String ifscNumber,
    required String bankBranch,
  }) async {
    final result = await WalletService.verifyAddPayment(
        walletId: LocalStorage.getWalletId().toString(),
        paymentMethod: "BANK_ACCOUNT",
        bankIfsc: ifscNumber,
        bankName: bankName,
        bankBranch: bankBranch);

    print("OTP after verifying add account details --  ${result!.otp}");
  }

  void clearController() {
    bankNameController.clear();
    accountNumberController.clear();
    confirmAccountNumberController.clear();
    ifscCodeController.clear();
    bankBranchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddAccountProvider>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(context.borderRadius12),
              topRight: Radius.circular(context.borderRadius12))),
      child: Padding(
        padding: EdgeInsets.all(context.padding24),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUnfocus,
            key: provider.formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  runSpacing: context.space8,
                  alignment: WrapAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: AppTheme.darkGold,
                        weight: 35,
                      ),
                    ),
                    SizedBox(
                      width: context.space12,
                    ),
                    Text(
                      "Add Bank Account",
                      style: TextStyle(
                          fontSize: 18,
                          color: AppTheme.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: context.space16),
                CustomDivider(
                    width: double.infinity,
                    height: context.dividerHeight,
                    gradientList: [AppTheme.darkGold, AppTheme.gradient3]),
                SizedBox(height: context.space16),

                // ** Bank Name ** //
                Text(
                  "Bank Name",
                  style: TextStyle(
                      fontSize: context.font16,
                      color: AppTheme.black,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: context.space4,
                ),
                CustomFormField(
                  textController: bankNameController,
                  validator: (value) => Validations.validateBankName(value),
                  hintText: "Example: State Bank of India",
                ),
                SizedBox(height: context.space16),
                // ** Account Number ***//
                Text(
                  "Account Number",
                  style: TextStyle(
                      fontSize: context.font16,
                      color: AppTheme.black,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: context.space4,
                ),
                CustomFormField(
                  textController: accountNumberController,
                  validator: (value) =>
                      Validations.validateAccountNumber(value),
                  hintText: "Example: 123456789012",
                ),
                SizedBox(height: context.space16),
                // ** Confirm Account NUmber ***//
                Text(
                  "Confirm Account NUmber",
                  style: TextStyle(
                      fontSize: context.font16,
                      color: AppTheme.black,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: context.space4,
                ),
                CustomFormField(
                  textController: confirmAccountNumberController,
                  validator: (value) =>
                      Validations.validateAccountNumber(value),
                  hintText: "Example: 123456789012",
                ),
                SizedBox(height: context.space16),
                // **** IFSC Code ***//
                Text(
                  "IFSC Code",
                  style: TextStyle(
                      fontSize: context.font16,
                      color: AppTheme.black,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: context.space4,
                ),
                CustomFormField(
                  textController: ifscCodeController,
                  validator: (value) => Validations.validateIFSCNumber(value),
                  hintText: "Example: SBIN5678901",
                ),
                SizedBox(height: context.space16),
                // *** Bank Branch ***//
                Text(
                  "Bank Branch",
                  style: TextStyle(
                      fontSize: context.font16,
                      color: AppTheme.black,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: context.space4,
                ),
                CustomFormField(
                  textController: bankBranchController,
                  validator: (value) => Validations.validateBankBranch(value),
                  hintText: "KORAMANGALA",
                ),
                SizedBox(height: context.space16),
                //  *** Important Note ***//
                ImportantNote(),
                SizedBox(height: context.space16),
                // *** Add Bank Account Button ***//
                CustomButton(
                    content: provider.isSubmittimg
                        ? CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : Text(
                            "Add Bank Account",
                            style: TextStyle(
                              color: AppTheme.white,
                              fontWeight: FontWeight.bold,
                              fontSize: context.font14,
                            ),
                          ),
                    onTap: () async {
                      if (provider.formkey.currentState!.validate()) {
                        await provider.submitForm(
                          // walletId: "67ecc954a450bc8a9058ce43",
                          walletId: LocalStorage.getWalletId().toString(),
                          paymentMethod: "BANK_ACCOUNT",
                          bankAccountNumber: accountNumberController.text,
                          confirmAccountNumber:
                              confirmAccountNumberController.text,
                          bankIfsc: ifscCodeController.text,
                          bankName: bankNameController.text,
                          bankBranch: bankBranchController.text,
                        );

                        if (provider.state == ViewState.loaded) {
                          Navigator.of(context).pop();

                          // *** Schedule the next bottom sheet to be shown after this frame ***//
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Bottomsheet.showBottom(
                              context: context,
                              content: ChangeNotifierProvider(
                                create: (_) => SavePaymentProvider(),
                                child: VerifyOTP(),
                              ),
                              onDismissed: () => clearController(),
                            );
                          });
                          print("moving to next verify otp screen");
                        } else if (provider.state == ViewState.error) {
                          ScaffoldMessenger.of(
                                  Navigator.of(context, rootNavigator: true)
                                      .context)
                              .showSnackBar(
                            SnackBar(
                              content: Text(provider.errorMessage ??
                                  "Something went wrong"),
                            ),
                          );
                        }
                      }
                    }),

                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
