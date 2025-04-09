class InitiateEditPaymentModel {
  String? message;
  String? hashtedDetails;
  String? hashedOtp;

  InitiateEditPaymentModel({this.message, this.hashtedDetails, this.hashedOtp});

  InitiateEditPaymentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    hashtedDetails = json['hashtedDetails'];
    hashedOtp = json['hashedOtp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['hashtedDetails'] = this.hashtedDetails;
    data['hashedOtp'] = this.hashedOtp;
    return data;
  }
}
