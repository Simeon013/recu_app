import 'package:sqflite/sqflite.dart';
import '../database.dart';

class AppartementTable {
  static const String tableName = 'appartements';
  static const String colId = 'id';
  static const String colName = 'name';
  static const String colNbChambres = 'nb_chambres';
  static const String colPrix = 'prix';
  static const String colStatus = 'status';

  static const String createTableQuery = '''
    CREATE TABLE $tableName (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colName TEXT,
      $colNbChambres INTEGER,
      $colPrix REAL,
      $colStatus BOOLEAN
    )
  ''';

  int? id;
  String? name;
  int? nbChambres;
  double? prix;
  bool? status;

  AppartementTable({
    this.id,
    this.name,
    this.nbChambres,
    this.prix,
    this.status,
  });

  Map<String, dynamic> toJson() => {
    colId: id,
    colName: name,
    colNbChambres: nbChambres,
    colPrix: prix,
    colStatus: status == true ? 1 : 0,
  };

  factory AppartementTable.fromJson(Map<String, dynamic> json) =>
      AppartementTable(
        id: json[colId],
        nbChambres: json[colNbChambres],
        prix: json[colPrix],
        status: json[colStatus] == 1,
      );
}
