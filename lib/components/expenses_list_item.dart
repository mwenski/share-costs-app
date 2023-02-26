import 'package:flutter/material.dart';

class ExpensesListItem extends StatelessWidget {
  const ExpensesListItem(
      {super.key,
      required this.name,
      required this.amount,
      required this.date,
      required this.addedBy});

  final String name;
  final double amount;
  final String date;
  final String addedBy;

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
                name,
                style: const TextStyle(fontSize: 32, color: Colors.blue),
              ),
              const Spacer(),
              Text(
                amount.toString(),
                style: const TextStyle(fontSize: 32, color: Colors.blue),
              )
            ],
          ),
          Row(
            children: [
              Text(addedBy,
                  style: const TextStyle(fontSize: 20, color: Colors.grey)),
              const Spacer(),
              Text(date,
                  style: const TextStyle(fontSize: 20, color: Colors.grey))
            ],
          )
        ],
      ),
    );
  }
}
