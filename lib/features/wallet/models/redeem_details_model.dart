class ReedemDetailsModel {
  List<Data>? data;
  String? message;

  ReedemDetailsModel({this.data, this.message});

  ReedemDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  BankAccountDetails? bankAccountDetails;
  String? sId;
  String? userId;
  String? upi;
  String? walletId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.bankAccountDetails,
      this.sId,
      this.userId,
      this.upi,
      this.walletId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    bankAccountDetails = json['bank_account_details'] != null
        ? new BankAccountDetails.fromJson(json['bank_account_details'])
        : null;
    sId = json['_id'];
    userId = json['user_id'];
    upi = json['upi'];
    walletId = json['wallet_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bankAccountDetails != null) {
      data['bank_account_details'] = this.bankAccountDetails!.toJson();
    }
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['upi'] = this.upi;
    data['wallet_id'] = this.walletId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class BankAccountDetails {
  String? bankAccountNumber;
  String? bankIfsc;
  String? bankName;
  String? bankBranch;

  BankAccountDetails(
      {this.bankAccountNumber, this.bankIfsc, this.bankName, this.bankBranch});

  BankAccountDetails.fromJson(Map<String, dynamic> json) {
    bankAccountNumber = json['bank_account_number'];
    bankIfsc = json['bank_ifsc'];
    bankName = json['bank_name'];
    bankBranch = json['bank_branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_account_number'] = this.bankAccountNumber;
    data['bank_ifsc'] = this.bankIfsc;
    data['bank_name'] = this.bankName;
    data['bank_branch'] = this.bankBranch;
    return data;
  }
}
