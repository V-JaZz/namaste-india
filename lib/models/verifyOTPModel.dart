class VerifyOTPModel {
  bool? success;
  VerifyOTPModel({this.success});

  VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }
}