class CheckBalanceModel {
  Data? data;
  int? totalbalance;
  String? message;

  CheckBalanceModel({this.data, this.totalbalance, this.message});

  CheckBalanceModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    totalbalance = json['totalbalance'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['totalbalance'] = this.totalbalance;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? sId;
  String? userId;
  int? currentWithdrawableClosingBalance;
  int? currentNonWithdrawableClosingBalance;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.userId,
      this.currentWithdrawableClosingBalance,
      this.currentNonWithdrawableClosingBalance,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    currentWithdrawableClosingBalance =
        json['current_withdrawable_closing_balance'];
    currentNonWithdrawableClosingBalance =
        json['current_non_withdrawable_closing_balance'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['current_withdrawable_closing_balance'] =
        this.currentWithdrawableClosingBalance;
    data['current_non_withdrawable_closing_balance'] =
        this.currentNonWithdrawableClosingBalance;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
