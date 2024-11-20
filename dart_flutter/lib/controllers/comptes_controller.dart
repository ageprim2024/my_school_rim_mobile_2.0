import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../tools/constants/colors.dart';
import '../tools/constants/expression.dart';
import '../tools/functions/check_internet.dart';
import '../tools/functions/convert.dart';
import '../tools/functions/convrtSconds.dart';
import '../tools/functions/firebase_schools.dart';
import '../tools/functions/firebase_users.dart';
import '../tools/functions/getPeriodeValue.dart';
import '../tools/functions/is_double_value.dart';
import '../tools/functions/random.dart';
import '../tools/functions/select_drop_down_list.dart';
import '../tools/functions/show_dialog_confirm.dart';
import '../tools/functions/show_snackbar.dart';
import '../views/widgets/my_text.dart';

class ComptesController extends GetxController {
  TextEditingController nomEcole = TextEditingController();
  TextEditingController codeEcole = TextEditingController();
  TextEditingController periodeName = TextEditingController();
  TextEditingController periodeNumber = TextEditingController();
  bool loading = false;
  List<Map> mapCours = [];
  List listOfcodes = [];

  getAllUsers() async {
    loading = true;
    mapCours = [{}];
    update();
    bool isConnected = await checkInternetConnectivity();
    if (!isConnected) {
      showSnackBar('الانترنت غير متوفرة لديكم', backgroundColor: red);
      loading = false;
      update();
      return;
    }
    QuerySnapshot snapshot = await getAllUsersFromCollectionUsers();
    List<Map<String, dynamic>> list = await convertSnapshotToList(snapshot);
    mapCours.addAll(list);
    loading = false;
    update();
  }

  activerDesactiverDRC(String phone) async {
    loading = true;
    update();
    bool isConnected = await checkInternetConnectivity();
    if (!isConnected) {
      showSnackBar('الانترنت غير متوفرة لديكم', backgroundColor: red);
      loading = false;
      update();
      return;
    }
    if (phone.isNotEmpty) {
      Map<String, dynamic>? map = await getUserDataFromUsersCollection(phone);
      if (map != null) {
        String msg;
        if (map[userCollectionDRC] == true) {
          map[userCollectionDRC] = false;
          msg = 'تعطيل';
        } else {
          map[userCollectionDRC] = true;
          msg = 'تفعيل';
        }
        await upDateUserDataFromUsersCollection(phone, map);
        showSnackBar('تم $msg إدارة المدرسة', backgroundColor: green);
        getAllUsers();
      } else {
        showSnackBar('لم تتم العملية بشكل صحيح', backgroundColor: red);
      }
    }
    loading = false;
    update();
  }

  generateSchoolCode(String phone) async {
    loading = true;
    update();
    bool isConnected = await checkInternetConnectivity();
    if (!isConnected) {
      showSnackBar('الانترنت غير متوفرة لديكم', backgroundColor: red);
      loading = false;
      update();
      return;
    }
    if (phone.isNotEmpty) {
      Map<String, dynamic>? map = await getUserDataFromUsersCollection(phone);
      if (map != null && map[userCollectionDRC] == false) {
        showSnackBar('يجب تفعيل حق امتلاك نسخة', backgroundColor: red);
        loading = false;
        update();
        return;
      }
      showDialogConfirm(
        data: 'هل تريد حقا إنشاء كود مدرسي جديد لصالح هذا الحساب؟',
        onConfirm: () {
          Get.back();
          showDialogConfirmWithData(
            label: 'اسم المدرسة',
            controller: nomEcole,
            onConfirm: () async {
              Get.back();
              if (map != null) {
                String code = await getRandom();
                List myMap = map[userCollectionScoolsCodes];
                myMap.add(code);
                map[userCollectionScoolsCodes] = myMap;
                await addSchoolDataToSchoolsCollection(code, {
                  schoolCollectionPhone: phone,
                  schoolCollectionNomEcole: nomEcole.text,
                  schoolCollectionMachines: [],
                  schoolCollectionPossibleM: false,
                  schoolCollectionPossibleT: false,
                  schoolCollectionTokenValid: 0.0,
                  schoolCollectionTimesRefresh: [
                    DateTime.now(),
                  ],
                  schoolCollectionTokensATR: [],
                  schoolCollectionTokensCMP: [],
                  schoolCollectionTokensCNG: [],
                  schoolCollectionTokensCRS: [],
                  schoolCollectionTokensDRG: [],
                  schoolCollectionTokensDRL: [],
                  schoolCollectionTokensENS: [],
                  schoolCollectionTokensGRD: [],
                  schoolCollectionTokensPLT: [],
                  schoolCollectionTokensPRT: [],
                });
                map[userCollectionDRC] = true;
                await upDateUserDataFromUsersCollection(phone, map);
                showSnackBar('تم أنشاء كود مدرسي تحت الرقم $code',
                    backgroundColor: green);
              } else {
                showSnackBar('لم تتم العملية بشكل صحيح', backgroundColor: red);
              }
            },
          );
        },
      );
    }
    loading = false;
    update();
  }

