import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/services/db_operations.dart';
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
    final Stream<QuerySnapshot> balanceStream = DbOperations.getExpensesStream(widget.groupId);

    return StreamBuilder<QuerySnapshot>(
      stream: balanceStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        List<Expense> expenses = DbOperations.getExpenses(snapshot);

        //Balance calculations start here
        List<Map<String, dynamic>> balanceList = <Map<String, dynamic>>[];
        Map<String, double> balance = {};

        expenses.forEach((expense) {
          if (balanceList.any((element) =>
              (element['paidFor'] == expense.paidFor &&
                  element['paidBy'] == expense.paidBy))) {
            var balanceElement = balanceList.firstWhere((element) =>
                (element['paidFor'] == expense.paidFor &&
                    element['paidBy'] == expense.paidBy));
            balanceElement['amount'] += expense.amount;
          } else {
            balanceList.add({
              'paidFor': expense.paidFor,
              'paidBy': expense.paidBy,
              'amount': expense.amount
            });
          }

          balance[expense.paidBy] = (balance[expense.paidBy] == null)
              ? expense.amount
              : balance[expense.paidBy]! + expense.amount;
          balance[expense.paidFor] = (balance[expense.paidFor] == null)
              ? -expense.amount
              : balance[expense.paidFor]! - expense.amount;
        });

        for(var i=0; i<balanceList.length; i++){
          for(var j=i; j<balanceList.length; j++){
            if(balanceList[i]['paidFor']==balanceList[j]['paidBy'] && balanceList[j]['paidFor']==balanceList[i]['paidBy']){
              if(balanceList[i]['amount']>balanceList[j]['amount']){
                balanceList[i]['amount'] -= balanceList[j]['amount'];
                balanceList.removeAt(j);
              }else if(balanceList[i]['amount']>balanceList[j]['amount']){
                balanceList[j]['amount'] -= balanceList[i]['amount'];
                balanceList.removeAt(i);
              }
            }
          }
        }

        //Balance calculations end here
        return ListView(
          children: balanceList.map((balanceElement) {
            return BalanceListItem(
                paidFor: balanceElement['paidFor'],
                paidBy: balanceElement['paidBy'],
                amount: balanceElement['amount'].toString());
          }).toList(),
        );
      },
    );
  }
}