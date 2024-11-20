import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/expression.dart';

addUserDataToUsersCollection(String phone, Map map) {
  FirebaseFirestore.instance.collection(usersCollection).doc(phone).set({
    userCollectionNom: map[userCollectionNom],
    userCollectionPhone: map[userCollectionPhone],
    userCollectionPassword: map[userCollectionPassword],
    userCollectionScoolsCodes: map[userCollectionScoolsCodes],
    userCollectionSecurityAsk: map[userCollectionSecurityAsk],
    userCollectionSecurityAnswer: map[userCollectionSecurityAnswer],
    userCollectionDRC: map[userCollectionDRC],
    userCollectionING: map[userCollectionING],
    userCollectionToken: map[userCollectionToken],
    userCollectionTokenNotifications: map[userCollectionTokenNotifications],
  });
}

getUserDataFromUsersCollection(String phone) async {
  return await FirebaseFirestore.instance
      .collection(usersCollection)
      .doc(phone)
      .get()
      .then((value) {
    if (value.exists) {
      return value.data();
    } else {
      return null;
    }
  });
}

getAllUsersFromCollectionUsers() async {
  return await FirebaseFirestore.instance.collection(usersCollection).get();
}

upDateUserDataFromUsersCollection(String phone, Map map) async {
  FirebaseFirestore.instance.collection(usersCollection).doc(phone).update({
    userCollectionNom: map[userCollectionNom],
    userCollectionPhone: map[userCollectionPhone],
    userCollectionPassword: map[userCollectionPassword],
    userCollectionScoolsCodes: map[userCollectionScoolsCodes],
    userCollectionSecurityAsk: map[userCollectionSecurityAsk],
    userCollectionSecurityAnswer: map[userCollectionSecurityAnswer],
    userCollectionDRC: map[userCollectionDRC],
    userCollectionING: map[userCollectionING],
    userCollectionToken: map[userCollectionToken],
    userCollectionTokenNotifications: map[userCollectionTokenNotifications],
  });
}
