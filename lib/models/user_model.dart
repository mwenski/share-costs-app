class User {
  String id;
  String name;
  String email;

  User({required this.id, required this.name, required this.email});
  static User fromJson(Map<String, dynamic> json) =>
      User(id: json['id'], name: json['name'], email: json['email']);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'id': id, 'name': name, 'email': email};
}
