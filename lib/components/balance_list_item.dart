import 'package:flutter/material.dart';

class BalanceListItem extends StatelessWidget {
  const BalanceListItem(
      {super.key,
      required this.sender,
      required this.recipient,
      required this.amount});

  final String sender;
  final String recipient;
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
              Text(
                sender,
                style: const TextStyle(fontSize: 32, color: Colors.blue),
              ),
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
              Text(recipient,
                  style: const TextStyle(fontSize: 32, color: Colors.blue)),
            ],
          )
        ],
      ),
    );
  }
}
