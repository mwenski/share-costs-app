import 'package:flutter/material.dart';

import 'package:share_cost_app/routes.dart';
import 'package:share_cost_app/constant.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/components/expense_tab/expense_tab.dart';
import 'package:share_cost_app/components/balance_tab/balance_tab.dart';
import 'package:share_cost_app/components/widgets/side_menu.dart';

class GroupDashboard extends StatefulWidget {
  const GroupDashboard({Key? key}) : super(key: key);

  @override
  State<GroupDashboard> createState() => _GroupDashboardState();
}

class _GroupDashboardState extends State<GroupDashboard> {

  @override
  Widget build(BuildContext context) {
    final group = ModalRoute.of(context)!.settings.arguments as Group;

    void navigateToExpenseForm(){
      Navigator.pushNamed(context, Routes.expenseForm, arguments: {"group": group, "formType": FormType.add});
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
          endDrawer: const SideMenu(),
          body: TabBarView(children: [
            ExpenseTab(group: group),
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
