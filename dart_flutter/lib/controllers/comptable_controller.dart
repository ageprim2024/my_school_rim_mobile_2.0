import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../tools/classes/my_notification.dart';
import '../tools/constants/colors.dart';
import '../tools/constants/expression.dart';
import '../tools/functions/check_internet.dart';
import '../tools/functions/convert.dart';
import '../tools/functions/encryption.dart';
import '../tools/functions/firebase_users.dart';
import '../tools/functions/get_title_notification.dart';
import '../tools/functions/get_tokens.dart';
import '../tools/functions/show_snackbar.dart';

class ComptableController extends GetxController {
  bool loading = false;
  String ecoleName = '';
  String ecoleCode = '';
  String ecoleID = '';
  String profile = '';
  String status = '';
  String barCodeScannerRes = '';
  String telCorres = '';
  String montant = '';
  String message = '';

  Future<void> scannBarCodePay() async {
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
          ecoleID = '';
          loading = false;
          update();
          return;
        }
        if (status != statusNotifyPay) {
          showSnackBar('عفوا... الرمز الذي التقطتم لا يستعمل هنا',
              backgroundColor: red);
          barCodeScannerRes = '';
          ecoleID = '';
          loading = false;
          update();
          return;
        }
        ecoleID = myDecrypter(mapConverted[keyQRecoleID]);
        if (ecoleCode != ecoleID) {
          showSnackBar('عفوا... يرجى التأكد من كود المدرسة',
              backgroundColor: red);
          barCodeScannerRes = '';
          ecoleID = '';
          loading = false;
          update();
          return;
        }
        message = mapConverted[keyQRmessage];
        telCorres = myDecrypter(mapConverted[keyQRtel]);
        await sendNotifyPay(telCorres, message);
        loading = false;
        update();
      });
      //debugPrint(barCodeScannerRes);
    } catch (e) {
      showSnackBar('حدث الخطأ التالي $e', backgroundColor: red);
      barCodeScannerRes = '';
      ecoleID = '';
      loading = false;
      update();
    }
  }

  Future<void> scannBarCodeDette() async {
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
          ecoleID = '';
          loading = false;
          update();
          return;
        }
        if (status != statusNotifyDette) {
          showSnackBar('عفوا... الرمز الذي التقطتم لا يستعمل هنا',
              backgroundColor: red);
          barCodeScannerRes = '';
          ecoleID = '';
          loading = false;
          update();
          return;
        }
        ecoleID = myDecrypter(mapConverted[keyQRecoleID]);
        if (ecoleCode != ecoleID) {
          showSnackBar('عفوا... يرجى التأكد من كود المدرسة',
              backgroundColor: red);
          barCodeScannerRes = '';
          ecoleID = '';
          loading = false;
          update();
          return;
        }
        bool isConnected = await checkInternetConnectivity();
        if (!isConnected) {
          showSnackBar('الانترنت غير متوفرة لديكم', backgroundColor: red);
          loading = false;
          update();
          return;
        }
        int end = int.parse(mapConverted['end_']);
        showSnackBar('end $end');
        message = mapConverted[keyQRmessage];
        for (var i = 1; i <= end; i++) {
          telCorres = mapConverted['tel_$i'];
          montant = mapConverted['mnt_$i'];
          await sendNotifyDette(telCorres, '$message : $montant أوقية.\n للاطلاع أكثر يمكنكم التواصل مع المدرسة.');
        }
        loading = false;
        update();
      });
      //debugPrint(barCodeScannerRes);
    } catch (e) {
      showSnackBar('حدث الخطأ التالي $e', backgroundColor: red);
      barCodeScannerRes = '';
      ecoleID = '';
      loading = false;
      update();
    }
  }

  sendNotifyPay(String telCorres, String message) async {
    bool isConnected = await checkInternetConnectivity();
    if (!isConnected) {
      showSnackBar('الانترنت غير متوفرة لديكم', backgroundColor: red);
      loading = false;
      update();
      return;
    }
    String deviceToken = await getOneTokens(ecoleCode, [typeCRS], telCorres);
    if (deviceToken == '') {
      showSnackBar('غير ممكن...، يرجى السماح للمعني بتلقي اشعارات المدرسة',
          backgroundColor: red);
      loading = false;
      update();
      return;
    }
    String title = await getTitle(ecoleCode);
    String body = message;
    Map data = {
      notificationStatusKey: typeCRS,
      sqlDB.champEcoCode: ecoleCode,
      sqlDB.champEtuName: message,
    };
    String resultat = "", sended = "";
    resultat =
        await MyNotificationService.sendNotification(deviceToken, title, body);
    if (resultat == 'OK') {
      sended = "OK";
    }
    if (sended == 'OK') {
      Map mapuser = await getUserDataFromUsersCollection(telCorres);
      if (mapuser.isNotEmpty) {
        List newnotifications = [];
        newnotifications.add(data);
        mapuser[userCollectionTokenNotifications] = newnotifications;
        await upDateUserDataFromUsersCollection(telCorres, mapuser);
        showSnackBar('تم إشعار المعني', backgroundColor: green);
      }
    } else if (resultat == 'NOK') {
      showSnackBar(
          'لم تتم العملية، ربما نظرا لأن المرسل إليه قد قام بتغيير هاتفه أو أعاد تثبيت التطبيق',
          backgroundColor: red);
      loading = false;
      update();
    } else {
      showSnackBar(
          'لم تتم العملية، يرجى إعادة المحاولة، حدث الخطأ الأتي$resultat',
          backgroundColor: red);
      loading = false;
      update();
    }
  }

  sendNotifyDette(String telCorres, String message) async {
    String deviceToken = await getOneTokens(ecoleCode, [typeCRS], telCorres);
    if (deviceToken != '') {
      String title = await getTitle(ecoleCode);
      String body = message;
      Map data = {
        notificationStatusKey: typeCRS,
        sqlDB.champEcoCode: ecoleCode,
        sqlDB.champEtuName: message,
      };
      String resultat = "", sended = "";
      resultat = await MyNotificationService.sendNotification(
          deviceToken, title, body);
      if (resultat == 'OK') {
        sended = "OK";
      }
      if (sended == 'OK') {
        Map mapuser = await getUserDataFromUsersCollection(telCorres);
        if (mapuser.isNotEmpty) {
          List newnotifications = [];
          newnotifications.add(data);
          mapuser[userCollectionTokenNotifications] = newnotifications;
          await upDateUserDataFromUsersCollection(telCorres, mapuser);
        }
      }
    }
  }

  @override
  void onInit() async {
    Map map = Get.arguments;
    ecoleName = map[keyQRecolename];
    ecoleCode = map[keyQRecoleID];
    profile = map[keyQRprofile];
    //await getListProfiles();
    super.onInit();
  }
}
