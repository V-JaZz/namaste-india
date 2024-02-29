import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/registerDataModel.dart';
import '../networking/api_base_helper.dart';

class PickUpModeRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext _context;

  PickUpModeRepo(this._context);

  Future<RegisterUser?> pickUpModeUserDetails(
      {required String firstName,
      required String lastName,
      required String contact,
      required String email,
      String? token}) async {

    try {
      final response = await _helper.post(ApiBaseHelper.register,
          jsonEncode(<String, String>{'firstName':firstName,'lastName':lastName,'contact':contact,'email':email}), token?? "");

      print("ResponseData $response");

      RegisterUser model =
      RegisterUser.fromJson(_helper.returnResponse(_context, response));
      //Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

        print("model response:");
        print(model.success);

        // final userDataModel = UserDataModel.fromJson(json.decode(response.body.toString()));
        return model;
    } catch (e) {
      return null;
    }
  }
}
