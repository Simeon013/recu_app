import 'package:recu_app/db/database.dart';
import 'package:recu_app/db/tables/appartement.dart';
import 'package:recu_app/db/tables/locataire.dart';

class DBFunctions {
  static Future<int> createAppartement(AppartementTable appartement) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert(AppartementTable.tableName, appartement.toJson());
  }

  static Future<AppartementTable> readAppartement(int appartementId) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      AppartementTable.tableName,
      where: '${AppartementTable.colId} = ?',
      whereArgs: [appartementId],
    );
    if (maps.isNotEmpty) {
      return AppartementTable.fromJson(maps.first);
    } else {
      throw Exception('Appartement $appartementId not found');
    }
  }

  static Future<List<AppartementTable>> readAllAppartements() async {
    final db = await DatabaseHelper.instance.database;
    final orderBy = '${AppartementTable.colId} ASC';
    final result = await db.query(AppartementTable.tableName, orderBy: orderBy);
    return result.map((json) => AppartementTable.fromJson(json)).toList();
  }

  static Future<int> updateAppartement(AppartementTable appartement) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      AppartementTable.tableName,
      appartement.toJson(),
      where: '${AppartementTable.colId} = ?',
      whereArgs: [appartement.id],
    );
  }

  static Future<int> deleteAppartement(int appartementId) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      AppartementTable.tableName,
      where: '${AppartementTable.colId} = ?',
      whereArgs: [appartementId],
    );
  }



  static Future<int> createLocataire(LocataireTable locataire) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert(LocataireTable.tableName, locataire.toJson());
  }

  static Future<LocataireTable> readLocataire(int locataireId) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      LocataireTable.tableName,
      where: '${LocataireTable.colId} = ?',
      whereArgs: [locataireId],
    );
    if (maps.isNotEmpty) {
      return LocataireTable.fromJson(maps.first);
    } else {
      throw Exception('Locataire $locataireId not found');
    }
  }

  static Future<List<LocataireTable>> readAllLocataires() async {
    final db = await DatabaseHelper.instance.database;
    final orderBy = '${LocataireTable.colNom} ASC';
    final result = await db.query(LocataireTable.tableName, orderBy: orderBy);
    return result.map((json) => LocataireTable.fromJson(json)).toList();
  }

  static Future<int> updateLocataire(LocataireTable locataire) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      LocataireTable.tableName,
      locataire.toJson(),
      where: '${LocataireTable.colId} = ?',
      whereArgs: [locataire.id],
    );
  }

  static Future<int> deleteLocataire(int locataireId) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      LocataireTable.tableName,
      where: '${LocataireTable.colId} = ?',
      whereArgs: [locataireId],
    );
  }
}
