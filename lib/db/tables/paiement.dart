import 'appartement.dart';
import 'locataire.dart';

class PaiementTable {
  static const String tableName = 'paiements';
  static const String colId = 'id';
  static const String colLocataireId = 'locataire_id';
  static const String colAppartementId = 'appartement_id';
  static const String colDate = 'date';
  static const String colMontant = 'montant';

  static const String createTableQuery = '''
    CREATE TABLE $tableName (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colLocataireId INTEGER,
      $colAppartementId INTEGER,
      $colDate TEXT,
      $colMontant REAL,
      FOREIGN KEY ($colLocataireId) REFERENCES ${LocataireTable.tableName}(${LocataireTable.colId}),
      FOREIGN KEY ($colAppartementId) REFERENCES ${AppartementTable.tableName}(${AppartementTable.colId})
    )
  ''';

  int? id;
  int locataireId;
  int appartementId;
  String date;
  double montant;

  PaiementTable({
    this.id,
    required this.locataireId,
    required this.appartementId,
    required this.date,
    required this.montant,
  });

  Map<String, dynamic> toJson() {
    return {
      colId: id,
      colLocataireId: locataireId,
      colAppartementId: appartementId,
      colDate: date,
      colMontant: montant,
    };
  }

  factory PaiementTable.fromJson(Map<String, dynamic> json) {
    return PaiementTable(
      id: json[colId],
      locataireId: json[colLocataireId],
      appartementId: json[colAppartementId],
      date: json[colDate],
      montant: json[colMontant],
    );
  }
}
