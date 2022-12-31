import 'dart:convert';

class DateModel {
  final DateTime date;
  DateModel({
    required this.date,
  });

  DateModel copyWith({
    DateTime? date,
  }) {
    return DateModel(
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'date': date.millisecondsSinceEpoch});
  
    return result;
  }

  factory DateModel.fromMap(Map<String, dynamic> map) {
    return DateModel(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DateModel.fromJson(String source) => DateModel.fromMap(json.decode(source));

  @override
  String toString() => 'DateModel(date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DateModel &&
      other.date == date;
  }

  @override
  int get hashCode => date.hashCode;
}
