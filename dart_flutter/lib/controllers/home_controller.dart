import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:my_school_rim/tools/constants/expression.dart';

import '../main.dart';
import '../models/sqldb.dart';
import '../tools/constants/colors.dart';
import '../tools/functions/convert.dart';
import '../tools/functions/encryption.dart';
import '../tools/functions/show_qr_model_sheet.dart';
import '../tools/functions/show_snackbar.dart';

class HomeController extends GetxController {
  SqlDB sqlDB = SqlDB();
  bool loading = false;
  String status = '';
  String barCodeScannerRes = '';
  String ecoleCode = '';
  String ecoleName = '';
  String profiles = '';
  String telphone = '';

  int idEcole = 0;
  List<Map> mapEcoles = [];

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
        if (status != statusEcole) {
          showSnackBar('عفوا... الرمز الذي التقطتم لا يستعمل هنا',
              backgroundColor: red);
          barCodeScannerRes = '';
          loading = false;
          update();
          return;
        }
        telphone = myDecrypter(mapConverted[keyQRtel]);
        if (telphone !=
            mySharedPreferences!.getString(sharedPreferencesPhone)) {
          showSnackBar('عفوا... الكود الذي التقطتم ليس لكم',
              backgroundColor: red);
          barCodeScannerRes = '';
          loading = false;
          update();
          return;
        }
        ecoleCode = myDecrypter(mapConverted[keyQRecoleID]);
        Map<String, Object?> ecole = await getOneEcoleByCode(ecoleCode);
        if (ecole.isNotEmpty) {
          idEcole = ecole[sqlDB.champID] as int;
        }
        ecoleName = mapConverted[keyQRecolename];
        profiles = mapConverted[keyQRprofiles];
        await saveEcole();
      });
    } catch (e) {
      showSnackBar('حدث الخطأ التالي $e', backgroundColor: red);
      barCodeScannerRes = '';
      loading = false;
      update();
    }
  }

  actualiserEcole() {
    idEcole = 0;
    ecoleCode = '';
    ecoleName = '';
    profiles = '';
    loading = false;
  }

  saveEcole() async {
    loading = true;
    update();
    if (idEcole == 0) {
      await sqlDB.insert(sqlDB.tableEcoles, {
        sqlDB.champEcoCode: ecoleCode,
        sqlDB.champEcoName: ecoleName,
        sqlDB.champEcoYourProfile: profiles,
        sqlDB.champEcoYourTelephone: telphone,
      });
    } else {
      await sqlDB.update(
          sqlDB.tableEcoles,
          {
            sqlDB.champID: idEcole,
            sqlDB.champEcoCode: ecoleCode,
            sqlDB.champEcoName: ecoleName,
            sqlDB.champEcoYourProfile: profiles,
            sqlDB.champEcoYourTelephone: telphone,
          },
          " id = $idEcole");
    }
    actualiserEcole();
    await getAllEcoles();
    return true;
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

  getOneEcoleByTel(String tel) async {
    List<Map<String, Object?>> responses = await sqlDB.readOne(
        sqlDB.tableEcoles, '${sqlDB.champEcoYourTelephone} = \'$tel\'');
    Map<String, Object?> map = {};
    if (responses.isEmpty) {
      return map;
    }
    map = responses.first;
    return map;
  }

  getAllEcoles() async {
    loading = true;
    update();
    mapEcoles.clear();
    List<Map> map = await sqlDB.readAll(sqlDB.tableEcoles);
    mapEcoles.addAll(map);
    loading = false;
    update();
  }

  deleteBase() {
    sqlDB.deleteMyDatabase();
    showSnackBar("تم مسح قاعدة البيانات");
  }

  savemydata() async {
    ecoleCode = '4244';
    ecoleName = 'مجمع مدارس مدينة العلوم الحرة ';
    profiles = 'وكيل،مراقب عام،محاسب';
    telphone = '46345652';
    await saveEcole();
  }


  getToken(BuildContext context){
    showQRModelSheet(context, '${mySharedPreferences!.getString(sharedPreferencesPhone)}$myToken');
  }

  @override
  void onInit() async {    
  await getAllEcoles();
    super.onInit();
  }
}
