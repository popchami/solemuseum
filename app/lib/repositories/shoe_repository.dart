import 'dart:io';

import '../database/app_database.dart';
import '../models/shoe.dart';

class ShoeRepository {
  Future<List<Shoe>> getAllShoes() async {
    final db = await AppDatabase.instance.database;
    final maps = await db.query(
      'shoes',
      orderBy: 'created_at DESC',
    );
    return maps.map(Shoe.fromMap).toList();
  }

  Future<Shoe?> getShoeById(int id) async {
    final db = await AppDatabase.instance.database;
    final maps = await db.query(
      'shoes',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) {
      return null;
    }
    return Shoe.fromMap(maps.first);
  }

  Future<int> insertShoe(Shoe shoe) async {
    final db = await AppDatabase.instance.database;
    return db.insert('shoes', shoe.toMap()..remove('id'));
  }

  Future<int> updateShoe(Shoe shoe) async {
    final db = await AppDatabase.instance.database;
    return db.update(
      'shoes',
      shoe.copyWith(updatedAt: DateTime.now()).toMap()..remove('id'),
      where: 'id = ?',
      whereArgs: [shoe.id],
    );
  }

  Future<int> deleteShoe(int id) async {
    final db = await AppDatabase.instance.database;
    final photoRows = await db.query(
      'photos',
      columns: ['file_path'],
      where: 'shoe_id = ?',
      whereArgs: [id],
    );

    final deletedCount = await db.delete(
      'shoes',
      where: 'id = ?',
      whereArgs: [id],
    );

    for (final row in photoRows) {
      final filePath = row['file_path'] as String?;
      if (filePath == null || filePath.isEmpty) {
        continue;
      }
      try {
        final file = File(filePath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (_) {
        // The database delete has already succeeded. A missing or locked file
        // should not make shoe deletion fail from the user's perspective.
      }
    }

    return deletedCount;
  }

  Future<bool> setTopFive(int id, bool selected) async {
    final db = await AppDatabase.instance.database;

    if (!selected) {
      final updated = await db.update(
        'shoes',
        {
          'top_order': null,
          'updated_at': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [id],
      );
      return updated > 0;
    }

    final countRows = await db.rawQuery(
      'SELECT COUNT(*) AS count FROM shoes WHERE top_order IS NOT NULL',
    );
    final count = countRows.first['count'] as int? ?? 0;
    if (count >= 5) {
      return false;
    }

    final maxRows = await db.rawQuery(
      'SELECT MAX(top_order) AS max_order FROM shoes',
    );
    final maxOrder = maxRows.first['max_order'] as int? ?? 0;
    final updated = await db.update(
      'shoes',
      {
        'top_order': maxOrder + 1,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    return updated > 0;
  }

  Future<int> toggleFavorite(int id, bool isFavorite) async {
    final db = await AppDatabase.instance.database;
    return db.update(
      'shoes',
      {
        'is_favorite': isFavorite ? 1 : 0,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
