class VerifyAddPaymentModel {
  String? walletId;
  String? paymentMethod;
  String? bankAccountNumber;
  String? bankIfsc;
  String? bankName;
  String? bankBranch;

  VerifyAddPaymentModel(
      {this.walletId,
      this.paymentMethod,
      this.bankAccountNumber,
      this.bankIfsc,
      this.bankName,
      this.bankBranch});

  VerifyAddPaymentModel.fromJson(Map<String, dynamic> json) {
    walletId = json['walletId'];
    paymentMethod = json['paymentMethod'];
    bankAccountNumber = json['bankAccountNumber'];
    bankIfsc = json['bankIfsc'];
    bankName = json['bankName'];
    bankBranch = json['bankBranch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['walletId'] = this.walletId;
    data['paymentMethod'] = this.paymentMethod;
    data['bankAccountNumber'] = this.bankAccountNumber;
    data['bankIfsc'] = this.bankIfsc;
    data['bankName'] = this.bankName;
    data['bankBranch'] = this.bankBranch;
    return data;
  }
}
