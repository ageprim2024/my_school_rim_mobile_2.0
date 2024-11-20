import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/expression.dart';

getSchoolDataFromSchoolsCollection(String code) async {
  return await FirebaseFirestore.instance
      .collection(schoolsCollection)
      .doc(code)
      .get()
      .then((value) {
    if (value.exists) {
      return value.data();
    } else {
      return null;
    }
  });
}

addSchoolDataToSchoolsCollection(String code, Map map) {
  FirebaseFirestore.instance.collection(schoolsCollection).doc(code).set({
    schoolCollectionPhone: map[schoolCollectionPhone],
    schoolCollectionMachines: map[schoolCollectionMachines],
    schoolCollectionPossibleM: map[schoolCollectionPossibleM],
    schoolCollectionPossibleT: map[schoolCollectionPossibleT],
    schoolCollectionTokenValid: map[schoolCollectionTokenValid],
    schoolCollectionNomEcole: map[schoolCollectionNomEcole],
    schoolCollectionTimesRefresh: map[schoolCollectionTimesRefresh],
    schoolCollectionTokensCRS: map[schoolCollectionTokensCRS],
    schoolCollectionTokensENS: map[schoolCollectionTokensENS],
    schoolCollectionTokensPRT: map[schoolCollectionTokensPRT],
    schoolCollectionTokensDRG: map[schoolCollectionTokensDRG],
    schoolCollectionTokensDRL: map[schoolCollectionTokensDRL],
    schoolCollectionTokensCNG: map[schoolCollectionTokensCNG],
    schoolCollectionTokensCMP: map[schoolCollectionTokensCMP],
    schoolCollectionTokensPLT: map[schoolCollectionTokensPLT],
    schoolCollectionTokensGRD: map[schoolCollectionTokensGRD],
    schoolCollectionTokensATR: map[schoolCollectionTokensATR],
  });
}

updateSchoolDataToSchoolsCollection(String code, Map map) {
  FirebaseFirestore.instance.collection(schoolsCollection).doc(code).update({
    schoolCollectionPhone: map[schoolCollectionPhone],
    schoolCollectionMachines: map[schoolCollectionMachines],
    schoolCollectionPossibleM: map[schoolCollectionPossibleM],
    schoolCollectionPossibleT: map[schoolCollectionPossibleT],
    schoolCollectionTokenValid: map[schoolCollectionTokenValid],
    schoolCollectionNomEcole: map[schoolCollectionNomEcole],
    schoolCollectionTimesRefresh: map[schoolCollectionTimesRefresh],
    schoolCollectionTokensCRS: map[schoolCollectionTokensCRS],
    schoolCollectionTokensENS: map[schoolCollectionTokensENS],
    schoolCollectionTokensPRT: map[schoolCollectionTokensPRT],
    schoolCollectionTokensDRG: map[schoolCollectionTokensDRG],
    schoolCollectionTokensDRL: map[schoolCollectionTokensDRL],
    schoolCollectionTokensCNG: map[schoolCollectionTokensCNG],
    schoolCollectionTokensCMP: map[schoolCollectionTokensCMP],
    schoolCollectionTokensPLT: map[schoolCollectionTokensPLT],
    schoolCollectionTokensGRD: map[schoolCollectionTokensGRD],
    schoolCollectionTokensATR: map[schoolCollectionTokensATR],
  });
}
