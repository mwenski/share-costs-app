import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {super.key,
      required this.thing,
      required this.amount,
      required this.user});

  final String thing;
  final String amount;
  final String user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                thing,
                style: const TextStyle(fontSize: 32, color: Colors.blue),
              ),
              const Spacer(),
              Text(
//amount as String
                amount,
                style: const TextStyle(fontSize: 32, color: Colors.blue),
              )
            ],
          ),
          Row(
            children: [
              Text(user, style: const TextStyle(fontSize: 20, color: Colors.grey)),
              const Spacer(),
              const Text("DD.MM.YYYY",
                  style: TextStyle(fontSize: 20, color: Colors.grey))
            ],
          )
        ],
      ),
    );
  }
}
