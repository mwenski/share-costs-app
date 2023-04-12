import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/models/user_model.dart';

Stream<QuerySnapshot> getExpensesStream(String groupId) {
  return FirebaseFirestore.instance
      .collection('expenses')
      .where('groupId', isEqualTo: groupId)
      .snapshots();
}

List<Expense> getExpenses(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<Expense> expenses = snapshot.data!.docs.map((DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    Expense expense = Expense.fromJson(data);
    return expense;
  }).toList();
  return expenses;
}

Future<List<User>> getUsers(String id) async {
  List<User> users = [];
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('group')
      .where('id', isEqualTo: id)
      .get();

  querySnapshot.docs.forEach((element) {
    Map<String, dynamic> data = element.data() as Map<String, dynamic>;
    Group group = Group.fromJson(data);
      for (User member in group.members) {
      users.add(member);
    }
  });

  return users;
}

Future<void> removeExpense(String id) async {
  FirebaseFirestore.instance
      .collection('expenses')
      .where('id', isEqualTo: id)
      .get()
      .then((snapshot) {
    snapshot.docs.first.reference.delete();
  });
}

Future<void> removeExpenses(String groupId) async {
  FirebaseFirestore.instance
      .collection('expenses')
      .where('groupId', isEqualTo: groupId)
      .get()
      .then((snapshot) {
        snapshot.docs.forEach((element) {
          element.reference.delete();
        });
      });
}

Future<void> removeGroup(String id) async {
  FirebaseFirestore.instance
      .collection('group')
      .where('id', isEqualTo: id)
      .get()
      .then((snapshot) {
        removeExpenses(id);
    snapshot.docs.first.reference.delete();
  });
}