  generateExprationToken(String phone, BuildContext context) async {
    loading = true;
    update();
    codeEcole.clear();
    periodeName.clear();
    periodeNumber.clear();
    bool isConnected = await checkInternetConnectivity();
    if (!isConnected) {
      showSnackBar('الانترنت غير متوفرة لديكم', backgroundColor: red);
      loading = false;
      update();
      return;
    }
    if (phone.isNotEmpty) {
      Map<String, dynamic>? map = await getUserDataFromUsersCollection(phone);
      if (map != null) {
        listOfcodes = map[userCollectionScoolsCodes];
        if (listOfcodes.isNotEmpty) {
          showDialogConfirmWithExpirationToken(
            title: 'تحديد فترة صلاحية التوكن',
            labelTextCode: 'كود المدرسة',
            labelTextPeriodeName: 'الفترة',
            labelTextPeriodeNumber: 'العدد',
            controllerCode: codeEcole,
            controllerPerideName: periodeName,
            controllerPerideNumber: periodeNumber,
            onShowDropDownCode: () {
              selectDropDownListCodesEcole(context);
            },
            onShowDropDownPeriode: () { 
              selectDropDownListPeriodeNames(context);
            },
            onConfirm: () async {
              if (codeEcole.text.isEmpty ||
                  periodeName.text.isEmpty ||
                  periodeNumber.text.isEmpty) {
                showSnackBar('جميع الحقول مطلوبة', backgroundColor: red);
                return;
              }
              if (!isDoubleValue(periodeNumber.text)) {
                showSnackBar('العدد المدخل غير صحيح', backgroundColor: red);
                return;
              }
              Get.back();
              loading = true;
              update();
              Map<String, dynamic>? mapSchool =
                  await getSchoolDataFromSchoolsCollection(codeEcole.text);
              if (mapSchool != null) {
                double peride = getPeriodeValue(periodeName.text);
                double number = double.parse(periodeNumber.text);
                number = number * peride;
                mapSchool[schoolCollectionTokenValid] = number;
                await updateSchoolDataToSchoolsCollection(
                    codeEcole.text, mapSchool);
                showSnackBar('تم تحديد فترة صلاحية النسخة',
                    backgroundColor: green);
                loading = false;
                update();
              } else {
                showSnackBar('يرجى إعادة المحاوبة', backgroundColor: red);
                loading = false;
                update();
              }
            },
          );
        } else {
          showSnackBar('ليس لدىه كود مدرسي', backgroundColor: red);
        }
      } else {
        showSnackBar('لم تتم العملية بشكل صحيح', backgroundColor: red);
      }
    }
    loading = false;
    update();
  }

  activerDesactiverTKN(String phone, BuildContext context) async {
    loading = true;
    update();
    bool isConnected = await checkInternetConnectivity();
    if (!isConnected) {
      showSnackBar('الانترنت غير متوفرة لديكم', backgroundColor: red);
      loading = false;
      update();
      return;
    }
    if (phone.isNotEmpty) {
      Map<String, dynamic>? map = await getUserDataFromUsersCollection(phone);
      if (map != null) {
        listOfcodes = map[userCollectionScoolsCodes];
        showDialogConfirmWithActiveDesactiveTKNandMCN(
          labelTextCode: 'كود المدرسة',
          controllerCode: codeEcole,
          onShowDropDownCode: () {
            selectDropDownListCodesEcole(context);
          },
          onConfirm: () async {
            if (codeEcole.text.isEmpty) {
              showSnackBar('اختيار الكود أمر ضروري', backgroundColor: red);
              return;
            }
            Get.back();
            loading = true;
            update();
            Map<String, dynamic>? mapSchool =
                await getSchoolDataFromSchoolsCollection(codeEcole.text);
            if (mapSchool != null) {
              String msg;
              if (mapSchool[schoolCollectionPossibleT] == true) {
                mapSchool[schoolCollectionPossibleT] = false;
                msg = 'تعطيل';
              } else {
                mapSchool[schoolCollectionPossibleT] = true;
                msg = 'تفعيل';
              }
              await updateSchoolDataToSchoolsCollection(
                  codeEcole.text, mapSchool);
              showSnackBar('تم $msg السماح بتفعيل النسخة',
                  backgroundColor: green);
              getAllUsers();
            } else {
              showSnackBar('يرجى إعادة المحاوبة أو الاتصال بالمهندس',
                  backgroundColor: red);
              loading = false;
              update();
            }
          },
        );
      } else {
        showSnackBar('لم تتم العملية بشكل صحيح', backgroundColor: red);
      }
    }
    loading = false;
    update();
  }

