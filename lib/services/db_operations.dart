import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/services/authentication.dart';

class DbOperations {
  static Stream<QuerySnapshot> getGroupsStream() {
    return FirebaseFirestore.instance
        .collection('group')
        .where('ownerId', isEqualTo: Authentication.getCurrentUser()?.uid as String)
        .orderBy('date', descending: false)
        .snapshots();
  }

  static Stream<QuerySnapshot> getExpensesStream(String groupId) {
    return FirebaseFirestore.instance
        .collection('expenses')
        .where('ownerId', isEqualTo: Authentication.getCurrentUser()?.uid as String)
        .where('groupId', isEqualTo: groupId)
        .snapshots();
  }

  static void addGroup(Group group){
    FirebaseFirestore.instance.collection('group')
        .add(group.toJson())
        .then((value) => print("Expense Added"))
        .catchError((error) => print("Failed to add expense: $error"));
  }

  static void addExpense(Expense expense){
    FirebaseFirestore.instance.collection('expenses')
        .add(expense.toJson())
        .then((value) => print("Expense Added"))
        .catchError((error) => print("Failed to add expense: $error"));
  }

  static List<Expense> getExpenses(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<Expense> expenses = snapshot.data!.docs.map((
        DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      Expense expense = Expense.fromJson(data);
      return expense;
    }).toList();
    return expenses;
  }

  static Future<void> removeExpense(String id) async {
    FirebaseFirestore.instance
        .collection('expenses')
        .where('ownerId', isEqualTo: Authentication.getCurrentUser()?.uid as String)
        .where('id', isEqualTo: id)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.delete();
    });
  }

  static Future<void> removeExpenses(String groupId) async {
    FirebaseFirestore.instance
        .collection('expenses')
        .where('ownerId', isEqualTo: Authentication.getCurrentUser()?.uid as String)
        .where('groupId', isEqualTo: groupId)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        element.reference.delete();
      });
    });
  }

  static Future<void> removeGroup(String id) async {
    FirebaseFirestore.instance
        .collection('group')
        .where('ownerId', isEqualTo: Authentication.getCurrentUser()?.uid as String)
        .where('id', isEqualTo: id)
        .get()
        .then((snapshot) {
      removeExpenses(id);
      snapshot.docs.first.reference.delete();
    });
  }
}