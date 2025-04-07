class ApiEndPoints {
  //! ***** Base Url *****//
  static const String baseUrl =
      "https://development.backend.matchmakers.life/api/v1/matchmaker/";

  //! ******* Api End points ******//

  // ***** Wallet ******//
  //
  //
  //  *** verify add payment details
  static const verifyAddPayment = "/wallet/add-payment-details";

  // **** save payment details
  static const savePayment = "/wallet/save-payment-details";

  //  ***** check Balance **********  //
  static const checkBalance = "/wallet/get-wallet-balance";

  // *** Redeem Details ***//
  static const redeemDetail = "/wallet/get-redeem-details";

  // *** Initiate Delete Payment *** //
  static const initiateRedeemDelete = "/wallet/initiate-deleting-redeem-details";

  // *** Delete Redeem Details *** //
  static const deleteRedeem = "/wallet/delete-redeem-details";
}
