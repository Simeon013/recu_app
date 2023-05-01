class LocataireTable {
  static const String tableName = 'locataires';
  static const String colId = 'id';
  static const String colNom = 'nom';
  static const String colPrenom = 'prenom';
  static const String colAdresse = 'adresse';
  static const String colTelephone = 'telephone';
  static const String colEmail = 'email';

  static const String createTableQuery = '''
    CREATE TABLE $tableName (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colNom TEXT,
      $colPrenom TEXT,
      $colAdresse TEXT,
      $colTelephone TEXT,
      $colEmail TEXT
    )
  ''';

  int? id;
  String nom;
  String prenom;
  String adresse;
  String telephone;
  String email;

  LocataireTable({
    this.id,
    required this.nom,
    required this.prenom,
    required this.adresse,
    required this.telephone,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      colId: id,
      colNom: nom,
      colPrenom: prenom,
      colAdresse: adresse,
      colTelephone: telephone,
      colEmail: email,
    };
  }

  factory LocataireTable.fromJson(Map<String, dynamic> json) {
    return LocataireTable(
      id: json[colId],
      nom: json[colNom],
      prenom: json[colPrenom],
      adresse: json[colAdresse],
      telephone: json[colTelephone],
      email: json[colEmail],
    );
  }
}
