
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

class VersionInstallController extends GetxController{
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
      machineID = '';
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
          machineID = '';
          loading = false;
          update();
          return;
        }
        String token = mapToken[propreCollectionToken];
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
              showSnackBar('عفوا... يرجى إعادة المحاولة',
                  backgroundColor: red);
              barCodeScannerRes = '';
              ecoleID = '';
              machineID = '';
              loading = false;
              update();
              return;
            }
            if (status != statusInstallation) {
              showSnackBar('عفوا... الرمز الذي التقطتم لا يستعمل هنا',
                  backgroundColor: red);
              barCodeScannerRes = '';
              ecoleID = '';
              token = '';
              loading = false;
              update();
              return;
            }
            ecoleID = myDecrypter(mapConverted[keyQRecoleID]);
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
              machineID = '';
              loading = false;
              update();
              return;
            }
            Map<String, dynamic>? mapSchool =
                await getSchoolDataFromSchoolsCollection(ecoleID);
            if (mapSchool != null) {
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
              String username = mapUsers[userCollectionPhone];
              String fullname = mapUsers[userCollectionNom];
              String ecoleName = mapSchool[schoolCollectionNomEcole];
              String startDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(now);
              String endDate =
                  DateFormat('dd-MM-yyyy HH:mm:ss').format(nowPlus5);
              machineID = myDecrypter(mapConverted[keyQRmachineID]);
              mapConverted.putIfAbsent(keyQRstart, () => myEecrypter(startDate));
              mapConverted.putIfAbsent(keyQRend, () => myEecrypter(endDate));
              mapConverted.putIfAbsent(keyQRtoken, () => token);
              mapConverted.putIfAbsent(keyQRusername, () => myEecrypter(username));
              mapConverted.putIfAbsent(keyQRfullname, () => fullname);
              mapConverted.putIfAbsent(keyQRecolename, () => ecoleName);
              barCodeScannerRes = jsonEncode(mapConverted);
              loading = false;
              update();
            } else {
              showSnackBar('يرجى إعادة المحاولة', backgroundColor: red);
              barCodeScannerRes = '';
              ecoleID = '';
              machineID = '';
              loading = false;
              update();
            }
          });
          //debugPrint(barCodeScannerRes);
        } catch (e) {
          showSnackBar('حدث الخطأ التالي $e', backgroundColor: red);
          barCodeScannerRes = '';
          ecoleID = '';
          machineID = '';
          loading = false;
          update();
        }
      } else {
        showSnackBar('عفوا... ينبغي إعطاؤكم حق امتلاك نسخة',
            backgroundColor: red);
        barCodeScannerRes = '';
        ecoleID = '';
        machineID = '';
        loading = false;
        mySharedPreferences!.setBool(sharedPreferencesDRC, false);
        update();
      }
    } else {
      showSnackBar('يرجى الاتصال بالمهندس', backgroundColor: red);
      barCodeScannerRes = '';
      ecoleID = '';
      machineID = '';
      loading = false;
      update();
    }
  }

  
}