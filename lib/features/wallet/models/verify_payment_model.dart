class VerifyPaymentModel {
  String? otp;
  String? hashtedDetails;
  String? hashedOtp;

  VerifyPaymentModel({this.otp, this.hashtedDetails, this.hashedOtp});

  VerifyPaymentModel.fromJson(Map<String, dynamic> json) {
    otp = json['message'];
    hashtedDetails = json['hashtedDetails'];
    hashedOtp = json['hashedOtp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = otp;
    data['hashtedDetails'] = hashtedDetails;
    data['hashedOtp'] = hashedOtp;
    return data;
  }
}
