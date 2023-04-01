import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  String id;
  String ownerId;
  String name;
  String description;
  DateTime date;

  Group(
      {required this.id,
      required this.ownerId,
      required this.name,
      required this.description,
      required this.date});

  static Group fromJson(Map<String, dynamic> json) => Group(
      id: json['id'],
      ownerId: json['ownerId'],
      name: json['name'],
      description: json['description'],
      date: (json['date'] as Timestamp).toDate());

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
    'ownerId': ownerId,
        'name': name,
        'description': description,
        'date': date.toString()
      };
}
