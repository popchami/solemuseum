import '../database/app_database.dart';
import '../models/brand.dart';

class BrandRepository {
  Future<List<Brand>> getAllBrands() async {
    final db = await AppDatabase.instance.database;
    final maps = await db.query(
      'brands',
      orderBy: 'sort_order ASC',
    );
    return maps.map(Brand.fromMap).toList();
  }

  Future<Brand?> getBrandById(int id) async {
    final db = await AppDatabase.instance.database;
    final maps = await db.query(
      'brands',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) {
      return null;
    }
    return Brand.fromMap(maps.first);
  }

  Future<Brand?> findByName(String name) async {
    final db = await AppDatabase.instance.database;
    final normalized = name.trim();
    if (normalized.isEmpty) return null;

    final maps = await db.query(
      'brands',
      where: 'LOWER(name) = LOWER(?)',
      whereArgs: [normalized],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return Brand.fromMap(maps.first);
  }

  Future<Brand> findOrCreateByName(String name) async {
    final db = await AppDatabase.instance.database;
    final normalized = name.trim();
    if (normalized.isEmpty) {
      throw ArgumentError('Brand name is required');
    }

    final existing = await findByName(normalized);
    if (existing != null) return existing;

    final countResult = await db.rawQuery('SELECT COUNT(*) AS count FROM brands');
    final count = countResult.first['count'] as int? ?? 0;
    final brand = Brand(name: normalized, sortOrder: count + 1);
    final id = await db.insert('brands', brand.toMap());
    return Brand(id: id, name: normalized, sortOrder: brand.sortOrder);
  }
}
