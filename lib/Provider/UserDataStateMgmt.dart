import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../models/loginDataModel.dart';

class UserDataStateMgmt extends ChangeNotifier {

  UserData? _userData;
  UserData setUserData = UserData();
  Placemark? _userAddressByLoc;
  String _userPostCode = '60486';
  String _userAddress = 'Frankfurt';
  IconData userLocationIcon = Icons.location_searching_rounded;
  List<String> acceptedPostcodes = [];

  //User Data Getter Setter
  UserData? get userData => _userData;

  set userData(UserData? data){
    _userData = data;
    _userPostCode = userData?.postcode ??(userAddressByLoc?.postalCode ?? '60486') ;
    _userAddress = userData?.address ??(userAddressByLoc?.name ?? 'Frankfurt');
    notifyListeners();
  }

  //User Place mark Getter Setter
  Placemark? get userAddressByLoc => _userAddressByLoc;
  set userAddressByLoc(Placemark? data){
    _userAddressByLoc = data;
    userData?.postcode == null ? _userPostCode = userAddressByLoc?.postalCode ?? '60486':'60486';
    userData?.address == null ? _userAddress = userAddressByLoc?.name ?? 'Frankfurt':'Frankfurt';
    userLocationIcon = userAddressByLoc?.postalCode == null ? Icons.location_disabled_rounded : Icons.my_location_rounded;
    notifyListeners();
  }

  //User Post Code & Icon Getter Setter
  String get userPostCode => _userPostCode;
  set userPostCode(String data){

    if(data == ''){
      _userPostCode = userData?.postcode ??(userAddressByLoc?.postalCode ?? '60486') ;
      userLocationIcon = userAddressByLoc?.postalCode == null ? Icons.location_disabled_rounded : Icons.my_location_rounded;
    }else{
      _userPostCode = data;
      userLocationIcon = Icons.location_city_rounded ;
    }
    notifyListeners();
  }

  //User User Address Getter Setter
  String get userAddress => _userAddress;
  set userAddress(String data){

    if(data == ''){
        _userAddress = userData?.address ??(userAddressByLoc?.name ?? 'Frankfurt');
    }else{
      _userAddress = data;
    }
    notifyListeners();
  }

}
