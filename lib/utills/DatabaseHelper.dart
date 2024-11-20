import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final dbLocation = join(dbPath, path);
    return await openDatabase(dbLocation, version: 1, onCreate: _createDB);
  }

  // Create table
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE contacts (
      id $idType,
      name $textType,
      email $textType,
      phone $textType,
      website $textType
    )
    ''');
  }

  // Insert a new contact
  Future<void> insertContact(Map<String, dynamic> contact) async {
    final db = await instance.database;
    await db.insert('contacts', contact);
  }

  // Get all contacts
  Future<List<Map<String, dynamic>>> getContacts() async {
    final db = await instance.database;
    return await db.query('contacts');
  }

  // Delete a contact by ID
  Future<void> deleteContact(int id) async {
    final db = await instance.database;
    await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
