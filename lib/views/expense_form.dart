import 'package:flutter/material.dart';

import 'package:share_cost_app/constant.dart';
import 'package:share_cost_app/style.dart';
import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/models/user_model.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/services/db_operations.dart';
import 'package:share_cost_app/services/authentication.dart';
import 'package:share_cost_app/components/widgets/side_menu.dart';
import 'package:share_cost_app/components/widgets/widgets.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({Key? key}) : super(key: key);

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  var nameController = TextEditingController();
  var amountController = TextEditingController();
  var paidByController = TextEditingController();
  var paidForController = TextEditingController();
  String paidByValue = "";
  String paidForValue = "";

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final FormType formType = arguments["formType"];

    Group? group;
    Expense? expense;
    List<User> members;

    if(formType == FormType.update){
      expense = arguments["expense"];
      members = arguments["members"];
      nameController = TextEditingController(text: expense?.name);
      amountController = TextEditingController(text: expense?.amount.toStringAsPrecision(2));
      paidByValue = members.firstWhere((element) => element.id == expense?.paidBy, orElse: () => members[0]).id;
      paidForValue = members.firstWhere((element) => element.id == expense?.paidFor, orElse: () => members[1]).id;
    }else{
      group = arguments["group"];
      members = group!.members;
      paidByValue = members[0].id;
      paidForValue = members[1].id;
    }

    void addExpense() {
      Expense newExpense = Expense(
          name: nameController.text,
          ownerId: Authentication.getCurrentUser()?.uid as String,
          groupId: group!.id,
          amount: double.parse(amountController.text),
          paidBy: paidByValue,
          paidFor: paidForValue);

      DbOperations.addExpense(newExpense);
    }

    void updateExpense() async {
      Expense updatedExpense = Expense(
          id: expense?.id,
          name: nameController.text,
          ownerId: Authentication.getCurrentUser()?.uid as String,
          groupId: expense?.groupId as String,
          amount: double.parse(amountController.text),
          paidBy: paidByValue,
          paidFor: paidForValue);

      await DbOperations.updateExpense(updatedExpense);
    }

    void performOperation() {
      if (paidByValue == paidForValue) {
        Widgets.scaffoldMessenger(
            context, "'Paid by...' cannot be equal to 'Paid for...'!", "");
        return;
      }

      if (formType == FormType.update){
        updateExpense();
        Navigator.pop(context);
        Widgets.scaffoldMessenger(context, null, "Expense updated!");
      }else{
        addExpense();
        Navigator.pop(context);
        Widgets.scaffoldMessenger(context, null, "Expense added!");
      }
    }

    return Scaffold(
        appBar: AppBar(title: Text(formType == FormType.update ? "Update expense" : "Add new expense")),
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
                Row(
                  children: <Widget>[
                    const Text("Paid by:  ", style: Style.labelStyle,),
                    Expanded(
                      child: DropdownButtonFormField(
                        hint: const Text('Paid by...'),
                        value: paidByValue,
                        items: members.map((member) {
                                return DropdownMenuItem<String>(
                                  value: member.id,
                                  child: Text(member.name),
                                );
                              }).toList(),
                        onChanged: (value) => paidByValue = value as String,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text("Paid for: ", style: Style.labelStyle,),
                    Expanded(
                      child: DropdownButtonFormField(
                        hint: const Text('Paid for...'),
                        value: paidForValue,
                        items: members.map((member) {
                                return DropdownMenuItem<String>(
                                  value: member.id,
                                  child: Text(member.name),
                                );
                              }).toList(),
                        onChanged: (value) => paidForValue = value as String,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      performOperation();
                      },
                    child: Text(formType == FormType.update ? "Update expense" : "Add expense",
                        style: const TextStyle(fontSize: 18)),
                  ),
                ),
              ]),
            ),
          ],
        )
    );
  }
}
