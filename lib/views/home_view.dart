import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:share_cost_app/components/list_item.dart';
import 'package:share_cost_app/components/balance_list_item.dart';
import 'package:share_cost_app/routes.dart';

import 'package:fcharts/fcharts.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _expensesStream = FirebaseFirestore.instance.collection('expenses').orderBy('date', descending: false).snapshots();

    void _navigateToNewExpenseView(){
      Navigator.pushNamed(context, Routes.newExpense);
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
            StreamBuilder<QuerySnapshot>(
              stream: _expensesStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading...");
                }

                return ListView(children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return ListItem(name: data['name'], amount: data['amount'], date: data['date'].toDate().toString(), addedBy: data['added_by']);
                }).toList(),);
              },
            ),
            ListView(
              children: [
                //BarChart(data: myData, bars: , xAxis: myData[0][1], yAxis: yAxis),
                const Text("HOW TO SHARE COSTS",
                    style: TextStyle(fontSize: 26, color: Colors.grey)),
                for (var i = 0; i < 10; i++)
                  BalanceListItem(
                      sender: "user1", recipient: "user2", amount: "1.0"),
              ],
            ),
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: _navigateToNewExpenseView,
            tooltip: "Add new expense",
            child: const Icon(Icons.add),
          ),
        ));
  }
}
