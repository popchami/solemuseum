class Brand {
  final int? id;
  final String name;
  final int sortOrder;

  const Brand({
    this.id,
    required this.name,
    required this.sortOrder,
  });

  factory Brand.fromMap(Map<String, Object?> map) {
    return Brand(
      id: map['id'] as int?,
      name: map['name'] as String,
      sortOrder: map['sort_order'] as int,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'sort_order': sortOrder,
    };
  }
}
