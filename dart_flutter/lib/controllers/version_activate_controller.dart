import 'dart:convert';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../tools/constants/colors.dart';
import '../tools/constants/expression.dart';
import '../tools/functions/check_internet.dart';
import '../tools/functions/convert.dart';
import '../tools/functions/encryption.dart';
import '../tools/functions/firebase_propre.dart';
import '../tools/functions/firebase_schools.dart';
import '../tools/functions/firebase_users.dart';
import '../tools/functions/show_snackbar.dart';

class VersionActivateController extends GetxController {
  bool loading = false;
  String barCodeScannerRes = '';
  String ecoleID = '';
  String machineID = '';
  String status = '';
  Future<void> scannBarCode() async {
    loading = true;
    update();
    bool isConnected = await checkInternetConnectivity();
    if (!isConnected) {
      showSnackBar('الانترنت غير متوفرة لديكم', backgroundColor: red);
      barCodeScannerRes = '';
      ecoleID = '';
      loading = false;
      update();
      return;
    }
    Map<String, dynamic>? mapUsers = await getUserDataFromUsersCollection(
        mySharedPreferences!.getString(userCollectionPhone)!);
    if (mapUsers != null) {
      if (mapUsers[userCollectionDRC] == true) {
        Map<String, dynamic>? mapToken =
            await getProbreDataFromPropreCollection();
        if (mapToken == null) {
          showSnackBar('يرجى إعادة المحاولة', backgroundColor: red);
          barCodeScannerRes = '';
          ecoleID = '';
          loading = false;
          update();
          return;
        }
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
              ecoleID = '';
              loading = false;
              update();
              return;
            }
            if (status != statusActivation) {
              showSnackBar('عفوا... الرمز الذي التقطتم لا يستعمل هنا',
                  backgroundColor: red);
              barCodeScannerRes = '';
              ecoleID = '';
              loading = false;
              update();
              return;
            }
            ecoleID = myDecrypter(mapConverted[keyQRecoleID]);
            machineID = myDecrypter(mapConverted[keyQRmachineID]);
            bool isExist = false;
            List mapCodes = mapUsers[userCollectionScoolsCodes];
            for (var i = 0; i < mapCodes.length; i++) {
              if (mapCodes[i] == ecoleID) {
                isExist = true;
                i = mapCodes.length;
              }
            }
            if (!isExist) {
              showSnackBar('عفوا... يرجى التأكد من كود المدرسة الذي ادحلتم',
                  backgroundColor: red);
              barCodeScannerRes = '';
              ecoleID = '';
              loading = false;
              update();
              return;
            }
            Map<String, dynamic>? mapSchool =
                await getSchoolDataFromSchoolsCollection(ecoleID);
            if (mapSchool != null) {
              if (mapSchool[schoolCollectionPossibleT] != true) {
                showSnackBar('عفوا... غير مسموح لكم بتفعيل النسخة',
                    backgroundColor: red);
                barCodeScannerRes = '';
                ecoleID = '';
                loading = false;
                update();
                return;
              }
              DateTime now = DateTime.now();
              DateTime nowPlus5 = DateTime(
                now.year,
                now.month,
                now.day,
                now.hour,
                now.minute + 5,
                now.second,
                0,
                0,
              );
              String startDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(now);
              String endDate =
                  DateFormat('dd-MM-yyyy HH:mm:ss').format(nowPlus5);
              mapConverted.putIfAbsent(
                  keyQRstart, () => myEecrypter(startDate));
              mapConverted.putIfAbsent(keyQRend, () => myEecrypter(endDate));
              mapConverted.putIfAbsent(
                  keyQRvalidate,
                  () =>
                      myEecrypter('${mapSchool[schoolCollectionTokenValid]}'));
              barCodeScannerRes = jsonEncode(mapConverted);
              List machines = mapSchool[schoolCollectionMachines];
              List times = mapSchool[schoolCollectionTimesRefresh];
              machines.removeWhere((element) => element==machineID);
              machines.add(machineID);
              times.add(now);
              mapSchool[schoolCollectionMachines]=machines;
              mapSchool[schoolCollectionTimesRefresh] = times;
              await updateSchoolDataToSchoolsCollection(
                  ecoleID, mapSchool);
              loading = false;  
              update();
            } else {
              showSnackBar('يرجى إعادة المحاولة أو الاتصال بالمهندس',
                  backgroundColor: red);
              barCodeScannerRes = '';
              ecoleID = '';
              loading = false;
              update();
            }
          });
          //debugPrint(barCodeScannerRes);
        } catch (e) {
          showSnackBar('حدث الخطأ التالي $e', backgroundColor: red);
          barCodeScannerRes = '';
          ecoleID = '';
          loading = false;
          update();
        }
      } else {
        showSnackBar('عفوا... ينبغي إعطاؤكم حق امتلاك نسخة',
            backgroundColor: red);
        barCodeScannerRes = '';
        ecoleID = '';
        loading = false;
        update();
      }
    } else {
      showSnackBar('يرجى الاتصال بالمهندس', backgroundColor: red);
      barCodeScannerRes = '';
      ecoleID = '';
      loading = false;
      update();
    }
  }
}
