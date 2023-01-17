class SendOTPModel {
  bool? success;
  String? message;
  SendOTPModel({this.success, this.message});

  SendOTPModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'] ?? "";
  }
}