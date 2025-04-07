class InitiateDeleteRedeemDetailModel {
  String? message;
  String? token;
  String? hashedOtp;

  InitiateDeleteRedeemDetailModel({this.message, this.token, this.hashedOtp});

  InitiateDeleteRedeemDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    hashedOtp = json['hashedOtp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    data['hashedOtp'] = this.hashedOtp;
    return data;
  }
}
