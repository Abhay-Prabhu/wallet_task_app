import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';
import 'package:match_maker/core/dio_client.dart';
import 'package:match_maker/core/services/local_storage.dart';
import 'package:match_maker/core/widgets/button.dart';
import 'package:match_maker/features/wallet/services/wallet_service.dart';
import 'package:match_maker/features/wallet/view/wallet_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/app_theme.dart';
import '../../wallet/view_model/redeem_detail_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ***** hard code token untill auth is implemented ******//
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2N2VjYzk0OGE0NTBiYzhhOTA1OGNlMzMiLCJfcGhvbmVOdW1iZXIiOiI3NjIwMTQ2Mzc5IiwidXNlclR5cGVJZCI6IjY3MGNhMGQ0NDllNGVmOGZmODRiM2U5NyIsInVzZXJUeXBlIjoibWF0Y2htYWtlciIsImlhdCI6MTc0NDE5NDk4OSwiZXhwIjoxNzQ0MjE2NTg5fQ._Qqu9Y-tiBcJh5-XugiPc5WVLr-HtseErpCG5c34h7M";
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(context.space16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
                onTap: () async {
                  LocalStorage.saveToken(token);
                  // *** update the token in auth header ***//
                  DioClient.updateAuthToken(
                      token: LocalStorage.getToken().toString());
                  // *** store the token in local storage ***//

                  debugPrint(
                      "status of token storing in local storage ${LocalStorage.getToken()}");
                  final walletData = await WalletService.checkBalance();

                  // *** store wallet Id in Local Storage *** //
                  LocalStorage.saveWalletId(walletData!.data!.sId.toString());
                  print(
                      "Wallet Id from local storage ${LocalStorage.getWalletId()}");

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (_) =>
                            RedeemDetailsProvider()..fetchRedeemDetails(),
                        child: WalletScreen(),
                      ),
                    ),
                  );
                },
                content: Text(
                  "Login",
                  style: TextStyle(
                    color: AppTheme.white,
                    fontWeight: FontWeight.bold,
                    fontSize: context.font14,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}


