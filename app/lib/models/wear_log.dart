class WearLog {
  final int? id;
  final int shoeId;
  final DateTime wornDate;
  final String? memo;
  final DateTime createdAt;

  const WearLog({
    this.id,
    required this.shoeId,
    required this.wornDate,
    this.memo,
    required this.createdAt,
  });

  factory WearLog.create({
    required int shoeId,
    required DateTime wornDate,
    String? memo,
  }) {
    return WearLog(
      shoeId: shoeId,
      wornDate: DateTime(wornDate.year, wornDate.month, wornDate.day),
      memo: memo,
      createdAt: DateTime.now(),
    );
  }

  factory WearLog.fromMap(Map<String, Object?> map) {
    return WearLog(
      id: map['id'] as int?,
      shoeId: map['shoe_id'] as int,
      wornDate: DateTime.parse(map['worn_date'] as String),
      memo: map['memo'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'shoe_id': shoeId,
      'worn_date': wornDate.toIso8601String(),
      'memo': memo,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
