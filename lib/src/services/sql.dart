import 'package:sqflite/sqflite.dart';

class SQLDatabase {
  static const _database = 'database.db';
  static const _version = 1;

  static const _table1 = 'table1';

  static late Database _db;

  static Future<SQLDatabase> getInstance() async {
    // ignore: prefer_adjacent_string_concatenation
    var sql = 'CREATE TABLE $_table1 (' +
        'ID TEXT UNIQUE,' +
        'TYPE TEXT,' +
        'PRICE REAL,' +
        'TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP' +
        ')';

    _db = await openDatabase(_database, version: _version, onCreate: (db, version) async {
      await db.execute(sql);
    });

    return SQLDatabase._();
  }

  SQLDatabase._();

  Future<int> add(item) async {
    var data = item.toMap();
    return await _db.insert(_table1, data);
  }

  Future<List<Map<String, Object?>>> getAll() async {
    var query = 'SELECT * FROM $_table1 ORDER BY TIMESTAMP DESC';
    return await _db.rawQuery(query);
  }

  Future<void> delete(String id) async {
    var query = 'DELETE FROM $_table1 WHERE id = ?';
    await _db.rawDelete(query, [id]);
  }

  Future<void> deleteAll() async {
    var query = 'DELETE FROM $_table1';
    await _db.rawDelete(query);
  }
}

late SQLDatabase sqlDatabase;
