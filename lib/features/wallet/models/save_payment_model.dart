class SavePayment {
  String? otp;
  String? hashtedDetails;
  String? hashedOtp;

  SavePayment({this.otp, this.hashtedDetails, this.hashedOtp});

  SavePayment.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    hashtedDetails = json['hashtedDetails'];
    hashedOtp = json['hashedOtp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['hashtedDetails'] = this.hashtedDetails;
    data['hashedOtp'] = this.hashedOtp;
    return data;
  }
}
