import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/services/authentication.dart';

class DbOperations {
  static Stream<QuerySnapshot> getGroupsStream() {
    return FirebaseFirestore.instance
        .collection('group')
        .where('ownerId',
            isEqualTo: Authentication.getCurrentUser()?.uid as String)
        .orderBy('date', descending: false)
        .snapshots();
  }

  static Stream<QuerySnapshot> getExpensesStream(String groupId) {
    return FirebaseFirestore.instance
        .collection('expenses')
        .where('ownerId',
            isEqualTo: Authentication.getCurrentUser()?.uid as String)
        .where('groupId', isEqualTo: groupId)
        .snapshots();
  }

  static String? addGroup(Group group) {
    var result = null;
    FirebaseFirestore.instance
        .collection('group')
        .add(group.toJson())
        .then((value) => print("Group Added"))
        .catchError((error) => result = "Failed to add group: $error");

    return result;
  }

  static void addExpense(Expense expense) {
    FirebaseFirestore.instance
        .collection('expenses')
        .add(expense.toJson())
        .then((value) => print("Expense Added"))
        .catchError((error) => print("Failed to add expense: $error"));
  }

  static List<Expense> getExpenses(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<Expense> expenses =
        snapshot.data!.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      Expense expense = Expense.fromJson(data);
      return expense;
    }).toList();
    return expenses;
  }

  static Future<String?> removeExpense(String id) async {
    var result;
    FirebaseFirestore.instance
        .collection('expenses')
        .where('ownerId',
            isEqualTo: Authentication.getCurrentUser()?.uid as String)
        .where('id', isEqualTo: id)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference
          .delete()
          .catchError((error) => result = "Expense cannot be removed: $error");
    });
    return result;
  }

  static Future<void> removeExpenses(String groupId) async {
    var result;
    FirebaseFirestore.instance
        .collection('expenses')
        .where('ownerId',
            isEqualTo: Authentication.getCurrentUser()?.uid as String)
        .where('groupId', isEqualTo: groupId)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        element.reference
            .delete()
            .catchError((error) => "Expenses cannot be removed!");
      });
    });
    return result;
  }

  static Future<String?> removeGroup(String id) async {
    var result;
    FirebaseFirestore.instance
        .collection('group')
        .where('ownerId',
            isEqualTo: Authentication.getCurrentUser()?.uid as String)
        .where('id', isEqualTo: id)
        .get()
        .then((snapshot) {
      result = removeExpenses(id);
      snapshot.docs.first.reference.delete().catchError((error) => result = "Group cannot be removed: $error");
    });
    return result;
  }
}
