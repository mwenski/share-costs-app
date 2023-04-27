import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:share_cost_app/routes.dart';
import 'package:share_cost_app/style.dart';
import 'package:share_cost_app/constant.dart';
import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/models/user_model.dart';
import 'package:share_cost_app/services/db_operations.dart';
import 'package:share_cost_app/components/widgets/widgets.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem(
      {super.key, required this.expense, required this.members});

  final Expense expense;
  final List<User> members;

  @override
  Widget build(BuildContext context) {
    void removeExpense() async {
      var res = await DbOperations.removeExpense(expense.id);
      Widgets.scaffoldMessenger(context, res, "Expense deleted!");
    }

    User? paidBy =
        members.firstWhere((element) => element.id == expense.paidBy, orElse: () => User(name: "N.N."));
    User? paidFor =
        members.firstWhere((element) => element.id == expense.paidFor, orElse: () => User(name: "N.N."));

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
                expense.amount.toStringAsFixed(2).replaceAll(".", ","),
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
                  onPressed: () async {
                    var response = await Widgets.alertDialog(
                        context,
                        "Expense removing",
                        "Are you sure you want to remove this expense?");
                    if (response == true) {
                      removeExpense();
                    }
                  },
                  icon: Icon(Icons.delete),
                  tooltip: "Remove expense",
                  color: Colors.blue,
                  iconSize: 20),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.expenseForm, arguments: {
                      "expense": expense,
                      "members": members,
                      "formType": FormType.update
                    });
                  },
                  icon: Icon(Icons.edit),
                  tooltip: "Update expense",
                  color: Colors.blue,
                  iconSize: 20),
              const Spacer(),
              Text(DateFormat("HH:mm  dd/MM/yyyy").format(expense.date),
                  style: Style.dateStyle)
            ],
          )
        ],
      ),
    );
  }
}
