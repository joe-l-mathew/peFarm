import 'dart:convert';

class UserModel {
  final String phoneNumber;
  final String uid;
  final double income;
  final double expense;

  UserModel({
    required this.phoneNumber,
    required this.uid,
    this.income = 0,
    this.expense = 0,
  });

  UserModel copyWith({
    String? phoneNumber,
    String? uid,
    double? income,
    double? expense,
  }) {
    return UserModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      uid: uid ?? this.uid,
      income: income ?? this.income,
      expense: expense ?? this.expense,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'uid': uid});
    result.addAll({'income': income});
    result.addAll({'expense': expense});
  
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      phoneNumber: map['phoneNumber'] ?? '',
      uid: map['uid'] ?? '',
      income: map['income']?.toDouble() ?? 0.0,
      expense: map['expense']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(phoneNumber: $phoneNumber, uid: $uid, income: $income, expense: $expense)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.phoneNumber == phoneNumber &&
      other.uid == uid &&
      other.income == income &&
      other.expense == expense;
  }

  @override
  int get hashCode {
    return phoneNumber.hashCode ^
      uid.hashCode ^
      income.hashCode ^
      expense.hashCode;
  }
}
