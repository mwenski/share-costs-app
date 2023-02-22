import 'package:flutter/material.dart';

import 'package:share_cost_app/routes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewExpenseView extends StatefulWidget {
  const NewExpenseView({Key? key}) : super(key: key);

  @override
  State<NewExpenseView> createState() => _NewExpenseViewState();
}

class _NewExpenseViewState extends State<NewExpenseView> {
  String _name = "";
  double _amount = 0.0;

  @override
  Widget build(BuildContext context) {

    CollectionReference expense = FirebaseFirestore.instance.collection('expenses');
    Future<void> addExpense(){
      return expense
          .add({
        'name': _name,
        'amount': _amount,
        'date' : DateTime.now(),
        'added_by' : 'user'
      })
          .then((value) => print("Expense Added"))
          .catchError((error) => print("Failed to add expense: $error"));
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Share Cost App - Add new expense")),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SingleChildScrollView(
              child: Column(children: [
                TextField(
                  onSubmitted: (value) {_name = value;},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  onSubmitted: (value) {_amount = double.parse(value);},
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      addExpense();
                      Navigator.pushNamed(context, Routes.home);
                    },
                    child: const Text('Add expense', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}

