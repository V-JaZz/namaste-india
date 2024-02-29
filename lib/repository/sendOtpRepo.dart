import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/sendOtpModel.dart';
import '../networking/api_base_helper.dart';

class SendOtpRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext? _context;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  SendOtpRepository(this._context);

  Future<bool?> login(String phoneNumber) async {
    //invoking login
    var deviceType = "";
    try {
      final response = await _helper.post(ApiBaseHelper.sendOTP,
          jsonEncode(<String, String>{'contact': phoneNumber}), "");

      print("ResponseData $response");
      SendOTPModel model =
      SendOTPModel.fromJson(_helper.returnResponse(_context!, response));
      //Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      if (model.success==true) {
        print("model response");
        print(model.success);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
      //Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }
  }
}
