import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../tools/constants/colors.dart';
import '../tools/constants/expression.dart';
import '../tools/functions/check_internet.dart';
import '../tools/functions/firebase_schools.dart';
import '../tools/functions/firebase_users.dart';
import '../tools/functions/select_drop_down_list.dart';
import '../tools/functions/show_snackbar.dart';

class NotificationsController extends GetxController {
  TextEditingController codeEcole = TextEditingController();
  bool loading = true;
  bool isCheckedCRS = false;
  bool isCheckedENS = false;
  bool isCheckedPRT = false;
  bool isCheckedFNC = false;
  String fonction = '';
  String telephone = '';
  String token = '';
  String barCodeScannerRes = '';
  List listOfcodes = [];

  void changeValueCRS(bool value) {
    isCheckedCRS = value;
    update();
  }

  void changeValueENS(bool value) {
    isCheckedENS = value;
    update();
  }

  void changeValuePRT(bool value) {
    isCheckedPRT = value;
    update();
  }

  void changeValueFNC(bool value) {
    fonction = '';
    isCheckedFNC = value;
    update();
  }

  void selectDropDownListFonctions(BuildContext context) async {
    selectDropDown(
      context,
      label: 'الوظيفة',
      data: await listOfFonctions(),
      selectedItems: selecteItemsFonction,
    );
  }

  Future<List<SelectedListItem>> listOfFonctions() async {
    List<SelectedListItem> list = [];
    list.add(
      SelectedListItem(
        name: typeDRG,
      ),
    );
    list.add(
      SelectedListItem(
        name: typeDRL,
      ),
    );
    list.add(
      SelectedListItem(
        name: typeCNG,
      ),
    );
    list.add(
      SelectedListItem(
        name: typeCMP,
      ),
    );
    list.add(
      SelectedListItem(
        name: typePLT,
      ),
    );
    list.add(
      SelectedListItem(
        name: typeGRD,
      ),
    );
    list.add(
      SelectedListItem(
        name: typeATR,
      ),
    );
    return list;
  }

  selecteItemsFonction(List<dynamic> selectedList) async {
    List<String> list = [];
    for (var item in selectedList) {
      if (item is SelectedListItem) {
        list.add(item.name);
      }
    }
    fonction = list.first.trim();
    update();
  }

  void selectDropDownListCodesEcole(BuildContext context) {
    selectDropDown(context,
        label: 'أكواد المدرسة',
        data: listOfCodesEcoles(),
        selectedItems: selecteItemsCodesEcoles);
  }

  List<SelectedListItem> listOfCodesEcoles() {
    List<SelectedListItem> list = [];
    for (var element in listOfcodes) {
      if (element.isNotEmpty) {
        list.add(
          SelectedListItem(
            name: element,
          ),
        );
      }
    }
    return list;
  }

  selecteItemsCodesEcoles(List<dynamic> selectedList) {
    List<String> list = [];
    for (var item in selectedList) {
      if (item is SelectedListItem) {
        list.add(item.name);
      }
    }
    codeEcole.text = list.first;
  }

