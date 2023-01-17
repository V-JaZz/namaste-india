import 'package:flutter/material.dart';
import '../models/userLoginDataModel.dart';

class UserDataStateMgmt extends ChangeNotifier {

  UserData? _userData;

  UserData? get userData => _userData;

  set userData(UserData? data){
    _userData = data;
    notifyListeners();
  }

}
