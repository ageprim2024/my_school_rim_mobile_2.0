import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../models/sqldb.dart';
import '../tools/constants/colors.dart';
import '../tools/constants/expression.dart';
import '../tools/functions/check_internet.dart';
import '../tools/functions/firebase_users.dart';
import '../tools/functions/is_phone_number.dart';
import '../tools/functions/show_dialog_confirm.dart';
import '../tools/functions/show_snackbar.dart';
import '../views/pages/creer_compte_page.dart';
import '../views/pages/home_page.dart';

class LoginController extends GetxController {
  SqlDB sqlDB = SqlDB();
  bool loading = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController askController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  String compagnePhone = etatPhoneNumberMNQU;
  bool avoirCompte = false;

  pasDeCompte() async {
    String? id = mySharedPreferences!.getString(sharedPreferencesID);
    if (id == '1') {
      showSnackBar('يوجد لديك بالفعل حساب على هذا الهاتف',
          backgroundColor: red);
      avoirCompte = true;
      update();
    } else {
      Get.to(() => CreerComptePage());
      avoirCompte = false;
      update();
    }
  }

  refleshirCompte() async {
    if (mySharedPreferences!.getString(sharedPreferencesID) == '1') {
      loading = true;
      update();
      bool isConnected = await checkInternetConnectivity();
      if (!isConnected) {
        showSnackBar('الانترنت غير متوفرة لديكم', backgroundColor: red);
        loading = false;
        update();
        return;
      }
      Map<String, dynamic>? map = await getUserDataFromUsersCollection(
          mySharedPreferences!.getString(sharedPreferencesPhone)!);
      mySharedPreferences!
          .setString(sharedPreferencesPassword, map?[userCollectionPassword]);
      mySharedPreferences!
          .setString(sharedPreferencesAsk, map?[userCollectionSecurityAsk]);
      mySharedPreferences!.setString(
          sharedPreferencesAnswer, map?[userCollectionSecurityAnswer]);
      mySharedPreferences!
          .setBool(sharedPreferencesDRC, map?[userCollectionDRC]);
      mySharedPreferences!
          .setBool(sharedPreferencesING, map?[userCollectionING]);
      List list = map?[userCollectionScoolsCodes];
      mySharedPreferences!.setString(sharedPreferencesMyCodes, list.toString());
      showSnackBar('تم تحديث الحساب', backgroundColor: green);
    }
    loading = false;
    update();
  }

  setCompagneTel() {
    compagnePhone = getCompagneTel(phoneController.text);
    update();
  }

  login() {
    if (mySharedPreferences!.getString(sharedPreferencesID) != '1') {
      showSnackBar(
          'لا يوجد حساب مفتوح على هذا الهاتف، يرجى انشاء حساب جديد أو فتح آخر موجود',
          backgroundColor: red);
      return;
    }
    if (phoneController.text.trim().isEmpty) {
      showSnackBar('رقم الهاتف ضروري', backgroundColor: red);
      return;
    }
    if (compagnePhone == etatPhoneNumberMNQU ||
        compagnePhone == etatPhoneNumberINCR) {
      showSnackBar('رقم الهاتف $compagnePhone', backgroundColor: red);
      return;
    }
    if (passwordController.text.trim().isEmpty) {
      showSnackBar('الرقم السري ضروري', backgroundColor: red);
      return;
    }
    if (passwordController.text.trim().length != 4) {
      showSnackBar('الرقم السري يجب أن يتكون من 4 أرقام', backgroundColor: red);
      return;
    }
    if (phoneController.text ==
            mySharedPreferences!.getString(sharedPreferencesPhone) &&
        passwordController.text ==
            mySharedPreferences!.getString(sharedPreferencesPassword)) {
      mySharedPreferences!.setBool(sharedPreferencesLogined, true);
      Get.offAll(() => HomePage());
    } else {
      showSnackBar('بيانات الدخول غير صحيحة', backgroundColor: red);
    }
  }

  getPassword() {
    String? id = mySharedPreferences!.getString(sharedPreferencesID);
    if (id != '1') {
      showSnackBar('لا يوجد لديك حساب على هذا الهاتف', backgroundColor: red);
      return;
    }
    answerController.clear();
    showDialogConfirmWithData(
      title: 'سؤال الأمان',
      controller: answerController,
      label: askController.text,
      onConfirm: () {
        if (answerController.text ==
            mySharedPreferences!.getString(sharedPreferencesAnswer)) {
          Get.back();
          showSnackBar(
              'الإجابة صحيحة ، الرمز السري هو ${mySharedPreferences!.getString(sharedPreferencesPassword)}',
              backgroundColor: green);
        } else {
          Get.back();
          showSnackBar('الإجابة غير صحيحة', backgroundColor: red);
        }
      },
    );
  }

