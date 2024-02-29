import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namastey_india/models/loginDataModel.dart';
import '../models/verifyOTPModel.dart';
import '../networking/api_base_helper.dart';

class VerifyOtpRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext _context;

  VerifyOtpRepository(this._context);

  Future<dynamic> verifyOtp(String phoneNumber,String OTP) async {
    //invoking login
    var deviceType = "";
    try {
      final response = await _helper.post(ApiBaseHelper.verifyOTP,
          jsonEncode(<String, String>{'contact': phoneNumber,'otp':OTP}), "");

      print("ResponseData $response");
      VerifyOTPModel model =
      VerifyOTPModel.fromJson(_helper.returnResponse(_context, response));
      if (model.success == true) {

        print("model response");
        print(model.success);

        final userDataModel = UserDataModel.fromJson(json.decode(response.body.toString()));
        return userDataModel;
      } else {
        return false;
      }
    } catch (e) {
      return null;
      //Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }
  }
}
