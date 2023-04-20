import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

import 'package:share_cost_app/models/user_model.dart';

class BalanceListItem extends StatelessWidget {
  const BalanceListItem(
      {super.key,
      required this.balanceElement,
      required this.members});

  final Map<String, dynamic> balanceElement;
  final List<User> members;

  @override
  Widget build(BuildContext context) {
    String getName(String id){
      User? named = members.firstWhere((element) => element.id == id);
      return named.name;
    }

    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: TextScroll(getName(balanceElement["paidFor"]),
                style: const TextStyle(fontSize: 32, color: Colors.blue),
                intervalSpaces: 10,
                velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                pauseBetween: Duration(seconds: 1),
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("should send to",
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              const Spacer(),
              Text(
                balanceElement["amount"].toString(),
                style: const TextStyle(fontSize: 32, color: Colors.blue),
              )
            ],
          ),
          Row(
            children: [
              Flexible(
                child: TextScroll(getName(balanceElement["paidBy"]),
                  style: const TextStyle(fontSize: 32, color: Colors.blue),
                  intervalSpaces: 10,
                  velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                  pauseBetween: Duration(seconds: 1),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
