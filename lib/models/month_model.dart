import 'dart:convert';

class MonthModel {
  final DateTime date;
  final double totalNos;
  MonthModel({
    required this.date,
    required this.totalNos,
  });

  MonthModel copyWith({
    DateTime? date,
    double? totalNos,
  }) {
    return MonthModel(
      date: date ?? this.date,
      totalNos: totalNos ?? this.totalNos,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'date': date.millisecondsSinceEpoch});
    result.addAll({'totalNos': totalNos});

    return result;
  }

  factory MonthModel.fromMap(Map<String, dynamic> map) {
    return MonthModel(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      totalNos: map['totalNos']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MonthModel.fromJson(String source) =>
      MonthModel.fromMap(json.decode(source));

  @override
  String toString() => 'MonthModel(date: $date, totalNos: $totalNos)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MonthModel &&
        other.date == date &&
        other.totalNos == totalNos;
  }

  @override
  int get hashCode => date.hashCode ^ totalNos.hashCode;
}
