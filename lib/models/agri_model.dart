import 'dart:convert';

class AgriModel {
  String name;
  double income;
  double expense;
  DateTime date;
  AgriModel({
    required this.name,
    required this.income,
    required this.expense,
    required this.date,
  });

  AgriModel copyWith({
    String? name,
    double? income,
    double? expense,
    DateTime? date,
  }) {
    return AgriModel(
      name: name ?? this.name,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'income': income});
    result.addAll({'expense': expense});
    result.addAll({'date': date.millisecondsSinceEpoch});

    return result;
  }

  factory AgriModel.fromMap(Map<String, dynamic> map) {
    return AgriModel(
      name: map['name'] ?? '',
      income: map['income']?.toDouble() ?? 0.0,
      expense: map['expense']?.toDouble() ?? 0.0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgriModel.fromJson(String source) =>
      AgriModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AgriModel(name: $name, income: $income, expense: $expense, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AgriModel &&
        other.name == name &&
        other.income == income &&
        other.expense == expense &&
        other.date == date;
  }

  @override
  int get hashCode {
    return name.hashCode ^ income.hashCode ^ expense.hashCode ^ date.hashCode;
  }
}
