class Expense {
  String id;
  String name;
  String addedBy;
  double amount;
  DateTime date;

  Expense(
      {required this.id,
      required this.name,
      required this.addedBy,
      required this.amount,
      required this.date});
  static Expense fromJson(Map<String, dynamic> json) => Expense(
      id: json['id'],
      name: json['name'],
      addedBy: json['added_by'],
      amount: json['amount'],
      date: DateTime.parse(json['date']));

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'added_by': addedBy,
        'amount': amount,
        'date': date.toString()
      };
}
