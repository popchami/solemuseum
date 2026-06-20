import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'solemuseum.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE brands (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        sort_order INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE shoes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        brand_id INTEGER NOT NULL,
        model_name TEXT NOT NULL,
        size TEXT,
        color TEXT,
        purchase_date TEXT,
        purchase_price INTEGER,
        purchase_store TEXT,
        memo TEXT,
        is_favorite INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (brand_id) REFERENCES brands(id)
      )
    ''');

    await db.execute('CREATE INDEX idx_shoes_brand_id ON shoes(brand_id)');
    await db.execute('CREATE INDEX idx_shoes_created_at ON shoes(created_at)');
    await db.execute('CREATE INDEX idx_shoes_is_favorite ON shoes(is_favorite)');

    await _insertInitialBrands(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Future migrations will be handled here.
  }

  Future<void> _insertInitialBrands(Database db) async {
    const brands = [
      'Nike',
      'Jordan',
      'adidas',
      'New Balance',
      'ASICS',
      'PUMA',
      'Converse',
      'Vans',
      'Reebok',
      'Mizuno',
      'On',
      'HOKA',
      'Salomon',
      'Saucony',
      'Y-3',
      'その他',
    ];

    for (var i = 0; i < brands.length; i++) {
      await db.insert(
        'brands',
        {
          'name': brands[i],
          'sort_order': i + 1,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }
}
