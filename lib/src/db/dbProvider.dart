import 'dart:io';

import 'package:coding_challenge_from_kriya/src/models/sampleModels.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "SampleDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Cart ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "qty INTEGER"
          ")");
    });
  }

  addCart(Sample sample) async {
    final db = await database;
    var exist = await db.query("Cart", where: "id = ?", whereArgs: [sample.id]);
    var res;
    if (exist.isEmpty) {
      res = await db.insert("Cart", sample.toJson());
    } else {
      sample.qty++;
      res = await db.update("Cart", sample.toJson(),
          where: "id = ?", whereArgs: [sample.id]);
    }
    return res;
  }

  deleteCart(int id) async {
    final db = await database;
    db.delete("Cart", where: "id = ?", whereArgs: [id]);
  }

  getListCart(String userId) async {
    final db = await database;
    var res = await db.query("Cart", where: "title = ?", whereArgs: [userId]);
    List<Sample> list =
        res.isNotEmpty ? res.map((c) => Sample.fromJson(c)).toList() : [];
    return list;
  }

  getProdCartExist(
    int id,
  ) async {
    final db = await database;
    var res = await db.query("Cart", where: "id = ? ", whereArgs: [id]);
    return res.isNotEmpty ? Sample.fromJson(res.first) : null;
  }

  updateCArt(int id, int qty) async {
    final db = await database;
    var exist = await getProdCartExist(id);
    exist.qty = qty;
    var res = await db
        .update("Cart", exist.toMap(), where: "id = ?", whereArgs: [exist.id]);
    return res;
  }
}
