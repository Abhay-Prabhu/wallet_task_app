// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';
import 'package:match_maker/core/services/local_storage.dart';
import 'package:match_maker/core/utils/enum.dart';
import 'package:match_maker/core/validations/validations.dart';
import 'package:match_maker/core/widgets/button.dart';
import 'package:match_maker/core/widgets/circular_progress_indicator.dart';
import 'package:match_maker/features/wallet/models/redeem_details_model.dart';
import 'package:match_maker/features/wallet/services/wallet_service.dart';
import 'package:match_maker/features/wallet/view/verify_otp.dart';
import 'package:match_maker/features/wallet/view_model/add_account_provider.dart';
import 'package:match_maker/features/wallet/view_model/save_payment_model.dart';
import 'package:match_maker/features/wallet/widgets/important_note.dart';
import 'package:provider/provider.dart';
import '../../../core/app_theme.dart';
import '../../../core/widgets/custom_toast.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/custom_form_field.dart';

class AddEditBankAccount extends StatefulWidget {
  final BankAccountDetails? bankAccountmodel;
  final bool isEditMode;
  const AddEditBankAccount(
      {super.key, required this.isEditMode, this.bankAccountmodel});

  @override
  State<AddEditBankAccount> createState() => _AddEditBankAccountState();
}

class _AddEditBankAccountState extends State<AddEditBankAccount> {
  late AccountProvider provider;
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

  @override
  void initState() {
    super.initState();
    provider = Provider.of<AccountProvider>(context, listen: false);

    if (widget.isEditMode && widget.bankAccountmodel != null) {
      provider.initializeFields(
        accountNumber: widget.bankAccountmodel?.bankAccountNumber ?? "",
        bankBranch: widget.bankAccountmodel?.bankBranch ?? "",
        bankName: widget.bankAccountmodel?.bankName ?? "",
        confirmAccountNumber: widget.bankAccountmodel?.bankAccountNumber ?? "",
        ifscCode: widget.bankAccountmodel?.bankIfsc ?? "",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AccountProvider>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(context.borderRadius12),
              topRight: Radius.circular(context.borderRadius12))),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUnfocus,
          key: provider.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ** Bank Name ** //
              Text(
                "Bank Name",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: context.font16,
                    color: AppTheme.black,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: context.space4,
              ),
              CustomFormField(
                textController: provider.bankNameController,
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
                keyboardType: TextInputType.number,
                allowSpecialCharacters: false,
                isNumeric: true,
                textController: provider.accountNumberController,
                validator: (value) => Validations.validateAccountNumber(value),
                hintText: "Example: 123456789012",
              ),
              SizedBox(height: context.space16),
              // ** Confirm Account NUmber ***//
              Text(
                "Confirm Account Nmber",
                style: TextStyle(
                    fontSize: context.font16,
                    color: AppTheme.black,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: context.space4,
              ),
              CustomFormField(
                keyboardType: TextInputType.number,
                textController: provider.confirmAccountNumberController,
                validator: (value) => Validations.validateConfirmAccountNumber(value, provider.accountNumberController.text ),
                isNumeric: true,
                allowSpecialCharacters: false,
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
                textController: provider.ifscCodeController,
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
                textController: provider.bankBranchController,
                validator: (value) => Validations.validateBankBranch(value),
                hintText: "KORAMANGALA",
              ),
              SizedBox(height: context.space16),
              //  *** Important Note ***//
              ImportantNote(),
              SizedBox(height: context.space16),
              // *** Add Bank Account Button ***//
              CustomButton(
                  content: provider.isSubmitting
                      ? CustomCircularProgressIndicator(
                          color: AppTheme.white,
                          height: context.space20,
                          width: context.space20,
                        )
                      : Text(
                          widget.isEditMode
                              ? "Save Bank Account"
                              : "Add Bank Account",
                          style: TextStyle(
                            color: AppTheme.white,
                            fontWeight: FontWeight.bold,
                            fontSize: context.font14,
                          ),
                        ),
                  onTap: () async {
                    if (provider.formKey.currentState!.validate()) {
                      provider.isEditMode = widget.isEditMode;
                      await provider.submitForm(
                        isEditMode: widget.isEditMode,
                        walletId: LocalStorage.getWalletId().toString(),
                        paymentMethod: "BANK_ACCOUNT",
                      );

                      if (provider.state == ViewState.loaded) {
                        if (!widget.isEditMode) {
                          final otp =
                              provider.accountModel?.otp;
                            print("print from otp {}**************");
                            CustomToast.showToast(context: context,
                                message: "Otp is $otp", isError: false);
                          // *** Schedule the next bottom sheet to be shown after this frame ***//
                          WidgetsBinding.instance
                              .addPostFrameCallback((_) async {
                            await Bottomsheet.showBottom(
                              title: "Verify OTP",
                              context: context,
                              content: ChangeNotifierProvider(
                                create: (_) => SavePaymentProvider(),
                                child: VerifyOTP(),
                              ),
                            );  
                          });
                        }
                      } else if (provider.state == ViewState.error) {
                        
                        

                        CustomToast.showToast(context: context,
                          isError: true,
                          message: "Something went wrong",
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
    );
  }
}
