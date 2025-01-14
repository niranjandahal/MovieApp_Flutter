import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class FavMovielist {
  static const dbname = 'favlist.db';
  static const dbversion = 1;
  static const tablename = 'favoriatelist';
  static const columnId = 'id';
  static const columnfavid = 'tmdbid';
  static const columnfavtype = 'tmdbtype';
  static const columnfavname = 'tmdbname';
  static const columnfavrating = 'tmdbrating';

  static final FavMovielist _instance = FavMovielist();
  static Database? _database;

  Future<Database?> get db async {
    _database ??= await _initDb();
    return _database;
  }

  _initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, dbname);
    return await openDatabase(path, version: dbversion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tablename (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnfavid TEXT NOT NULL,
      $columnfavtype TEXT NOT NULL,
      $columnfavname TEXT NOT NULL,
      $columnfavrating TEXT NOT NULL
    )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await _instance.db;
    return await db!.insert(tablename, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database? db = await _instance.db;
    return await db!.query(tablename);
  }

  Future<int> delete(int id) async {
    Database? db = await _instance.db;
    return await db!.delete(tablename, where: '$columnId = ?', whereArgs: [id]);
  }

//delete from database by tmdbid and tmdbtype
  Future deletespecific(String id, String type) async {
    Database? db = await _instance.db;
    return await db!.delete(tablename,
        where: '$columnfavid = ? AND $columnfavtype = ?',
        whereArgs: [id, type]);
  }

  Future search(String id, String name, String type) async {
    Database? db = await _instance.db;
    return Sqflite.firstIntValue(await db!.rawQuery(
        'SELECT COUNT(*) FROM $tablename WHERE $columnfavid = ? AND $columnfavname = ? AND $columnfavtype = ?',
        [id, name, type]));
  }

  ////sort by name

  Future<List<Map<String, dynamic>>> queryAllSorted() async {
    Database? db = await _instance.db;
    return await db!.query(tablename, orderBy: '$columnfavname ASC');
  }

  ////sort by rating

  Future<List<Map<String, dynamic>>> queryAllSortedRating() async {
    Database? db = await _instance.db;
    return await db!.query(tablename, orderBy: '$columnfavrating DESC');
  }

  Future<List<Map<String, dynamic>>> queryAllSortedDate() async {
    Database? db = await _instance.db;
    return await db!.query(tablename, orderBy: '$columnId DESC');
  }

  Future close() async {
    Database? db = await _instance.db;
    db!.close();
  }
}
