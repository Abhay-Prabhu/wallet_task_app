import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';
import 'package:match_maker/core/services/local_storage.dart';
import 'package:match_maker/core/widgets/button.dart';
import 'package:match_maker/features/wallet/services/verify_add_payment_service.dart';
import 'package:match_maker/features/wallet/view_model/check_balance_provider.dart';
import 'package:match_maker/features/wallet/widgets/select_account_type.dart';
import 'package:provider/provider.dart';

import '../../../core/app_theme.dart';
import '../widgets/bottom_sheet.dart';
import 'base_wallet_page.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // get my balance
    // final response = await WalletService.checkBalance();
    // print("${response.toString()}   ${response.data} ");

    // print(WalletService.verifyAddPayment(
    //   bankBranch: "ABCD",
    //   bankIfsc: "BANKIFSC123",
    //   bankName: "TEST_BANK",
    //   paymentMethod: "BANK_ACCOUNT",
    //   walletId: LocalStorage.getWalletId().toString(),
    // ));

    //  Future.delayed(Duration.zero, (){
    //   Provider.of<CheckBalance>(context, listen: false).checkBalance();
    //  });
    return BaseWalletPage(
      content: Padding(
        padding: EdgeInsets.all(context.padding24),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your accounts",
                      style: TextStyle(
                        fontSize: context.font16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: context.space12,
                    ),
                    Text(
                      "You can add up to 2 accounts",
                      style: TextStyle(
                          fontSize: context.font16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.grey),
                    ),
                  ],
                ),
              ),
              Center(
                // alignment: Alignment.center,
                child: Text(
                  "No payments accounts available",
                  style: TextStyle(
                      fontSize: context.font16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.grey),
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Provided account/UPI details will be used for purchases, transferring reward and cashbacks",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: context.font14,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.black),
                    ),
                    SizedBox(
                      height: context.space12,
                    ),
                    CustomButton(
                      onTap: () => Bottomsheet.showBottom(context: context, content: SelectAccountType()),
                      buttonText: "Add account",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       SizedBox(height: 50,),
    //       Consumer<CheckBalance>(builder:(context, provider, child){
    //         if(provider.status == CheckBalanceStatus.loading){
    //           print("check balance status is loading");
    //           return CircularProgressIndicator(
    //             color: Colors.black,
    //           );

    //         }
    //         else if (provider.status == CheckBalanceStatus.error){
    //           return Text("Error in fetching balance -- ${provider.error}");
    //         }
    //         else if(provider.status == CheckBalanceStatus.success){
    //           return Text("{Balance fetched successfully -- ${provider.checkBalanceData!.data}}");
    //         }
    //         return Text("last return");

    //       } ,)
    //     ],
    //   ),
    // );
  }
}
