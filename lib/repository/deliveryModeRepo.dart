import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/registerDataModel.dart';
import '../networking/api_base_helper.dart';

class DeliveryModeRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext _context;

  DeliveryModeRepo(this._context);

  Future<RegisterUser?> deliveryModeUserDetails(
      {required String firstName,
      required String lastName,
      required String contact,
      required String email,
      required String houseNo,
      required String street,
      required String city,
      required String address,
      required String postCode,
      String? token}) async {

    try {
      final response = await _helper.post(ApiBaseHelper.register,
          jsonEncode(<String, String>{'firstName':firstName,'lastName':lastName,'contact':contact,'email':email,'houseNumber':houseNo,'street':street,'city':city,'address':address,'postcode':postCode}), token?? "");

      print("ResponseData $response");

      RegisterUser model =
      RegisterUser.fromJson(_helper.returnResponse(_context, response));

      print("model response:");
      print(model.success);

      return model;
    } catch (e) {
      return null;
    }
  }
}
