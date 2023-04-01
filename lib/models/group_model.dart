import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_cost_app/models/user_model.dart';
import 'package:uuid/uuid.dart';

class Group {
  String id;
  String ownerId;
  String name;
  String description;
  List<User> members;
  DateTime date;

  Group(
      {String? id,
      required this.ownerId,
      required this.name,
      required this.description,
      required this.members,
      DateTime? date})
      : id = id ?? Uuid().v4(), date = date ?? DateTime.now();

  static Group fromJson(Map<String, dynamic> json) => Group(
      id: json['id'],
      ownerId: json['ownerId'],
      name: json['name'],
      description: json['description'],
      date: (json['date'] as Timestamp).toDate(),
      members: json['members'] != null
          ? List.from((json['members']).map((member) => User.fromJson(member)))
          : List<User>.empty());

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'ownerId': ownerId,
        'name': name,
        'description': description,
        'date': date,
        'members': members.map((member) => member.toJson()).toList()
      };
}
