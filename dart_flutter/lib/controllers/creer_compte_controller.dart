import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../models/sqldb.dart';
import '../tools/constants/colors.dart';
import '../tools/constants/expression.dart';
import '../tools/functions/check_internet.dart';
import '../tools/functions/firebase_users.dart';
import '../tools/functions/get_email_password.dart';
import '../tools/functions/is_phone_number.dart';
import '../tools/functions/show_snackbar.dart';
import '../views/pages/home_page.dart';

class CreerCompteController extends GetxController {
  SqlDB sqlDB = SqlDB();
  bool loading = false;
  TextEditingController nomController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController smsCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController askCodeController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  String compagnePhone = etatPhoneNumberMNQU;

  setCompagneTel() {
    compagnePhone = getCompagneTel(phoneController.text);
    update();
  }

  creerCompte() async {
    if (nomController.text.trim().isEmpty) {
      showSnackBar('الاسم الشخصي ضروري', backgroundColor: red);
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
    if (askCodeController.text.trim().isEmpty) {
      showSnackBar('سؤال الأمان ضروري', backgroundColor: red);
      return;
    }
    if (answerController.text.trim().isEmpty) {
      showSnackBar('إجابة سؤال الأمان ضروري', backgroundColor: red);
      return;
    }
    loading = true;
    update();
    bool isConnected = await checkInternetConnectivity();
    if (!isConnected) {
      showSnackBar('الانترنت غير متوفرة لديكم', backgroundColor: red);
      loading = false;
      update();
      return;
    }
    Map mapEmailAndPassword =
        getEmailAndPassword(phoneController.text, passwordController.text);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mapEmailAndPassword[mapEmail],
        password: mapEmailAndPassword[mapPassword],
      );
      if (credential.user != null) {
        await addUserDataToUsersCollection(phoneController.text, {
          userCollectionNom: nomController.text,
          userCollectionPhone: phoneController.text,
          userCollectionPassword: passwordController.text,
          userCollectionScoolsCodes: [],
          userCollectionSecurityAsk: askCodeController.text,
          userCollectionSecurityAnswer: answerController.text,
          userCollectionDRC: false,
          userCollectionING: false,
          userCollectionToken:'',
          userCollectionTokenNotifications:[]
        });
        mySharedPreferences!.setString(sharedPreferencesID, '1');
        mySharedPreferences!
            .setString(sharedPreferencesPhone, phoneController.text);
        mySharedPreferences!
            .setString(sharedPreferencesPassword, passwordController.text);
        mySharedPreferences!
            .setString(sharedPreferencesAsk, askCodeController.text);
        mySharedPreferences!
            .setString(sharedPreferencesAnswer, answerController.text);
        showSnackBar('تم فتح الحساب بنجاح', backgroundColor: green);
        await sqlDB.deleteMyDatabase();
        Get.offAll(() => HomePage());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar('يجب تغيير الرقم السري', backgroundColor: red);
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(' لا يمكن انشاء الحساب، لأن الهاتف المدخل لديه حساب ',
            backgroundColor: red);
      }
    } catch (ex) {
      showSnackBar('حدث خطأ $ex', backgroundColor: red);
    }
    loading = false;
    update();
  }
}
