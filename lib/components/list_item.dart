import 'package:flutter/material.dart';

class ListElement extends StatelessWidget {
  //const ListElement({Key? key}) : super(key: key);
  const ListElement({super.key, required this.thing, required this.amount, required this.user});

  final String thing;
  final String amount;
  final String user;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                thing,
                style: TextStyle(fontSize: 32, color: Colors.blue),
              ),
              Spacer(),
              Text(
//amount as String
                amount,
                style: TextStyle(fontSize: 32, color: Colors.blue),
              )
            ],
          ),
          Row(
            children: [
              Text(user, style: TextStyle(fontSize: 20, color: Colors.grey)),
              Spacer(),
              Text("DD.MM.YYYY",
                  style: TextStyle(fontSize: 20, color: Colors.grey))
            ],
          )
        ],
      ),
    );
    ;
  }
}

/*
StatelessWidget listelement = Container(
  child: Column(
    children: [
      Row(
        children: const [
          Text(
            "thing",
            style: TextStyle(fontSize: 32, color: Colors.blue),
          ),
          Spacer(),
          Text(
//amount as String
            "0.0",
            style: TextStyle(fontSize: 32, color: Colors.blue),
          )
        ],
      ),
      Row(
        children: const [
          Text("user", style: TextStyle(fontSize: 20, color: Colors.grey)),
          Spacer(),
          Text("DD.MM.YYYY",
              style: TextStyle(fontSize: 20, color: Colors.grey))
        ],
      )
    ],
  ),
);
*/
