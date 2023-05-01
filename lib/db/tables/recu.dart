import 'locataire.dart';

class RecuTable {
  static const String tableName = 'recus';
  static const String colId = 'id';
  static const String colMontant = 'montant';
  static const String colDate = 'date';
  static const String colLocataireId = 'locataire_id';
  static const String colMois = 'mois';
  static const String colAnnee = 'annee';

  static const String createTableQuery = '''
    CREATE TABLE $tableName (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colMontant REAL,
      $colDate TEXT,
      $colLocataireId INTEGER,
      $colMois INTEGER,
      $colAnnee INTEGER,
      FOREIGN KEY ($colLocataireId) REFERENCES ${LocataireTable.tableName}(${LocataireTable.colId})
    )
  ''';

  int? id;
  double montant;
  DateTime date;
  int locataireId;
  int mois;
  int annee;

  RecuTable({
    this.id,
    required this.montant,
    required this.date,
    required this.locataireId,
    required this.mois,
    required this.annee,
  });

  Map<String, dynamic> toJson() {
    return {
      colId: id,
      colMontant: montant,
      colDate: date.toIso8601String(),
      colLocataireId: locataireId,
      colMois: mois,
      colAnnee: annee,
    };
  }

  factory RecuTable.fromJson(Map<String, dynamic> json) {
    return RecuTable(
      id: json[colId],
      montant: json[colMontant],
      date: DateTime.parse(json[colDate]),
      locataireId: json[colLocataireId],
      mois: json[colMois],
      annee: json[colAnnee],
    );
  }
}
