import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_cost_app/models/group_model.dart';

import 'package:share_cost_app/services/db_operations.dart';
import 'package:share_cost_app/components/expenses_list_item.dart';
import 'package:share_cost_app/models/expense_model.dart';

class ExpensesTab extends StatefulWidget {
  const ExpensesTab({Key? key, required this.group}) : super(key: key);

  final Group group;

  @override
  State<ExpensesTab> createState() => _ExpensesTabState();
}

class _ExpensesTabState extends State<ExpensesTab> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> expensesStream = DbOperations.getExpensesStream(widget.group.id);

    return StreamBuilder<QuerySnapshot>(
      stream: expensesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            Expense expense = Expense.fromJson(data);
            return ExpensesListItem(expense: expense);
          }).toList(),
        );
      },
    );
  }
}
