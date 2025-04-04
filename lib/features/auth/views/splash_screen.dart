import 'package:flutter/material.dart';
import 'package:match_maker/core/dio_client.dart';
import 'package:match_maker/core/services/local_storage.dart';
import 'package:match_maker/features/wallet/services/verify_add_payment_service.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ***** hard code token untill auth is implemented ******//
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2N2VjYzk0OGE0NTBiYzhhOTA1OGNlMzMiLCJfcGhvbmVOdW1iZXIiOiI3NjIwMTQ2Mzc5IiwidXNlclR5cGVJZCI6IjY3MGNhMGQ0NDllNGVmOGZmODRiM2U5NyIsInVzZXJUeXBlIjoibWF0Y2htYWtlciIsImlhdCI6MTc0Mzc1MTA1OSwiZXhwIjoxNzQzNzcyNjU5fQ.brEOAOS16rSFfR6ibWkEIbdl6K98w3jI_X6wcIOUvfs";

    // store the token in local storage
    LocalStorage.saveToken(token);

    // update the token in auth header
    DioClient.updateAuthToken(token: LocalStorage.getToken().toString());
  
    // VerifyAddPaymentService.verifyAddPayment(walletId: walletId, paymentMethod: paymentMethod, bankIfsc: bankIfsc, bankName: bankName, bankBranch: bankBranch);

    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            print(WalletService.checkBalance());
            // print(WalletService.verifyAddPayment(walletId: "", paymentMethod: paymentMethod, bankIfsc: bankIfsc, bankName: bankName, bankBranch: bankBranch));
            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> WalletScreen()));

          }, child: Text(" Go to Home"))
        ],
      ),
    );
  }
}
