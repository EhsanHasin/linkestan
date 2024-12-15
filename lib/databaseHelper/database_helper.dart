import 'dart:io';
import 'package:flutter/services.dart';
import 'package:linkestan/databaseHelper/links_m.dart';
import 'package:linkestan/databaseHelper/urgent_numbers_m.dart';
import 'package:linkestan/databaseHelper/visit_cards_m.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, 'linkestan_database.db');

    // Copy database from assets if not exists
    if (!await File(path).exists()) {
      ByteData data = await rootBundle.load('assets/linkestan_database.db');
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }

    return openDatabase(
      path,
    );
  }

  // get data  --------------------------------------------------------
  Future<List<Map<String, dynamic>>> getAllRows(String tableName) async {
    final db = await database;
    return await db.query(tableName);
  }

  // favorites  --------------------------------------------------------
  Future<List<Map<String, dynamic>>> getFavoriteCards() async {
    final db = await database;
    final result = await db.query('VisitCards', where: 'vc_favorite = ?', whereArgs: [1]);
    return result;
  }

  Future<List<Map<String, dynamic>>> getFavoriteLinks() async {
    final db = await database;
    final result = await db.query('Links', where: 'li_favorite = ?', whereArgs: [1]);
    return result;
  }

  Future<List<Map<String, dynamic>>> getFavoriteUrgentNumbers() async {
    final db = await database;
    final result = await db.query('UrgentNumbers', where: 'un_favorite = ?', whereArgs: [1]);
    return result;
  }

  // Insert row into a table  ----------------------------------------
  Future<int> insertIntoVisitCards(VisitCardMap card) async {
    final db = await database;
    return await db.insert('VisitCards', card.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  Future<int> insertIntoLinks(LinkMap link) async {
    final db = await database;
    return await db.insert('Links', link.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  Future<int> insertIntoUrgentNumbers(UrgentNumberMap urgent) async {
    final db = await database;
    return await db.insert('UrgentNumbers', urgent.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  // Delete  -------------------------------------------
  Future<int> deleteVisitCards(VisitCardMap card) async {
    var db = await database;
    int result = await db.rawDelete(
        'DELETE FROM VisitCards WHERE vc_id = ${card.id}');
    return result;
  }

  Future<int> deleteLinks(LinkMap link) async {
    var db = await database;
    int result = await db.rawDelete(
        'DELETE FROM Links WHERE li_id = ${link.id}');
    return result;
  }

  Future<int> deleteUrgentNumber(UrgentNumberMap urgent) async {
    var db = await database;
    int result = await db.rawDelete(
        'DELETE FROM UrgentNumbers WHERE un_id = ${urgent.id}');
    return result;
  }
}
