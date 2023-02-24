class Group {
  String id;
  String name;
  String description;
  DateTime date;

  Group(
      {required this.id,
      required this.name,
      required this.description,
      required this.date});

  static Group fromJson(Map<String, dynamic> json) => Group(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      date: DateTime.parse(json['date']));

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'description': description,
        'date': date.toString()
      };
}
