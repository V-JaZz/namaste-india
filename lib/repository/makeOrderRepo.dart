import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namastey_india/models/orderModel.dart';
import 'package:namastey_india/models/orderResponseModel.dart';
import '../networking/api_base_helper.dart';

class MakeOrderRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext _context;

  MakeOrderRepo(this._context);

  Future<OrderResponseModel?> orderDetails(OrderModel orderModel,String token) async {

    try {
      final response = await _helper.post(ApiBaseHelper.register,
          orderModelToJson(orderModel), token);

      print("ResponseData $response");

      OrderResponseModel model =
      OrderResponseModel.fromJson(_helper.returnResponse(_context, response));

      print("model response:");
      print(model.success);

      return model;
    } catch (e) {
      return null;
    }
  }
}
