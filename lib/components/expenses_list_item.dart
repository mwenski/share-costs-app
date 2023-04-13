import 'package:flutter/material.dart';

import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/services/db_operations.dart';

class ExpensesListItem extends StatelessWidget {
  const ExpensesListItem(
      {super.key,
      required this.expense});

  final Expense expense;

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
                expense.name,
                style: const TextStyle(fontSize: 32, color: Colors.blue),
              ),
              const Spacer(),
              Text(
                expense.amount.toString(),
                style: const TextStyle(fontSize: 32, color: Colors.blue),
              )
            ],
          ),
          Row(
            children: [
              Text(expense.ownerId,
                  style: const TextStyle(fontSize: 20, color: Colors.grey)),
              const Spacer(),
              Text(expense.date.toString(),
                  style: const TextStyle(fontSize: 20, color: Colors.grey))
            ],
          ),
          Row(children: [
            TextButton(onPressed: ()=>{DbOperations.removeExpense(expense.id)}, child: const Text("Remove expense"))
          ],)
        ],
      ),
    );
  }
}
