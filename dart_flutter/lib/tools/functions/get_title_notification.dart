import '../../models/sqldb.dart';

SqlDB sqlDB = SqlDB();

Future<String> getTitle(String ecoleCode) async {
  List<Map<String, Object?>> responses = await sqlDB.readOne(
      sqlDB.tableEcoles, '${sqlDB.champEcoCode} = \'$ecoleCode\'');
  Map<String, Object?> map = {};
  if (responses.isNotEmpty) {
    map = responses.first;
    return map[sqlDB.champEcoName] as String;
  }
  return '';
}

getOneEcoleByCode(String codeEC) async {}
