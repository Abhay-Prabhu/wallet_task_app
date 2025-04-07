import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';
import 'package:match_maker/core/widgets/button.dart';
import 'package:match_maker/features/wallet/view_model/add_account_provider.dart';
import 'package:match_maker/features/wallet/view_model/otp_timer_provider.dart';
import 'package:match_maker/features/wallet/view_model/save_payment_model.dart';
import 'package:provider/provider.dart';
import '../../../core/app_theme.dart';
import '../../../core/utils/enum.dart';
import '../view_model/otp_provider.dart';
import '../view_model/redeem_detail_provider.dart';
import '../widgets/divider.dart';
import '../widgets/otp_field.dart';

class VerifyOTP extends StatelessWidget {
  const VerifyOTP({super.key});

  @override
  Widget build(BuildContext context) {
    final otpTimerProvider = Provider.of<OTPTimerProvider>(context);
    final provider = Provider.of<SavePaymentProvider>(context, listen: true);
    final verifyAccountprovider =
        Provider.of<AddAccountProvider>(context, listen: true);
    String hastedDetails =
        verifyAccountprovider.accountModel?.hashtedDetails ?? "";
    String hastedOTP = verifyAccountprovider.accountModel?.hashedOtp ?? "";
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(context.borderRadius12),
              topRight: Radius.circular(context.borderRadius12))),
      child: Padding(
        padding: EdgeInsets.all(context.padding24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  GestureDetector(
                    onTap: Navigator.of(context).pop,
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
                    "Verify OTP",
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
              Center(
                child: Text(
                  "Enter the 6-digit code sent to",
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
                  onTap:
                      otpTimerProvider.start == 0
                          ? otpTimerProvider.resendOTP
                          : null,
                  child: Selector<OTPTimerProvider, int>(
                      selector: (context, provider) => provider.start,
                      builder: (context, start, _) {
                        return Text(
                          start == 0 ? "Resend OTP" : "Resend OTP in ${start}s",
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
                    ? CircularProgressIndicator()
                    : Text(
                        "Verify Bank Account",
                        style: TextStyle(
                          color: AppTheme.white,
                          fontWeight: FontWeight.bold,
                          fontSize: context.font14,
                        ),
                      ),
                onTap: () async {
                  final otp =
                      Provider.of<OtpProvider>(context, listen: false).otp;
                  if (otp.length != 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter 6-digit OTP")),
                    );
                    return;
                  }

                  await provider.savePayment(
                    otp: otp,
                    hastedDetails: hastedDetails,
                    hastedOtp: hastedOTP,
                  );

                  if (provider.state == ViewState.loaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              "Payment Verified: ${provider.paymentModel?.message ?? ''}")),
                    );

                    // *Schedule* the pop and refresh *after* the current frame:
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pop();
                      final redeemProvider = Provider.of<RedeemDetailsProvider>(
                          context,
                          listen: false);
                      redeemProvider.fetchRedeemDetails();
                    });
                  } else if (provider.state == ViewState.error) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Error: ${provider.errorMessage}")));
                  }
                },
              ),
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
