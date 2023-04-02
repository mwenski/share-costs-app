import 'package:flutter/material.dart';

import 'package:share_cost_app/routes.dart';
import 'package:share_cost_app/models/expense_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({Key? key}) : super(key: key);

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final groupId = ModalRoute.of(context)!.settings.arguments as String;

    CollectionReference expenseCollection =
        FirebaseFirestore.instance.collection('expenses');
    void addExpense() {
      Expense expense = Expense(name: nameController.text, ownerId: "ownerId", groupId: groupId, amount: double.parse(amountController.text));

      expenseCollection
          .add(expense.toJson())
          .then((value) => print("Expense Added"))
          .catchError((error) => print("Failed to add expense: $error"));
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Add new expense")),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SingleChildScrollView(
              child: Column(children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: amountController,
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
                      Navigator.pushNamed(context, Routes.home, arguments: groupId);
                    },
                    child: const Text('Add expense',
                        style: TextStyle(fontSize: 18)),
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}
