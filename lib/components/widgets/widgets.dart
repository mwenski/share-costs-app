import 'package:flutter/material.dart';

abstract class Widgets {

  static void scaffoldMessenger(BuildContext context, String? result, String ifCorrect){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: result == null ? Colors.green : Colors.red,
            content: Text(result ?? ifCorrect)));
  }

  static showAlertDialog(BuildContext context, String alertTitle,
      String alertQuestion, Function() functionWhenAgreed) {

    Widget yesButton = TextButton(
        onPressed: () {
          functionWhenAgreed;
          Navigator.of(context).pop();
        },
        child: Text("Yes"));
    Widget noButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("No"));

    AlertDialog alertDialog = AlertDialog(
      title: Text(alertTitle),
      content: Text(alertQuestion),
      actions: [noButton, yesButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
