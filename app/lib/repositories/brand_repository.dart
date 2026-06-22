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

  /// Returns the new row id, or 0 if the name already exists.
  Future<int> insertBrand(String name) async {
    final db = await AppDatabase.instance.database;
    final existing = await db.query(
      'brands',
      where: 'name = ?',
      whereArgs: [name],
      limit: 1,
    );
    if (existing.isNotEmpty) return 0;

    final maxRows = await db.rawQuery(
      'SELECT MAX(sort_order) AS max_order FROM brands',
    );
    final maxOrder = maxRows.first['max_order'] as int? ?? 0;
    return db.insert('brands', {'name': name, 'sort_order': maxOrder + 1});
  }

  /// Returns true if deleted, false if the brand has shoes registered.
  Future<bool> deleteBrand(int id) async {
    final db = await AppDatabase.instance.database;
    final rows = await db.rawQuery(
      'SELECT COUNT(*) AS cnt FROM shoes WHERE brand_id = ?',
      [id],
    );
    final shoeCount = rows.first['cnt'] as int? ?? 0;
    if (shoeCount > 0) return false;

    final deleted = await db.delete(
      'brands',
      where: 'id = ?',
      whereArgs: [id],
    );
    return deleted > 0;
  }
}
