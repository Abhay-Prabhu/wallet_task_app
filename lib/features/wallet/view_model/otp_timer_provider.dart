import 'dart:async';
import 'package:flutter/material.dart';

class OTPTimerProvider extends ChangeNotifier {
  String _otp = "";
  Timer? _timer;
  int _start = 30;
  bool get isTimerActive => _timer != null && _timer!.isActive;

  String get otp => _otp;
  int get start => _start;
  
  void startTimer() {
    print("**** print from start timer");
    _timer?.cancel(); 
  _start = 30; 
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          _timer = null;
          notifyListeners();
        } else {
          _start--;
          notifyListeners();
        }
      },
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void resendOTP() {
    _start = 30;
    startTimer();
    notifyListeners();
    print('Resend OTP API call...');
  }
}
