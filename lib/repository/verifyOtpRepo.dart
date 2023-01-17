import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namastey_india/models/userLoginDataModel.dart';
import 'package:provider/provider.dart';
import '../models/verifyOTPModel.dart';
import '../networking/api_base_helper.dart';
import '../networking/api_response.dart';
import '../ui/notification_permission.dart';
import '../ui/phone_otp.dart';
import '../ui/globals.dart' as globals;

class VerifyOtpRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext _context;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  VerifyOtpRepository(this._context);

  Future<dynamic> verifyOtp(String phoneNumber,String OTP) async {
    //invoking login
    var deviceType = "";
    try {
      final response = await _helper.post(ApiBaseHelper.verifyOTP,
          jsonEncode(<String, String>{'contact': phoneNumber,'otp':OTP}), "");

      print("ResponseData " + response.toString());
      VerifyOTPModel model =
      VerifyOTPModel.fromJson(_helper.returnResponse(_context, response));
      //Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
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
