import 'package:uuid/uuid.dart';

class User {
  String id;
  String name;
  String? email;

  User({String? id, required this.name, this.email}): id = id ?? Uuid().v4();

  static User fromJson(Map<String, dynamic> json) =>
      User(id: json['id'], name: json['name'], email: json['email']);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'id': id, 'name': name, 'email': email};
}