  ouvrirCompte() {
    answerController.clear();
    showDialogConfirmWithData(
      title: ' رقم الهاتف',
      keyboardType: TextInputType.number,
      controller: answerController,
      label: 'ادخل هنا رقم الهاتف',
      onConfirm: () async {
        Get.back();
        loading = true;
        update();
        if (answerController.text.trim().isEmpty) {
          showSnackBar('ادخال الهاتف ضروري', backgroundColor: red);
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
        Map<String, dynamic>? map =
            await getUserDataFromUsersCollection(answerController.text);
        answerController.clear();
        if (map != null) {
          showDialogConfirmWithData(
              title: 'سؤال الأمان',
              controller: answerController,
              label: map[userCollectionSecurityAsk],
              onConfirm: () {
                Get.back();
                if (map[userCollectionSecurityAnswer].length > 0 &&
                    answerController.text ==
                        map[userCollectionSecurityAnswer]) {
                  phoneController.text = map[userCollectionPhone];
                  askController.text = map[userCollectionSecurityAsk];
                  mySharedPreferences!.setString(sharedPreferencesID, '1');
                  mySharedPreferences!.setString(
                      sharedPreferencesPhone, map[userCollectionPhone]);
                  mySharedPreferences!.setString(
                      sharedPreferencesPassword, map[userCollectionPassword]);
                  mySharedPreferences!.setString(
                      sharedPreferencesAsk, map[userCollectionSecurityAsk]);
                  mySharedPreferences!.setString(sharedPreferencesAnswer,
                      map[userCollectionSecurityAnswer]);
                  mySharedPreferences!
                      .setBool(sharedPreferencesDRC, map[userCollectionDRC]);
                  mySharedPreferences!
                      .setBool(sharedPreferencesING, map[userCollectionING]);
                  List list = map[userCollectionScoolsCodes];
                  mySharedPreferences!
                      .setString(sharedPreferencesMyCodes, list.toString());
                  showSnackBar('الإجابة صحيحة، تم اعتماد الحساب',
                      backgroundColor: green);
                  answerController.clear();
                  setCompagneTel();
                  sqlDB.deleteMyDatabase();
                } else {
                  showSnackBar('الإجابة غير صحيحة، لا يمكن فتح الحساب ',
                      backgroundColor: red);
                  answerController.clear();
                }
              });
        } else {
          showSnackBar('رقم الهاتف المدخل ليس لديه حساب', backgroundColor: red);
          answerController.clear();
        }
        loading = false;
        update();
      },
    );
  }

  fermerCompte() {
    if (askController.text.trim().isEmpty) {
      showSnackBar('لا يوجد لديك سؤال أمان', backgroundColor: red);
      return;
    }
    answerController.clear();
    showDialogConfirmWithData(
      title: 'سؤال الأمان',
      controller: answerController,
      label: askController.text,
      onConfirm: () {
        if (answerController.text ==
            mySharedPreferences!.getString(sharedPreferencesAnswer)) {
          mySharedPreferences!.clear();
          askController.clear();
          answerController.clear();
          phoneController.clear();
          passwordController.clear();
          avoirCompte = false;
          setCompagneTel();
          Get.back();
          showSnackBar('الإجابة صحيحة ، تم غلق الحساب على هذا الهاتف',
              backgroundColor: green);
          sqlDB.deleteMyDatabase();
        } else {
          Get.back();
          showSnackBar('الإجابة غير صحيحة', backgroundColor: red);
        }
      },
    );
  }

  void callLunchContact(String lunchContactNumber) async {
    String url = 'tel:$lunchContactNumber';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      showSnackBar(e.toString());
      print(e.toString());
    }
  }

  @override
  void onInit() {
    String? id = mySharedPreferences!.getString(sharedPreferencesID);
    if (id == '1') {
      phoneController.text =
          mySharedPreferences!.getString(sharedPreferencesPhone)!;
      avoirCompte = true;
      askController.text =
          mySharedPreferences!.getString(sharedPreferencesAsk)!;
      setCompagneTel();
    }
    super.onInit();
  }
}
