import 'package:flutter/material.dart';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_cost_app/services/db_operations.dart';

import 'package:share_cost_app/components/expenses_tab.dart';
import 'package:share_cost_app/components/balance_tab.dart';
import 'package:share_cost_app/routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    final groupId = ModalRoute.of(context)!.settings.arguments as String;

    void navigateToExpenseForm(){
      Navigator.pushNamed(context, Routes.newExpense, arguments: groupId);
    }

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [Tab(text: "Expenses"), Tab(text: "Balance")],
            ),
            title: const Text("Share Cost App - Dashboard"),
          ),
          body: TabBarView(children: [
            ExpensesTab(groupId: groupId),
            BalanceTab(groupId: groupId)
            // ListView(
            //   children: [
            //     //BarChart(data: myData, bars: , xAxis: myData[0][1], yAxis: yAxis),
            //     const Text("HOW TO SHARE COSTS",
            //         style: TextStyle(fontSize: 26, color: Colors.grey)),
            //     BalanceTab(groupId: groupId),
            //   ],
            // ),
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: navigateToExpenseForm,
            tooltip: "Add new expense",
            child: const Icon(Icons.add),
          ),
        ));
  }
}
