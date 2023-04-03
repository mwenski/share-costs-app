import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Expense {
  String id;
  String name;
  String ownerId;
  String groupId;
  double amount;
  String paidBy;
  String paidFor;
  DateTime date;

  Expense(
      {String? id,
      required this.name,
      required this.ownerId,
      required this.groupId,
      required this.amount,
        required this.paidBy,
      required this.paidFor,
      DateTime? date})
      : id = id ?? Uuid().v4(), date = date ?? DateTime.now();

  static Expense fromJson(Map<String, dynamic> json) => Expense(
      id: json['id'],
      name: json['name'],
      ownerId: json['ownerId'],
      groupId: json['groupId'],
      amount: json['amount'],
      paidBy: json['paidBy'],
      paidFor: json['paidFor'],
      date: (json['date'] as Timestamp).toDate());

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'ownerId': ownerId,
        'groupId': groupId,
        'amount': amount,
        'paidBy': paidBy,
        'paidFor': paidFor,
        'date': date
      };
}
