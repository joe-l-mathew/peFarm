import 'dart:convert';

class ExpenseModel {
  final double amount;
  final String title;
  final DateTime date;
  ExpenseModel({
    required this.amount,
    required this.title,
    required this.date,
  });

  ExpenseModel copyWith({
    double? amount,
    String? title,
    DateTime? date,
  }) {
    return ExpenseModel(
      amount: amount ?? this.amount,
      title: title ?? this.title,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'amount': amount});
    result.addAll({'title': title});
    result.addAll({'date': date.millisecondsSinceEpoch});

    return result;
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      amount: map['amount']?.toDouble() ?? 0.0,
      title: map['title'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ExpenseModel(amount: $amount, title: $title, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseModel &&
        other.amount == amount &&
        other.title == title &&
        other.date == date;
  }

  @override
  int get hashCode => amount.hashCode ^ title.hashCode ^ date.hashCode;
}
