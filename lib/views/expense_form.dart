import 'package:flutter/material.dart';

import 'package:share_cost_app/routes.dart';
import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/models/user_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_cost_app/services/db_operations.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({Key? key}) : super(key: key);

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final paidByController = TextEditingController();
  final paidForController = TextEditingController();
  String paidByValue = "";
  String paidForValue = "";

  @override
  Widget build(BuildContext context) {
    final groupId = ModalRoute.of(context)!.settings.arguments as String;

    Future<void> getUsers(String id) async {
      await DbOperations.getUsers(id);
      print("Test${DbOperations.members}");
    }

    setState(() {
      getUsers(groupId);
      paidByValue = DbOperations.members[0].id;
      paidForValue = DbOperations.members[1].id;
    });


    CollectionReference expenseCollection =
        FirebaseFirestore.instance.collection('expenses');
    void addExpense() {
      Expense expense = Expense(
          name: nameController.text,
          ownerId: "ownerId",
          groupId: groupId,
          amount: double.parse(amountController.text),
          paidBy: paidByValue,
          paidFor: paidForValue);

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
                // TextField(
                //   controller: paidByController,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //     labelText: 'Paid by...',
                //   ),
                // ),
                DropdownButtonFormField(
                  hint: const Text('Paid by...'),
                  value: paidByValue,
                  items: DbOperations.members == null
                      ? []
                      : DbOperations.members.map((member) {
                          return DropdownMenuItem<String>(
                            value: member.id,
                            child: Text(member.name),
                          );
                        }).toList(),
                  onChanged: (value) => paidByValue = value as String,
                ),
                const SizedBox(
                  height: 10,
                ),
                //DropdownButton(items: , onChanged: null),
                // TextField(
                //   controller: paidForController,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //     labelText: 'Paid for...',
                //   ),
                // ),
                DropdownButtonFormField(
                  hint: const Text('Paid for...'),
                  value: paidForValue,
                  items: DbOperations.members == null
                      ? []
                      : DbOperations.members.map((member) {
                    return DropdownMenuItem<String>(
                      value: member.id,
                      child: Text(member.name),
                    );
                  }).toList(),
                  onChanged: (value) => paidForValue = value as String,
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
                      Navigator.pop(context);
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
