import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpensesListItem extends StatelessWidget {
  const ExpensesListItem(
      {super.key,
      required this.id,
      required this.name,
      required this.amount,
      required this.date,
      required this.ownerId});

  final String id;
  final String name;
  final double amount;
  final String date;
  final String ownerId;

  @override
  Widget build(BuildContext context) {

    void removeExpense(){
      FirebaseFirestore.instance
          .collection("expenses")
          .doc(id)
          .delete()
          .then((_) {print("Expense Removed");});
    }

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
              Text(ownerId,
                  style: const TextStyle(fontSize: 20, color: Colors.grey)),
              const Spacer(),
              Text(date,
                  style: const TextStyle(fontSize: 20, color: Colors.grey))
            ],
          ),
          Row(children: [
            TextButton(onPressed: removeExpense, child: const Text("Remove expense"))
          ],)
        ],
      ),
    );
  }
}
