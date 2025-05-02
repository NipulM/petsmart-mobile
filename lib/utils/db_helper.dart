import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'users.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
      onConfigure: (db) async {
        // Enable foreign keys
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  void _createDatabase(Database db, int versionNumber) async {
    await db.execute('''
      CREATE TABLE Users(
        user_id VARCHAR(255) NOT NULL UNIQUE,
        name VARCHAR(100) NOT NULL,
        email VARCHAR(255) NOT NULL,
        bio TEXT,
        preferences TEXT,
        address TEXT,
        phone VARCHAR(15),
        pet_info TEXT,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        role TEXT CHECK(role IN ('user', 'admin', 'super-admin'))
      )
    ''');
  }

  Future<void> insertUser(User newUser) async {
    Database db = await database;
    int newID = await db.insert("Users", newUser.toMap());
    print("New ID ==> $newID");
  }

  Future<User?> getUserById(String userId) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Users',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateUser(User user) async {
    Database db = await database;
    await db.update(
      'Users',
      user.toMap(),
      where: 'user_id = ?',
      whereArgs: [user.userId],
    );
  }
}
