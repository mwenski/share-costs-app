import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Expense {
  String id;
  String name;
  String ownerId;
  String groupId;
  double amount;
  DateTime date;

  Expense(
      {String? id,
      required this.name,
      required this.ownerId,
      required this.groupId,
      required this.amount,
      DateTime? date})
      : id = id ?? Uuid().v4(), date = date ?? DateTime.now();

  static Expense fromJson(Map<String, dynamic> json) => Expense(
      id: json['id'],
      name: json['name'],
      ownerId: json['ownerId'],
      groupId: json['groupId'],
      amount: json['amount'],
      date: (json['date'] as Timestamp).toDate());

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'ownerId': ownerId,
        'groupId': groupId,
        'amount': amount,
        'date': date
      };
}
