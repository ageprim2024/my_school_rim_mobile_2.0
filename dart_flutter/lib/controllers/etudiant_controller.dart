import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../models/sqldb.dart';
import '../tools/constants/colors.dart';
import '../tools/constants/expression.dart';
import '../tools/functions/convert.dart';
import '../tools/functions/encryption.dart';
import '../tools/functions/show_snackbar.dart';

class EtudiantController extends GetxController {
  SqlDB sqlDB = SqlDB();
  bool loading = false;
  late String ecoleCode;
  String status = '';
  String etuCode = '';
  String etuName = '';
  String etuClasse = '';
  String etuNum = '';
  String etuTel = '';
  String barCodeScannerRes = '';
  List<Map> mapEtudiants = [];

  int idEtudiant = 0;

  Future<void> scannBarCode() async {
    loading = true;
    update();
    try {
      FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'إلغاء',
        true,
        ScanMode.QR,
      ).then((value) async {
        var mapConverted = {};
        try {
          mapConverted = convertStringToMqp(value);
          status = myDecrypter(mapConverted[keyQRstatus]);
        } catch (e) {
          showSnackBar('عفوا... يرجى إعادة المحاولة', backgroundColor: red);
          barCodeScannerRes = '';
          loading = false;
          update();
          return;
        }
        if (status != statusEtudiant) {
          showSnackBar('عفوا... الرمز الذي التقطتم لا يستعمل هنا',
              backgroundColor: red);
          barCodeScannerRes = '';
          loading = false;
          update();
          return;
        }
        Map<String, Object?> ecole =
            await getOneEcoleByCode(myDecrypter(mapConverted[keyQRecoleID]));
        if (ecole.isEmpty) {
          showSnackBar('عفوا... الكود الذي التقطتم لا يحق لكم التقاطه',
              backgroundColor: red);
          barCodeScannerRes = '';
          loading = false;
          update();
          return;
        }
        if (ecoleCode != myDecrypter(mapConverted[keyQRecoleID])) {
          showSnackBar('عفوا... يرجى التأكد من كود المدرسة',
              backgroundColor: red);
          barCodeScannerRes = '';
          loading = false;
          update();
          return;
        }
        int length = int.parse(mapConverted['end_']);
        for (var i = 1; i <= length; i++) {
          etuCode = mapConverted['cod_$i'];
          etuName = mapConverted['nam_$i'];
          etuClasse = mapConverted['cla_$i'];
          etuNum = mapConverted['num_$i'];
          etuTel = mapConverted['tel_$i'];
          idEtudiant = 0;
          Map<String, Object?> map =
              await getOneEudiantByEcoCodeEtuCode(ecoleCode, etuCode);
          if (map.isNotEmpty) {
            idEtudiant = map[sqlDB.champID] as int;
          }
          await saveEtudiant();
        }
        await getAllEtudiant();
        actualiserEtudiant();
        //showSnackBar('${mapEtudiants.length}');
      });
    } catch (e) {
      showSnackBar('حدث الخطأ التالي $e', backgroundColor: red);
      barCodeScannerRes = '';
      loading = false;
      update();
    }
  }

  getOneEcoleByCode(String codeEC) async {
    List<Map<String, Object?>> responses = await sqlDB.readOne(
        sqlDB.tableEcoles, '${sqlDB.champEcoCode} = \'$codeEC\'');
    Map<String, Object?> map = {};
    if (responses.isNotEmpty) {
      map = responses.first;
    }
    return map;
  }

  getOneEudiantByEcoCodeEtuCode(String codeEC, String codeET) async {
    List<Map<String, Object?>> responses = await sqlDB.readOne(
        sqlDB.tableEudiant,
        '${sqlDB.champEcoCode} = \'$codeEC\' and ${sqlDB.champEtuCode} = \'$codeET\'');
    Map<String, Object?> map = {};
    if (responses.isNotEmpty) {
      map = responses.first;
    }
    return map;
  }

  saveEtudiant() async {
    if (idEtudiant == 0) {
      await sqlDB.insert(sqlDB.tableEudiant, {
        sqlDB.champEcoCode: ecoleCode,
        sqlDB.champEtuCode: etuCode,
        sqlDB.champEtuName: etuName,
        sqlDB.champEtuClasse: etuClasse,
        sqlDB.champEtuNume: etuNum,
        sqlDB.champEtuTel: etuTel,
      });
    } else {
      await sqlDB.update(
          sqlDB.tableEudiant,
          {
            sqlDB.champID: idEtudiant,
            sqlDB.champEcoCode: ecoleCode,
            sqlDB.champEtuCode: etuCode,
            sqlDB.champEtuName: etuName,
            sqlDB.champEtuClasse: etuClasse,
            sqlDB.champEtuNume: etuNum,
            sqlDB.champEtuTel: etuTel,
          },
          " id = $idEtudiant");
    }
  }

  actualiserEtudiant() {
    idEtudiant = 0;
    etuCode = '';
    etuName = '';
    etuClasse = '';
    etuNum = '';
    etuTel = '';
    loading = false;
    update();
  }

  getAllEtudiant() async {
    loading = true;
    update();
    mapEtudiants.clear();
    List<Map> map = await sqlDB.readAll(sqlDB.tableEudiant);
    if (map.isNotEmpty) {
      for (var element in map) {
        if (element[sqlDB.champEcoCode] == ecoleCode) {
          mapEtudiants.add(element);
        }
      }
    }
    loading = false;
    update();
  }

  savemydata() async {
    etuCode = '1';
    etuName = 'سارة ابوبكر الغزالي ';
    etuClasse = '5C';
    etuNum = '001';
    await saveEtudiant();
    await getAllEtudiant();
  }

  @override
  void onInit() async {
    loading = true;
    update();
    Map map = Get.arguments;
    ecoleCode = map[keyQRecoleID];
    await getAllEtudiant();
    loading = false;
    update();
    super.onInit();
  }
}
