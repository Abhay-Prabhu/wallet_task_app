import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:match_maker/main.dart';

import '../app_theme.dart';



class CustomToast {
  static void showToast({required String message, required bool isError, int seconds = 10, required BuildContext context}) {
    Fluttertoast.cancel(); 

    FToast fToast = FToast();
//     fToast.init(navigatorKey.currentContext!); 
// fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: isError ? AppTheme.error : AppTheme.grey,
      ),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: seconds),
    );
  }
}
