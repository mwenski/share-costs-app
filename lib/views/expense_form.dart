import 'package:flutter/material.dart';

import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/services/db_operations.dart';
import 'package:share_cost_app/services/authentication.dart';
import 'package:share_cost_app/components/side_menu/side_menu.dart';

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
    final group = ModalRoute.of(context)!.settings.arguments as Group;

    setState(() {
      paidByValue = group.members[0].id;
      paidForValue = group.members[1].id;
    });

    void addExpense() {
      Expense expense = Expense(
          name: nameController.text,
          ownerId: Authentication.getCurrentUser()?.uid as String,
          groupId: group.id,
          amount: double.parse(amountController.text),
          paidBy: paidByValue,
          paidFor: paidForValue);

      DbOperations.addExpense(expense);
    }

    void checkIfCanBeAdded() {
      final scaffold = ScaffoldMessenger.of(context);
      if (paidByValue != paidForValue) {
        addExpense();
        Navigator.pop(context);
        scaffold.showSnackBar(const SnackBar(
          content: Text("Expense added!"),
          backgroundColor: Colors.green,
        ));
      } else {
        scaffold.showSnackBar(SnackBar(
          content: const Text("'Paid by...' cannot be equal to 'Paid for...'!"),
          backgroundColor: Colors.red,
          action: SnackBarAction(
              label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
        ));
      }
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Add new expense")),
        drawer: SideMenu(),
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
                DropdownButtonFormField(
                  hint: const Text('Paid by...'),
                  value: paidByValue,
                  items: group.members.map((member) {
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
                DropdownButtonFormField(
                  hint: const Text('Paid for...'),
                  value: paidForValue,
                  items: group.members.map((member) {
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
                    onPressed: () {checkIfCanBeAdded();},
                    child: const Text('Add expense',
                        style: TextStyle(fontSize: 18)),
                  ),
                ),
              ]),
            ),
          ],
        )
    );
  }
}
