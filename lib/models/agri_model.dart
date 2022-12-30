import 'dart:convert';

class AgriModel {
  String name;
  double income;
  double expense;
  DateTime date;
  double nos;
  AgriModel({
    required this.name,
    required this.income,
    required this.expense,
    required this.date,
    required this.nos,
  });

  AgriModel copyWith({
    String? name,
    double? income,
    double? expense,
    DateTime? date,
    double? nos,
  }) {
    return AgriModel(
      name: name ?? this.name,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      date: date ?? this.date,
      nos: nos ?? this.nos,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'income': income});
    result.addAll({'expense': expense});
    result.addAll({'date': date.millisecondsSinceEpoch});
    result.addAll({'nos': nos});

    return result;
  }

  factory AgriModel.fromMap(Map<String, dynamic> map) {
    return AgriModel(
      name: map['name'] ?? '',
      income: map['income']?.toDouble() ?? 0.0,
      expense: map['expense']?.toDouble() ?? 0.0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      nos: map['nos']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgriModel.fromJson(String source) =>
      AgriModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AgriModel(name: $name, income: $income, expense: $expense, date: $date, nos: $nos)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AgriModel &&
        other.name == name &&
        other.income == income &&
        other.expense == expense &&
        other.date == date &&
        other.nos == nos;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        income.hashCode ^
        expense.hashCode ^
        date.hashCode ^
        nos.hashCode;
  }
}
