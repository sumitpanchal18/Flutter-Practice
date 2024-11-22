import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Contact.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    String path = join(await getDatabasesPath(), 'contact.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT)',
      );
    });
  }

  // Insert a new contact
  Future<int> insertContact(Contact contact) async {
    final db = await database;
    return await db.insert('contacts', contact.toMap());
  }

  // Update a contact
  Future<int> updateContact(Contact contact) async {
    final db = await database;
    return await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  // Delete a contact
  Future<int> deleteContact(int id) async {
    final db = await database;
    return await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Get all contacts
  Future<List<Contact>> getAllContacts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contacts');
    return List.generate(maps.length, (i) {
      return Contact.fromMap(maps[i]);
    });
  }
}
