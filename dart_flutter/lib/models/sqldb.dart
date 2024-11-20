import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDB {

  //database
  final String dbName = "myschoolrim";

  //Version
  final int version = 1;

  //table
  final String tableEcoles = "ecoles";
  final String tableEudiant ="etudiant";
  
  //Champs

  //general
  final String champID = "id";
  final String champNoted = "noted";
  final String champQrted = "qrted";

  //ecole
  final String champEcoCode = "ecocode";
  final String champEcoName = "econame";
  final String champEcoYourProfile = "ecoprofiles";
  final String champEcoYourTelephone = "ecotelephone";

  //etudiant
  final String champEtuCode = "etucode";
 final String champEtuName = "etuname";
  final String champEtuClasse = "etuclasse";
  final String champEtuNume = "etunume";
  final String champEtuTel = "etutel";
   
  //listChamp

  //Ecole
  List get champsEcole =>
      [champEcoCode, champEcoName, champEcoYourProfile, champEcoYourTelephone];

  //TAF
  Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, '$dbName.db');
    Database mydb = await openDatabase(path,
        onCreate: _oncreate, onUpgrade: _onUpgrate, version: version);
    return mydb;
  }

  _oncreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute(createTable(tableEcoles, champsEcole));
    
    await batch.commit();

    print('========================= _oncreate');
  }

  _onUpgrate(Database db, int oldVersion, int newVersion) {
    print('========================= _onUpgrate');
  }

  String createTable(String table, List list) {
    String sql =
        "CREATE TABLE $table ('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT";
    for (var element in list) {
      sql = "$sql ,'$element' TEXT";
    }
    sql = "$sql)";
    return sql;
  }

  Future<List<Map<String, Object?>>> readAll(String table) async {
    try {
      Database? myDB = await db;
      List<Map<String, Object?>> responses = await myDB!.query(table);
      return responses;
    } catch (e) {
      print(e);
      return [];
    }
  }

  readOne(String table, String? where) async {
    Database? myDB = await db;
    List<Map<String, Object?>> responses =
        await myDB!.query(table, where: where);
    return responses;
  }

  insert(String table, Map<String, Object?> values) async {
    Database? myDB = await db;
    int responses = await myDB!.insert(table, values);
    return responses;
  }

  update(String table, Map<String, Object?> values, String? where) async {
    Database? myDB = await db;
    int responses = await myDB!.update(table, values, where: where);
    return responses;
  }

  delete(String table, String? where) async {
    Database? myDB = await db;
    int responses = await myDB!.delete(table, where: where);
    return responses;
  }

  deleteAll(String table) async {
    Database? myDB = await db;
    int responses = await myDB!.delete(table);
    return responses;
  }

  deleteMyDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, '$dbName.db');
    await deleteDatabase(path);
  }
}
