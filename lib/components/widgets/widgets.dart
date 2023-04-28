import 'package:flutter/material.dart';

abstract class Widgets {
  static void scaffoldMessenger(
      BuildContext context, String? ifNotCorrect, String ifCorrect) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: ifNotCorrect == null ? Colors.green : Colors.red,
        content: Text(ifNotCorrect ?? ifCorrect)));
  }

  static Future<bool?> alertDialog(BuildContext context, String alertTitle,
      String alertQuestion) async {
    return await showDialog<bool?>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(alertTitle),
            content: Text(alertQuestion),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("No")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Yes")),
            ],
          );
        });
  }
}
