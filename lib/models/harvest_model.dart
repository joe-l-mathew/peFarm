import 'dart:convert';

class HarvestModel {
  final double nos;
  final DateTime date;

  HarvestModel({
    required this.nos,
    required this.date,
  });

  HarvestModel copyWith({
    double? nos,
    DateTime? date,
  }) {
    return HarvestModel(
      nos: nos ?? this.nos,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'nos': nos});
    result.addAll({'date': date.millisecondsSinceEpoch});

    return result;
  }

  factory HarvestModel.fromMap(Map<String, dynamic> map) {
    return HarvestModel(
      nos: map['nos']?.toDouble() ?? 0.0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HarvestModel.fromJson(String source) =>
      HarvestModel.fromMap(json.decode(source));

  @override
  String toString() => 'HarvestModel(nos: $nos, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HarvestModel && other.nos == nos && other.date == date;
  }

  @override
  int get hashCode => nos.hashCode ^ date.hashCode;
}
