class ApiEndPoints {
  //! ***** Base Url *****//
  static const String baseUrl =
      "https://development.backend.matchmakers.life/api/v1/matchmaker/";

  //! ******* Api End points ******//

  // ***** Wallet ******//
  //
  //
  //  *** verify add payment details
  static const verifyAddPayment = "$baseUrl/wallet/add-payment-details";

  // **** save payment details
  static const savePaymentDetails = "$baseUrl/wallet/save-payment-details";

  //  ***** check Balance **********  //
  static const checkBalance = "$baseUrl/wallet/get-wallet-balance";
}
