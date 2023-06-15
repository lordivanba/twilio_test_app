import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twilio/widgets/loading_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeProvider extends ChangeNotifier {
  String _phoneNumber = "";
  String _code = "";

  String get phoneNumber => _phoneNumber;
  String get code => _code;

  set setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  set setCode(String code) {
    _code = code;
    notifyListeners();
  }

  Future sendCode(BuildContext context) async {
    LoadingDialog.showLoadingDialog(context, 'Loading...');
    final response = await http.post(
      Uri.parse('http://192.168.0.4:3000/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': _phoneNumber,
      }),
    );
    LoadingDialog.hideLoadingDialog(context);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Code sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setPhoneNumber = "";
      Fluttertoast.showToast(
          msg: "Error, try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future verifyCode(BuildContext context) async {
    LoadingDialog.showLoadingDialog(context, 'Loading...');

    final response = await http.post(
      Uri.parse('http://192.168.0.4:3000/verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': _phoneNumber,
        'code': _code,
      }),
    );
    LoadingDialog.hideLoadingDialog(context);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Code approved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setCode = "";
      Fluttertoast.showToast(
          msg: "Wrong code, try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
