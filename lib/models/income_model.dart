import 'dart:convert';

class IncomeModel {
  final double amount;
  final String title;
  final DateTime date;
  IncomeModel({
    required this.amount,
    required this.title,
    required this.date,
  });

  IncomeModel copyWith({
    double? amount,
    String? title,
    DateTime? date,
  }) {
    return IncomeModel(
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

  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel(
      amount: map['amount']?.toDouble() ?? 0.0,
      title: map['title'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory IncomeModel.fromJson(String source) =>
      IncomeModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'IncomeModel(amount: $amount, title: $title, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IncomeModel &&
        other.amount == amount &&
        other.title == title &&
        other.date == date;
  }

  @override
  int get hashCode => amount.hashCode ^ title.hashCode ^ date.hashCode;
}
