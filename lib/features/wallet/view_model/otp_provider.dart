import 'package:flutter/material.dart';

class OtpProvider  extends ChangeNotifier{
  String _otp = "";

  String get otp => _otp;

  void updateOTP(String digit){
    if(_otp.length < 6){
      _otp += digit;
      notifyListeners();
    }
  }

  void removeLastDigit(){
    if(_otp.isNotEmpty){
      _otp = _otp.substring(0, _otp.length - 1);
      notifyListeners();
    }
  }

  void clearOTP(){
    _otp = "";
    notifyListeners();
  }
}