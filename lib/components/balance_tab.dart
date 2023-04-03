import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/components/balance_list_item.dart';

class BalanceTab extends StatefulWidget {
  const BalanceTab({Key? key, required this.groupId}) : super(key: key);

  final String groupId;

  @override
  State<BalanceTab> createState() => _BalanceTabState();
}

class _BalanceTabState extends State<BalanceTab> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> balanceStream = FirebaseFirestore.instance
        .collection('expenses')
        .where('groupId', isEqualTo: widget.groupId)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: balanceStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List <String> paidFor = <String>[];
        List <String> paidBy = <String>[];

        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            Expense expense = Expense.fromJson(data);

            if(paidBy.contains(expense.paidBy) == false){paidBy.add(expense.paidBy);}
            if(paidFor.contains(expense.paidFor) == false){paidFor.add(expense.paidFor);}

            print(paidFor + <String>[" "] + paidBy);

            return BalanceListItem(
                sender: "user1", recipient: "user2", amount: "1.0");
          }).toList(),
        );
      },
    );
  }
}
