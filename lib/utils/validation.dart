import 'package:flutter/material.dart';

class Validation{
  static bool verifyEmail(String data){
    var regex = RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');
    return regex.hasMatch(data);
  }

  static bool verifyPassword(String data){
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$');
    return regex.hasMatch(data);
  }

  static errorSnackbar(BuildContext context, String errorString){
    final snackbar = SnackBar(content: Text(errorString));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static createLoading(BuildContext context){
    showDialog(context: context, builder: (ctx) {
      return const AlertDialog(

      );
    });
  }
}