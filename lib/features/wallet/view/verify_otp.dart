import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';
import 'package:match_maker/core/widgets/button.dart';
import 'package:match_maker/core/widgets/circular_progress_indicator.dart';
import 'package:match_maker/core/widgets/custom_toast.dart';
import 'package:match_maker/features/wallet/view_model/add_account_provider.dart';
import 'package:match_maker/features/wallet/view_model/otp_timer_provider.dart';
import 'package:match_maker/features/wallet/view_model/save_payment_model.dart';
import 'package:provider/provider.dart';
import '../../../core/app_theme.dart';
import '../../../core/utils/enum.dart';
import '../view_model/otp_provider.dart';
import '../view_model/redeem_detail_provider.dart';
import '../widgets/otp_field.dart';

class VerifyOTP extends StatelessWidget {
  const VerifyOTP({super.key});

  @override
  Widget build(BuildContext context) {
    final otpTimerProvider = Provider.of<OTPTimerProvider>(context);
    final provider = Provider.of<SavePaymentProvider>(context, listen: true);
    final addAccountProvider = Provider.of<AccountProvider>(context);
    return Container(
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
              "+7899606078",
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

          Center(
            child: Wrap(
                spacing: context.space8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: List.generate(6, (index) {
                  return OTPField(index: index);
                })),
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
                CustomToast.showCustomToast(
                    context: context,
                    message: "Please enter 6-digit OTP",
                  );
                return;
              }
              // *** save bank account
              final result = await provider.savePayment(
                otp: otp,
                hastedDetails:
                    addAccountProvider.accountModel?.hashtedDetails ?? "",
                hastedOtp: addAccountProvider.accountModel?.hashedOtp ?? "",
              );

              if (provider.state == ViewState.loaded) {
                print("print from loaded from verify otp");
                final redeemProvider =
                    Provider.of<RedeemDetailsProvider>(context, listen: false);
                redeemProvider.fetchRedeemDetails();
                print("fetch is complete");

                CustomToast.showCustomToast(
                    context: context,
                    message: "Payment Verified: ${provider.paymentModel?.message ?? ''}",
                  );
                if (result) {
                  print("in the result ");
                  final redeemProvider = Provider.of<RedeemDetailsProvider>(
                      context,
                      listen: false);
                  redeemProvider.fetchRedeemDetails();
                  print("data fetched");

                  Navigator.pop(context, true);
                } else {
                  CustomToast.showCustomToast(
                    context: context,
                    message: "Error: ${provider.errorMessage}",
                  );
                }
              } else if (provider.state == ViewState.error) {
                CustomToast.showCustomToast(
                    context: context,
                    message: "Error: ${provider.errorMessage}",
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
