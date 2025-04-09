// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';
import 'package:match_maker/core/widgets/button.dart';
import 'package:match_maker/core/widgets/circular_progress_indicator.dart';
import 'package:match_maker/core/widgets/custom_toast.dart';
import 'package:match_maker/features/wallet/view_model/add_account_provider.dart';
import 'package:match_maker/features/wallet/view_model/otp_timer_provider.dart';
import 'package:match_maker/features/wallet/view_model/save_payment_model.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../core/app_theme.dart';
import '../../../core/utils/enum.dart';
import '../view_model/otp_provider.dart';
import '../view_model/redeem_detail_provider.dart';

class VerifyOTP extends StatelessWidget {
  const VerifyOTP({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final addAccountProvider =
        Provider.of<AccountProvider>(context, listen: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final otp = addAccountProvider.initiateEditModel?.hashedOtp;
      if (otp != null && otp.isNotEmpty) {
        CustomToast.showToast(
          message: "Otp is $otp",
          isError: false,
          context: context,
        );
      }
    });

    final otpTimerProvider = Provider.of<OTPTimerProvider>(context);
    final provider = Provider.of<SavePaymentProvider>(context, listen: true);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(context.borderRadius12),
              topRight: Radius.circular(context.borderRadius12))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Enter the 6-digit code sent to",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: context.font16,
                  color: AppTheme.black.withOpacity(0.4),
                  fontWeight: FontWeight.w500),
            ),
          ),
          Center(
            child: Text(
              "+91 7899606078",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: context.font16,
                  color: AppTheme.black,
                  fontWeight: FontWeight.w600),
            ),
          ),

          SizedBox(height: context.space16),
          // *** OTP Fields ****//

          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.space20),
            child: PinCodeTextField(
              appContext: context,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              autoFocus: true,
              keyboardType: TextInputType.number,
              cursorColor: AppTheme.black,
              cursorHeight: deviceWidth * 0.04,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: deviceWidth * 0.09,
                fieldWidth: deviceWidth * 0.08,
                inactiveFillColor: AppTheme.white,
                inactiveColor: AppTheme.grey,
                selectedColor: AppTheme.black,
                selectedFillColor: AppTheme.white,
                activeFillColor: AppTheme.white,
                activeColor: AppTheme.grey,
              ),
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: true,
              onChanged: (value) {
                print("otp sent for updating the provider - $value ");
                Provider.of<OtpProvider>(context, listen: false)
                    .updateOTP(value);
              },
            ),
          ),

          SizedBox(height: context.space16),
          Center(
            child: GestureDetector(
              onTap: otpTimerProvider.start == 0
                  ? otpTimerProvider.resendOTP
                  : null,
              child: Selector<OTPTimerProvider, int>(
                  selector: (context, provider) => provider.start,
                  builder: (context, start, _) {
                    return Text(
                      start == 0 ? "Resend OTP" : "Resend OTP in ${start}s",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: context.font16,
                          color: AppTheme.black.withOpacity(0.4),
                          fontWeight: FontWeight.w500),
                    );
                  }),
            ),
          ),

          SizedBox(height: context.space16),
          // *** Add Button ***//
          CustomButton(
            content: provider.isSubmitting
                ? CustomCircularProgressIndicator(
                    color: AppTheme.white,
                    height: context.space20,
                    width: context.space20,
                  )
                : Text(
                    "Verify Bank Account",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: AppTheme.white,
                      fontWeight: FontWeight.bold,
                      fontSize: context.font14,
                    ),
                  ),
            onTap: () async {
              final otp = Provider.of<OtpProvider>(context, listen: false).otp;
              if (otp.length != 6 || otp.isEmpty) {
                CustomToast.showToast(
                  context: context,
                  isError: true,
                  message: "Please enter 6-digit OTP",
                );
                return;
              }
              print(
                  "************ print to check otp sent  --- $otp **********");
              // *** save bank account
              final result = await provider.savePayment(
                otp: otp,
                hastedDetails:
                    addAccountProvider.accountModel?.hashtedDetails ?? "",
                hastedOtp: addAccountProvider.accountModel?.hashedOtp ?? "",
              );

              if (provider.state == ViewState.loaded) {
                final redeemProvider =
                    Provider.of<RedeemDetailsProvider>(context, listen: false);
                redeemProvider.fetchRedeemDetails();

                CustomToast.showToast(
                  context: context,
                  isError: false,
                  message: "Payment Verified",
                );
                if (result) {
                  print("in the result ");
                  final redeemProvider = Provider.of<RedeemDetailsProvider>(
                      context,
                      listen: false);
                  redeemProvider.fetchRedeemDetails();
                  print("data fetched");

                  Navigator.pop(context, true);
                  Navigator.of(context).pop();
                  redeemProvider.fetchRedeemDetails();
                  Navigator.of(context).pop();
                } else {
                  print(
                      "error from verify otp else part -- ${provider.errorMessage}");
                  CustomToast.showToast(
                    context: context,
                    isError: true,
                    message: "Error: something went wrong",
                  );
                }
              } else if (provider.state == ViewState.error) {
                print(
                    "error from verify otp else if part -- ${provider.errorMessage}");
                CustomToast.showToast(
                  context: context,
                  isError: true,
                  message: "Error: something went wrong",
                );
              }
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          )
        ],
      ),
    );
  }
}
