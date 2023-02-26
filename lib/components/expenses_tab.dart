import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:share_cost_app/components/expenses_list_item.dart';

class ExpensesTab extends StatefulWidget {
  const ExpensesTab({Key? key}) : super(key: key);

  @override
  State<ExpensesTab> createState() => _ExpensesTabState();
}

class _ExpensesTabState extends State<ExpensesTab> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _expensesStream = FirebaseFirestore.instance
        .collection('expenses')
        .orderBy('date', descending: false)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _expensesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return ExpensesListItem(name: data['name'], amount: data['amount'], date: data['date'].toDate().toString(), addedBy: data['added_by']);
        }).toList(),);
      },
    );
  }
}
