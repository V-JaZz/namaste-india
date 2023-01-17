// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, prefer_adjacent_string_concatenation, unnecessary_string_interpolations, await_only_futures, unnecessary_brace_in_string_interps, prefer_const_constructors, dead_code

import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'app_exception.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiBaseHelper {
  static const String baseURL =
      "https://test-foodinventoryde.herokuapp.com/v1/";
      // "https://demo-foodinventoryde.herokuapp.com/v1/";
  // "https://foodinventoryde-demo.herokuapp.com/v1/";


  static const String login = "ownerService/login";
  static const String register = "userService/registerUser";
  static const String logout = "ownerService/logout";
  static const String home = "menuService/homeMenu";
  static const String sendOTP = "userService/sendOTP";
  static const String verifyOTP = "userService/verifyOTP";
  static const String restaurantProfile = "restaurantService/profile";
  static String status = 'status';
  static bool autoAccept = true;
  static bool autoPrint = true;
  static bool print50mm = true;
  static bool? autoTablePrint = true;
  static int printCount = 1;

  // static bool? allowOnlineDelivery = false;
  // static bool? allowOnlinePickup = false;
  // static bool? isReservationActive = false;
  static int pending = 0;

  Future<dynamic> get(String url, String token) async {
    print('Api Post, url $url');
    print('Api PUT, Token $token');
    var response;
    try {
      Map<String, String> header;
      if (token.isEmpty) {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
      } else {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        };
      }

      response = await http.get(Uri.parse(baseURL + url), headers: header);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return response;
  }

  Future<dynamic> getwith(String url) async {
    print('Api Post, url $url');

    var response;
    try {
      Map<String, String> header;

      header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };


      response = await http.get(Uri.parse(baseURL + url), headers: header);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return response;
  }
 /* Future<dynamic> getwith(String url, String token, String restaurantid) async {
    print('Api Post, url $url');
    print('Api PUT, Token $token');
    var response;
    try {
      Map<String, String> header;
      if (token.isEmpty) {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
      } else {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "Bearer " + '$token',
          'restaurant': '$restaurantid'
        };
      }

      response = await http.get(Uri.parse(baseURL + url), headers: header);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return response;
  }*/

  Future<dynamic> post(String url, dynamic body, String token) async {
    print('Api Post, url $url');
    print('Api POST, Token $token');
    print('Api Post, body : $body');
    var response;
    try {
      Map<String, String> header;
      if (token.isEmpty) {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
      } else {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        };
      }

      response = await http.post(Uri.parse(baseURL + url),
          body: body, headers: header);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return response;
  }

  Future<dynamic> postwithid(
      String url, dynamic body, String token, String restorantid) async {
    print('Api Post, url $url');
    print('Api POST, Token $token');
    print('Api Post, body : $body');
    var response;
    try {
      Map<String, String> header;
      if (token.isEmpty) {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
      } else {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'restaurantId': '$restorantid'
        };
      }

      response = await http.post(Uri.parse(baseURL + url),
          body: body, headers: header);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return response;
  }

  Future<dynamic> put(
      String url, dynamic body, String token, String restorantid) async {
    print('Api PUT, url $url');
    print('Api PUT, Token $token');
    print('Api Post, body : $body');
    var response;
    try {
      Map<String, String> header;
      if (token.isEmpty) {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
      } else {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'restaurantId': '$restorantid'
        };
      }

      response =
          await http.put(Uri.parse(baseURL + url), body: body, headers: header);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api PUT.');
    return response;
  }

  Future<dynamic> putwith(String url, dynamic body, String token) async {
    print('Api PUT, url $url');
    print('Api PUT, Token $token');
    print('Api Post, body : $body');
    var response;
    try {
      Map<String, String> header;
      if (token.isEmpty) {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
      } else {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        };
      }

      response =
          await http.put(Uri.parse(baseURL + url), body: body, headers: header);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api PUT.');
    return response;
  }

  // For restaurant image Cover and Logo
  Future<dynamic> putMultiPart(String url, File pickedImage, String fileName,
      String fileType, String imageType, String token) async {
    print('Api PUT, url $url');
    print('Api PUT, FilePath ${pickedImage.path.split(".").last}');
    print('Api PUT, Token $token');
    print('Api PUT, ImageType $imageType');
    var respStr;
    try {
      var request = http.MultipartRequest(
          "PUT",
          Uri.parse(baseURL +
              url)); //Ye kyu kia POST kisne bola ?phle se ase hai nhi bhai suresh wala hai jo
      if (token.isNotEmpty) {}
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      request.fields['option'] = imageType;
      request.fields['pratyush'] = 'this is image test';
      request.files.add(await http.MultipartFile.fromPath(
          'file', pickedImage.path,
          filename: fileName, contentType: MediaType('image', fileType)));

      var response = await request.send();
      respStr = await response.stream.bytesToString();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api PUT.');
    return respStr;
  }

  Future<dynamic> postMultiPartCategorywithoutimage(String url, String name,
      String description, String discount, String token) async {
    print('Api PUT, url $url');
    print('Api PUT, Token $token');
    print('Api PUT, ImageType $name');
    var respStr;
    try {
      var request = http.MultipartRequest("POST", Uri.parse(baseURL + url));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['name'] = name;
      request.fields['description'] = description;
      request.fields['discount'] = discount;
      // request.files.add(await http.MultipartFile.fromPath(
      //     'file', pickedImage.path,
      //     filename: fileName, contentType: new MediaType('image', fileType)));
      var response = await request.send();
      respStr = await await http.Response.fromStream(response);
    } on SocketException {
      print('No net');
      // print(respStr);
      throw FetchDataException('No Internet connection');
    }
    print('api PUT.');
    return respStr;
  }

//this is for category image upload
  Future<dynamic> postMultiPartCategory(
      String url,
      File pickedImage,
      String fileName,
      String fileType,
      String name,
      String description,
      String discount,
      String token) async {
    print('Api PUT, url $url');
    print('Api PUT, FilePath ${pickedImage}');
    print('Api PUT, Token $token');
    print('Api PUT, ImageType $name');
    var respStr;
    try {
      var request = http.MultipartRequest("POST", Uri.parse(baseURL + url));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['name'] = name;
      request.fields['description'] = description;
      request.fields['discount'] = discount;
      request.files.add(await http.MultipartFile.fromPath(
          'file', pickedImage.path,
          filename: fileName, contentType: MediaType('image', fileType)));
      var response = await request.send();
      respStr = await await http.Response.fromStream(response);
    } on SocketException {
      print('No net');
      // print(respStr);
      throw FetchDataException('No Internet connection');
    }
    print('api PUT.');
    return respStr;
  }

  Future<dynamic> postMultiPartItems(
      String url,
      File pickedImage,
      String fileName,
      String fileType,
      String name,
      String category,
      String description,
      String discount,
      String price,
      variants,
      options,
      allergyGroup,
      String token,
      String menuType) async {
    print('Api PUT, url $url');
    print('Api PUT, FilePath ${pickedImage}');
    print('Api PUT, Token $token');
    print('Api PUT,' + variants.toString());
    print("Api VARI: " + variants.toString());
    print("API OPT: " + options.toString());
    var respStr;
    try {
      var request = http.MultipartRequest("POST", Uri.parse(baseURL + url));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['name'] = name;
      request.fields['menuType'] = menuType;

      request.fields['category'] = category;
      request.fields['description'] = description;
      request.fields['discount'] = discount;
      request.fields['price'] = price;
      request.fields['variants'] = '$variants';
      request.fields['options'] = '$options';
      request.fields['allergyGroup'] = allergyGroup;
      request.files.add(await http.MultipartFile.fromPath(
          'file', pickedImage.path,
          filename: fileName, contentType: MediaType('image', fileType)));
      var response = await request.send();
      respStr = await await http.Response.fromStream(response);
    } on SocketException {
      print('No net');
      // print(respStr);
      throw FetchDataException('No Internet connection');
    }
    print('api PUT.');
    return respStr;
  }

  Future<dynamic> postMultiPartItemswithoutImage(
      String url,
      String menuType,
      // String fileType,
      String name,
      String category,
      String description,
      String discount,
      String price,
      var variants,
      var options,
      allergyGroup,
      String token) async {
    print('Api PUT, url $url');
    print('Api PUT, Token $token');
    print('Api PUT, ImageType $name');
    print('Api PUT, varient $price');
    print("Api VARI: " + variants.toString());
    print("API OPT: " + options.toString());

    var respStr;
    try {
      var request = http.MultipartRequest("POST", Uri.parse(baseURL + url));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['name'] = name;
      request.fields['menuType'] = menuType;

      request.fields['category'] = category;
      request.fields['description'] = description;
      request.fields['discount'] = discount;
      request.fields['price'] = price;
      request.fields['variants'] = '$variants';
      request.fields['options'] = '$options';
      request.fields['allergyGroup'] = allergyGroup;

      // request.files.add(await http.MultipartFile.fromPath(
      //     'file', pickedImage.path,
      //     filename: fileName, contentType: new MediaType('image', fileType)));
      var response = await request.send();
      respStr = await await http.Response.fromStream(response);
    } on SocketException {
      print('No net');
      // print(respStr);
      throw FetchDataException('No Internet connection');
    }
    print('api PUT.');
    return respStr;
  }

//this is for category image upload
  Future<dynamic> putMultiPartCategory(
      String url,
      File pickedImage,
      String fileName,
      String fileType,
      String name,
      String description,
      String discount,
      String token) async {
    print('Api PUT, url $url');
    print('Api PUT, FilePath ${pickedImage}');
    print('Api PUT, Token $token');
    print('Api PUT, ImageType $name');

    var respStr;
    try {
      var request = http.MultipartRequest("PUT", Uri.parse(baseURL + url));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['name'] = name;
      request.fields['description'] = description;
      request.fields['discount'] = discount;
      request.fields["imageType"] = "category";
      request.files.add(await http.MultipartFile.fromPath(
          'file', pickedImage.path,
          filename: fileName, contentType: MediaType('image', fileType)));
      var response = await request.send();
      respStr = await await http.Response.fromStream(response);
    } on SocketException {
      print('No net');
      // print(respStr);
      throw FetchDataException('No Internet connection');
    }
    print('api PUT.');
    return respStr;
  }

//without Image
  Future<dynamic> putMultiPartCategorywithoutImage(String url, String name,
      String description, String discount, String token) async {
    print('Api PUT, url $url');

    print('Api PUT, Token $token');
    print('Api PUT, ImageType $name');
    var respStr;
    try {
      var request = http.MultipartRequest("PUT", Uri.parse(baseURL + url));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['name'] = name;
      request.fields['description'] = description;
      request.fields['discount'] = discount;
      request.fields["imageType"] = "category";

      var response = await request.send();
      respStr = await await http.Response.fromStream(response);
    } on SocketException {
      print('No net');
      // print(respStr);
      throw FetchDataException('No Internet connection');
    }
    print('api PUT.');
    return respStr;
  }

//this is for category image upload
  Future<dynamic> putMultiPartItem(
      String url,
      File pickedImage,
      String fileName,
      String fileType,
      String name,
      String category,
      String description,
      String discount,
      String price,
      variants,
      options,
      String allergyGroup,
      String token,
      restorantid,
      String menuType) async {
    print('Api PUT, url $url');
    print('Api PUT, FilePath ${pickedImage}');
    print('Api PUT, Token $token');
    print('Api PUT, ImageType $name');
    var respStr;
    try {
      var request = http.MultipartRequest("PUT", Uri.parse(baseURL + url));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['restaurantId'] = '$restorantid';
      request.fields['name'] = name;
      request.fields['menuType'] = menuType;

      request.fields['description'] = description;
      request.fields['discount'] = discount;
      request.fields['category'] = category;
      request.fields['price'] = price;
      request.fields['variants'] = '$variants';
      request.fields['options'] = '$options';
      request.fields['allergyGroup'] = allergyGroup;
      request.fields["imageType"] = "item";
      request.files.add(await http.MultipartFile.fromPath(
          'file', pickedImage.path,
          filename: fileName, contentType: MediaType('image', fileType)));
      var response = await request.send();
      respStr = await await http.Response.fromStream(response);
    } on SocketException {
      print('No net');
      // print(respStr);
      throw FetchDataException('No Internet connection');
    }
    print('api PUT.');
    return respStr;
  }

//without Image
  Future<dynamic> putMultiPartItemwithoutImage(
      String url,
      String name,
      String category,
      String description,
      String discount,
      String price,
      variants,
      options,
      String allergyGroup,
      String token,
      restorantid,
      String menuType) async {
    print('Api PUT, url $url');

    print('Api PUT, Token $token');
    print('Api PUT, ImageType $name');
    var respStr;
    try {
      var request = http.MultipartRequest("PUT", Uri.parse(baseURL + url));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['restaurantId'] = '$restorantid';
      request.fields['name'] = name;
      request.fields['menuType'] = menuType;

      request.fields['description'] = description;
      request.fields['discount'] = discount;
      request.fields['category'] = category;
      request.fields['price'] = price;
      request.fields['variants'] = '$variants';
      request.fields['options'] = '$options';
      request.fields['allergyGroup'] = allergyGroup;
      request.fields["imageType"] = "item";

      var response = await request.send();
      respStr = await await http.Response.fromStream(response);
    } on SocketException {
      print('No net');
      // print(respStr);
      throw FetchDataException('No Internet connection');
    }
    print('api PUT.');
    return respStr;
  }

  Future<dynamic> delete(String url, String token) async {
    print('Api delete, url $url');
    print('Api delete, Token $token');
    var response;
    try {
      Map<String, String> header;
      if (token.isEmpty) {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
      } else {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        };
      }

      response = await http.delete(Uri.parse(baseURL + url), headers: header);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return response;
  }

  dynamic returnResponse(BuildContext context, http.Response response) {
   // print(response.statusCode.toString());
   // print(response.body.toString());
    var responseJson = json.decode(response.body.toString());
    switch (response.statusCode) {
      case 101:
      case 200:
      case 401:
      case 404:
      case 422:
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Something wants wrong!"),
        ));
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