  activerDesactiverMCN(String phone, BuildContext context) async {
    loading = true;
    update();
    bool isConnected = await checkInternetConnectivity();
    if (!isConnected) {
      showSnackBar('الانترنت غير متوفرة لديكم', backgroundColor: red);
      loading = false;
      update();
      return;
    }
    if (phone.isNotEmpty) {
      Map<String, dynamic>? map = await getUserDataFromUsersCollection(phone);
      if (map != null) {
        listOfcodes = map[userCollectionScoolsCodes];
        showDialogConfirmWithActiveDesactiveTKNandMCN(
          labelTextCode: 'كود المدرسة',
          controllerCode: codeEcole,
          onShowDropDownCode: () {
            selectDropDownListCodesEcole(context);
          },
          onConfirm: () async {
            if (codeEcole.text.isEmpty) {
              showSnackBar('اختيار الكود أمر ضروري', backgroundColor: red);
              return;
            }
            Get.back();
            loading = true;
            update();
            Map<String, dynamic>? mapSchool =
                await getSchoolDataFromSchoolsCollection(codeEcole.text);
            if (mapSchool != null) {
              String msg;
              if (mapSchool[schoolCollectionPossibleM] == true) {
                mapSchool[schoolCollectionPossibleM] = false;
                msg = 'تعطيل';
              } else {
                mapSchool[schoolCollectionPossibleM] = true;
                msg = 'تفعيل';
              }
              await updateSchoolDataToSchoolsCollection(
                  codeEcole.text, mapSchool);
              showSnackBar('تم $msg السماح بتوزيع النسخة',
                  backgroundColor: green);
              getAllUsers();
            } else {
              showSnackBar('يرجى إعادة المحاوبة أو الاتصال بالمهندس',
                  backgroundColor: red);
              loading = false;
              update();
            }
          },
        );
      } else {
        showSnackBar('لم تتم العملية بشكل صحيح', backgroundColor: red);
      }
    }
    loading = false;
    update();
  }

  showDataUser(String phone, BuildContext context) async {
    loading = true;
    update();
    bool isConnected = await checkInternetConnectivity();
    if (!isConnected) {
      showSnackBar('الانترنت غير متوفرة لديكم', backgroundColor: red);
      loading = false;
      update();
      return;
    }
    Map<String, dynamic>? mapUser = await getUserDataFromUsersCollection(phone);
    if (mapUser != null) {
      List<Widget> listWidget =
          await getEcoles(mapUser[userCollectionScoolsCodes]);
      showDialogDataUser(
        list: listWidget,
        nom: mapUser[userCollectionNom],
        phone: mapUser[userCollectionPhone],
      );
    } else {
      showSnackBar('لم تتم العملية بشكل صحيح', backgroundColor: red);
    }
    loading = false;
    update();
  }

  Future<List<Widget>> getEcoles(List listScools) async {
    List<Widget> listWidget = [];
    bool view = false;
    for (var element in listScools) {
      Map<String, dynamic>? mapSchool =
          await getSchoolDataFromSchoolsCollection(element);
      if (mapSchool != null) {
        view != true
            ? listWidget.add(const MyText(
                data: 'مدارسه', decoration: TextDecoration.underline))
            : const SizedBox();
        listWidget.add(const Text('****************'));
        listWidget.add(MyRow(label: 'كود المدرسة', data: '$element'));
        listWidget.add(MyRow(
            label: 'اسم المدرسة',
            data: '${mapSchool[schoolCollectionNomEcole]}'));
        listWidget.add(MyRow(
            label: 'السماح بالتفعيل',
            data: mapSchool[schoolCollectionPossibleT] == true
                ? 'مفعل'
                : 'معطل'));
        listWidget.add(MyRow(
            label: 'السماح بالتوزيع',
            data: mapSchool[schoolCollectionPossibleM] == true
                ? 'مفعل'
                : 'معطل'));
        listWidget.add(MyRow(
            label: 'مدة الصلاحية',
            data: convertSeconds('${mapSchool[schoolCollectionTokenValid]}')));
        listWidget.add(MyRow(
            label: 'الحواسبب', data: '${mapSchool[schoolCollectionMachines]}'));
        // listWidget.add(MyRow(
        //     label: 'التواريخ',
        //     data: '${mapSchool[schoolCollectionTimesRefresh]}'));
      }
      view = true;
    }
    return listWidget;
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

  void selectDropDownListPeriodeNames(BuildContext context) {
    selectDropDown(context,
        label: 'الفترات المتاحة',
        data: listOfPeriodeNames(),
        selectedItems: selecteItemsPeriodeName);
  }

  List<SelectedListItem> listOfPeriodeNames() {
    List<SelectedListItem> list = [];
    list.add(
      SelectedListItem(
        name: periodSecondName,
      ),
    );
    list.add(
      SelectedListItem(
        name: periodHourName,
      ),
    );
    list.add(
      SelectedListItem(
        name: periodDayName,
      ),
    );
    list.add(
      SelectedListItem(
        name: periodWeekName,
      ),
    );
    list.add(
      SelectedListItem(
        name: periodMonthName,
      ),
    );
    list.add(
      SelectedListItem(
        name: periodYearName,
      ),
    );
    return list;
  }

  selecteItemsPeriodeName(List<dynamic> selectedList) {
    List<String> list = [];
    for (var item in selectedList) {
      if (item is SelectedListItem) {
        list.add(item.name);
      }
    }
    periodeName.text = list.first;
  }

  @override
  void onInit() async {
    await getAllUsers();
    super.onInit();
  }
}