  Future<void> scannBarCode() async {
    if (codeEcole.text.isEmpty) {
      showSnackBar('يرجى تحديد كود المدرسة', backgroundColor: red);
      return;
    }
    if (!isCheckedENS && !isCheckedCRS && !isCheckedFNC && !isCheckedPRT) {
      showSnackBar('يرجى تحديد من يكون المعني', backgroundColor: red);
      return;
    }
    if (isCheckedFNC && fonction == '') {
      showSnackBar('يرجى تحديد وظيفة الموظف', backgroundColor: red);
      return;
    }
    loading = true;
    update();
    bool isConnected = await checkInternetConnectivity();
    if (!isConnected) {
      showSnackBar('الانترنت غير متوفرة لديكم', backgroundColor: red);
      barCodeScannerRes = '';
      loading = false;
      update();
      return;
    }
    Map<String, dynamic>? mapUsers = await getUserDataFromUsersCollection(
        mySharedPreferences!.getString(userCollectionPhone)!);
    if (mapUsers != null) {
      if (mapUsers[userCollectionDRC] == true) {
        try {
          FlutterBarcodeScanner.scanBarcode(
            '#ff6666',
            'إلغاء',
            true,
            ScanMode.QR,
          ).then((value) async {
            try {
              barCodeScannerRes = value;
              if (barCodeScannerRes == "-1") {
                showSnackBar('عفوا... يرجى إعادة المحاولة',
                    backgroundColor: red);
                barCodeScannerRes = '';
                loading = false;
                update();
                return;
              }
            } catch (e) {
              showSnackBar('عفوا... يرجى إعادة المحاولة', backgroundColor: red);
              barCodeScannerRes = '';
              loading = false;
              update();
              return;
            }
            telephone = barCodeScannerRes.substring(0, 8);
            token = barCodeScannerRes.substring(8);
            Map<String, dynamic>? mapSchool =
                await getSchoolDataFromSchoolsCollection(codeEcole.text);
            if (mapSchool != null) {
              if (isCheckedCRS) {
                List tokens = mapSchool[schoolCollectionTokensCRS];
                tokens.removeWhere((element) => element == telephone);
                tokens.add(telephone);
                mapSchool[schoolCollectionTokensCRS] = tokens;
              }
              if (isCheckedENS) {
                List tokens = mapSchool[schoolCollectionTokensENS];
                tokens.removeWhere((element) => element == telephone);
                tokens.add(telephone);
                mapSchool[schoolCollectionTokensENS] = tokens;
              }
              if (isCheckedPRT) {
                List tokens = mapSchool[schoolCollectionTokensPRT];
                tokens.removeWhere((element) => element == telephone);
                tokens.add(telephone);
                mapSchool[schoolCollectionTokensPRT] = tokens;
              }
              if (isCheckedFNC) {
                if (fonction == typeDRG) {
                  List tokens = mapSchool[schoolCollectionTokensDRG];
                  tokens.removeWhere((element) => element == telephone);
                  tokens.add(telephone);
                  mapSchool[schoolCollectionTokensDRG] = tokens;
                }
                if (fonction == typeDRL) {
                  List tokens = mapSchool[schoolCollectionTokensDRL];
                  tokens.removeWhere((element) => element == telephone);
                  tokens.add(telephone);
                  mapSchool[schoolCollectionTokensDRL] = tokens;
                }
                if (fonction == typeCNG) {
                  List tokens = mapSchool[schoolCollectionTokensCNG];
                  tokens.removeWhere((element) => element == telephone);
                  tokens.add(telephone);
                  mapSchool[schoolCollectionTokensCNG] = tokens;
                }
                if (fonction == typeCMP) {
                  List tokens = mapSchool[schoolCollectionTokensCMP];
                  tokens.removeWhere((element) => element == telephone);
                  tokens.add(telephone);
                  mapSchool[schoolCollectionTokensCMP] = tokens;
                }
                if (fonction == typePLT) {
                  List tokens = mapSchool[schoolCollectionTokensPLT];
                  tokens.removeWhere((element) => element == telephone);
                  tokens.add(telephone);
                  mapSchool[schoolCollectionTokensPLT] = tokens;
                }
                if (fonction == typeGRD) {
                  List tokens = mapSchool[schoolCollectionTokensGRD];
                  tokens.removeWhere((element) => element == telephone);
                  tokens.add(telephone);
                  mapSchool[schoolCollectionTokensGRD] = tokens;
                }
                if (fonction == typeATR) {
                  List tokens = mapSchool[schoolCollectionTokensATR];
                  tokens.removeWhere((element) => element == telephone);
                  tokens.add(telephone);
                  mapSchool[schoolCollectionTokensATR] = tokens;
                }
              }
              await updateSchoolDataToSchoolsCollection(codeEcole.text, mapSchool);
              Map<String, dynamic>? mapUser =
                  await getUserDataFromUsersCollection(telephone);
              if (mapUser != null) {
                mapUser[userCollectionToken] = token;
                await upDateUserDataFromUsersCollection(telephone, mapUser);
              }
            }
            loading = false;
            update();
          });
          //debugPrint(telephone);
        } catch (e) {
          showSnackBar('حدث الخطأ التالي $e', backgroundColor: red);
          barCodeScannerRes = '';
          loading = false;
          update();
        }
      } else {
        showSnackBar('عفوا... ينبغي إعطاؤكم حق السماح بإذن تلقي الاشعارات',
            backgroundColor: red);
        barCodeScannerRes = '';
        loading = false;
        mySharedPreferences!.setBool(sharedPreferencesDRC, false);
        update();
      }
    } else {
      showSnackBar('يرجى الاتصال بالمهندس', backgroundColor: red);
      barCodeScannerRes = '';
      loading = false;
      update();
    }
  }

  @override
  void onInit() async {
    Map<String, dynamic>? map = await getUserDataFromUsersCollection(
        '${mySharedPreferences!.getString(sharedPreferencesPhone)}');
    if (map != null) {
      listOfcodes = map[userCollectionScoolsCodes];
    }
    loading = false;
    update();
    super.onInit();
  }
}
