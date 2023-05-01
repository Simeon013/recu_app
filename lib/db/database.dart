import 'package:recu_app/db/tables/appartement.dart';
import 'package:recu_app/db/tables/locataire.dart';
import 'package:recu_app/db/tables/paiement.dart';
import 'package:recu_app/db/tables/recu.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(AppartementTable.createTableQuery);
        await db.execute(LocataireTable.createTableQuery);
        await db.execute(PaiementTable.createTableQuery);
        await db.execute(RecuTable.createTableQuery);
      },
    );
  }
}
