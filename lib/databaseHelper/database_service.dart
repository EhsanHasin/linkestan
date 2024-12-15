import 'package:linkestan/databaseHelper/urgent_numbers_m.dart';
import 'package:linkestan/databaseHelper/visit_cards_m.dart';
import 'package:linkestan/databaseHelper/links_m.dart';
import 'database_helper.dart';

class DatabaseService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<LinkMap>> fetchLinks() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.getAllRows('Links');
    return maps.map((map) => LinkMap.fromMap(map)).toList();
  }

  Future<List<UrgentNumberMap>> fetchUrgentNumbers() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.getAllRows('UrgentNumbers');
    return maps.map((map) => UrgentNumberMap.fromMap(map)).toList();
  }

  Future<List<VisitCardMap>> fetchVisitCards() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.getAllRows('VisitCards');
    return maps.map((map) => VisitCardMap.fromMap(map)).toList();
  }

  Future<void> updateVisitCard(VisitCardMap visitCard) async {
    final db = await _dbHelper.database;
    await db.update('VisitCards', visitCard.toMap(), where: 'vc_id = ?', whereArgs: [visitCard.id]);
  }

  Future<void> updateLinks(LinkMap link) async {
    final db = await _dbHelper.database;
    await db.update('Links', link.toMap(), where: 'li_id = ?', whereArgs: [link.id]);
  }

  Future<void> updateUrgentNumbers(UrgentNumberMap urgent) async {
    final db = await _dbHelper.database;
    await db.update('UrgentNumbers', urgent.toMap(), where: 'un_id = ?', whereArgs: [urgent.id]);
  }

  Future<List<VisitCardMap>> getFavoriteVisitCards() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.getFavoriteCards();
    return maps.map((e) => VisitCardMap.fromMap(e)).toList();
  }

  Future<List<VisitCardMap>> getFavoriteLinks() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.getFavoriteLinks();
    return maps.map((e) => VisitCardMap.fromMap(e)).toList();
  }

  Future<List<VisitCardMap>> getFavoriteUrgentNumbers() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.getFavoriteUrgentNumbers();
    return maps.map((e) => VisitCardMap.fromMap(e)).toList();
  }
}
