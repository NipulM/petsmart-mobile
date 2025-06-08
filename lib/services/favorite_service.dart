import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/favorite.dart';

class FavoriteService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'favorites.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE favorites(
            productId TEXT PRIMARY KEY,
            name TEXT,
            price REAL,
            imageUrl TEXT,
            category TEXT,
            description TEXT
          )
        ''');
      },
    );
  }

  Future<void> toggleFavorite(Favorite favorite) async {
    final db = await database;
    bool isFavorite = await isProductFavorite(favorite.productId);
    
    if (isFavorite) {
      await db.delete(
        'favorites',
        where: 'productId = ?',
        whereArgs: [favorite.productId],
      );
    } else {
      await db.insert(
        'favorites',
        favorite.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<bool> isProductFavorite(String productId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favorites',
      where: 'productId = ?',
      whereArgs: [productId],
    );
    return maps.isNotEmpty;
  }

  Future<List<Favorite>> getAllFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) => Favorite.fromMap(maps[i]));
  }
} 