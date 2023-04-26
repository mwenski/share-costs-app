import 'package:flutter/material.dart';

import 'package:share_cost_app/routes.dart';
import 'package:share_cost_app/constant.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/components/expense_tab/expenses_tab.dart';
import 'package:share_cost_app/components/balance_tab/balance_tab.dart';
import 'package:share_cost_app/components/widgets/side_menu.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    final group = ModalRoute.of(context)!.settings.arguments as Group;

    void navigateToExpenseForm(){
      Navigator.pushNamed(context, Routes.newExpense, arguments: {"group": group, "formType": FormType.add});
    }

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [Tab(text: "Expenses"), Tab(text: "Balance")],
            ),
            title: const Text("Dashboard"),
          ),
          drawer: SideMenu(),
          body: TabBarView(children: [
            ExpensesTab(group: group),
            BalanceTab(group: group)
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: navigateToExpenseForm,
            tooltip: "Add new expense",
            child: const Icon(Icons.add),
          ),
        ));
  }
}
