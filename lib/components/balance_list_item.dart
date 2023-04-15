import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

class BalanceListItem extends StatelessWidget {
  const BalanceListItem(
      {super.key,
      required this.paidFor,
      required this.paidBy,
      required this.amount});

  final String paidFor;
  final String paidBy;
  final String amount;

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
              Flexible(
                child: TextScroll(paidFor,
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
                amount,
                style: const TextStyle(fontSize: 32, color: Colors.blue),
              )
            ],
          ),
          Row(
            children: [
              Flexible(
                child: TextScroll(paidBy,
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
