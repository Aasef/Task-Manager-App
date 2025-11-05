import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:task_manager/screen/loginScreen.dart';
import 'package:task_manager/taskManagerApp.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';

class ApiCaller {
  static final Logger _logger = Logger();

  static Future<ApiResponse> getResponse({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);
      Response response = await get(uri, headers: {
        'token':AuthController.accessToken ?? ''
      });
      _logResponse(url, response);
      int statusCode = response.statusCode;
      if (response.statusCode == 200) {
        //SUCCESS
        final decodedJson = jsonDecode(response.body);
        return ApiResponse(
            isSucess: true, successCode: statusCode, responseData: decodedJson);
      } else if(response.statusCode==401){
        await _moveToLoginScreen();
        return ApiResponse(
            isSucess: false,
            successCode: statusCode,
            responseData: null,
            errorMessage: "Un-Authorised");
      } else {
        //FAILED
        final decodedJson = jsonDecode(response.body);
        return ApiResponse(
            isSucess: false,
            successCode: statusCode,
            responseData: decodedJson,
            errorMessage: "Something went wrong");
      }
    } on Exception catch (e) {
      // TODO

      return ApiResponse(
          isSucess: false,
          successCode: -1,
          responseData: null,
          errorMessage: e.toString());
    }
  }

  static Future<ApiResponse> postResponse(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, body: body);
      Response response = await post(uri,
          headers: {
            'Content-Type': 'application/json',
            'token': AuthController.accessToken ?? ''
          },
          body: jsonEncode(body));
      _logResponse(url, response);
      int statusCode = response.statusCode;
      if (response.statusCode == 200 || statusCode == 201) {
        //SUCCESS
        final decodedJson = jsonDecode(response.body);
        return ApiResponse(
            isSucess: true, successCode: statusCode, responseData: decodedJson);
      } else {
        //FAILED
        final decodedJson = jsonDecode(response.body);
        return ApiResponse(
            isSucess: false,
            successCode: statusCode,
            responseData: decodedJson,
            errorMessage: "Something went wrong");
      }
    } on Exception catch (e) {
      // TODO

      return ApiResponse(
          isSucess: false,
          successCode: -1,
          responseData: null,
          errorMessage: e.toString());
    }
  }

  static void _logRequest(String url, {Map<String, dynamic>? body}) {
    _logger.i('URL => $url\n'
        'Request Body:$body');
  }

  static void _logResponse(String url, Response response) {
    _logger.i('URL => $url\n'
        'StatusCode:${response.statusCode}\n'
        'Body:${response.body}\n');
  }
  static Future<void> _moveToLoginScreen()async{
    await AuthController.clearData();
    Navigator.pushAndRemoveUntil(TaskManagerApp.navigator.currentState! as BuildContext , MaterialPageRoute(builder: (context) => LoginScreen() ,), (predicate)=>false);
  }
}

class ApiResponse {
  final bool isSucess;
  final int successCode;
  final dynamic responseData;
  final String? errorMessage;

  ApiResponse(
      {required this.isSucess,
      required this.successCode,
      required this.responseData,
      this.errorMessage});
}
