import 'package:flutter/material.dart';

import 'package:share_cost_app/style.dart';
import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/models/user_model.dart';
import 'package:share_cost_app/services/db_operations.dart';

class ExpensesListItem extends StatelessWidget {
  const ExpensesListItem(
      {super.key, required this.expense, required this.members});

  final Expense expense;
  final List<User> members;

  @override
  Widget build(BuildContext context) {
    void removeExpense() {
      DbOperations.removeExpense(expense.id);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Expense deleted!"),
        backgroundColor: Colors.green,
      ));
    }

    User? paidBy =
        members.firstWhere((element) => element.id == expense.paidBy);
    User? paidFor =
        members.firstWhere((element) => element.id == expense.paidFor);

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
                style: Style.headerStyle,
              ),
              const Spacer(),
              Text(
                expense.amount.toString(),
                style: Style.headerStyle,
              )
            ],
          ),
          Row(
            children: [
              Text("By: ${paidBy.name}", style: Style.subheaderStyle),
              const Spacer(),
              Text("For: ${paidFor.name}", style: Style.subheaderStyle)
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: removeExpense,
                icon: Icon(Icons.delete),
                tooltip: "Remove expense",
                color: Colors.blue,
                iconSize: 20
              ),
              const Spacer(),
              Text(expense.date.toString(), style: Style.dateStyle)
            ],
          )
        ],
      ),
    );
  }
}
