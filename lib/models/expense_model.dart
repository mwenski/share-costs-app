class Expense {
  String id;
  String name;
  String ownerId;
  double amount;
  DateTime date;

  Expense(
      {required this.id,
      required this.name,
      required this.ownerId,
      required this.amount,
      required this.date});
  static Expense fromJson(Map<String, dynamic> json) => Expense(
      id: json['id'],
      name: json['name'],
      ownerId: json['ownerId'],
      amount: json['amount'],
      date: DateTime.parse(json['date']));

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'ownerId': ownerId,
        'amount': amount,
        'date': date.toString()
      };
}
