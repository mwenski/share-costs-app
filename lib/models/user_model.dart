class User {
  String id;
  String name;

  User({required this.id, required this.name});
  static User fromJson(Map<String, dynamic> json) =>
      User(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'name': name};
}
