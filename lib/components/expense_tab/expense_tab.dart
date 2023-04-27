import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:share_cost_app/style.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/services/db_operations.dart';
import 'package:share_cost_app/components/expense_tab/expense_list_item.dart';
import 'package:share_cost_app/models/expense_model.dart';

class ExpenseTab extends StatefulWidget {
  const ExpenseTab({Key? key, required this.group}) : super(key: key);

  final Group group;

  @override
  State<ExpenseTab> createState() => _ExpenseTabState();
}

class _ExpenseTabState extends State<ExpenseTab> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> expensesStream =
        DbOperations.getExpensesStream(widget.group.id);

    return StreamBuilder<QuerySnapshot>(
      stream: expensesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
              child: Text(
            'Something went wrong',
            style: Style.errorStyle,
          ));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: Text(
            "Loading...",
            style: Style.loadingStyle,
          ));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            Expense expense = Expense.fromJson(data);
            return ExpenseListItem(
                expense: expense, members: widget.group.members);
          }).toList(),
        );
      },
    );
  }
}
