import '../constants/expression.dart';
import 'firebase_schools.dart';
import 'firebase_users.dart';

Future<List> getTelephonesAndTokens(String ecoleCode, List tokenTypes) async {
  List telephonesandtokens = [];
  List telephones = [];
  List tokens = [];
  Map<String, dynamic>? mapSchool =
      await getSchoolDataFromSchoolsCollection(ecoleCode);
  if (mapSchool != null) {
    if (tokenTypes.contains(typeATR)) {
      telephones = mapSchool[schoolCollectionTokensATR];
    }
    if (tokenTypes.contains(typeCMP)) {
      telephones = mapSchool[schoolCollectionTokensCMP];
    }
    if (tokenTypes.contains(typeCNG)) {
      telephones = mapSchool[schoolCollectionTokensCNG];
    }
    if (tokenTypes.contains(typeCRS)) {
      telephones = mapSchool[schoolCollectionTokensCRS];
    }
    if (tokenTypes.contains(typeDRG)) {
      telephones = mapSchool[schoolCollectionTokensDRG];
    }
    if (tokenTypes.contains(typeDRL)) {
      telephones = mapSchool[schoolCollectionTokensDRL];
    }
    if (tokenTypes.contains(typeENS)) {
      telephones = mapSchool[schoolCollectionTokensENS];
    }
    if (tokenTypes.contains(typeGRD)) {
      telephones = mapSchool[schoolCollectionTokensGRD];
    }
    if (tokenTypes.contains(typePLT)) {
      telephones = mapSchool[schoolCollectionTokensPLT];
    }
    if (tokenTypes.contains(typePRT)) {
      telephones = mapSchool[schoolCollectionTokensPRT];
    }
    telephones = telephones.toSet().toList();
    for (var element in telephones) {
      Map<String, dynamic>? mapUsers =
          await getUserDataFromUsersCollection(element);
      if (mapUsers != null) {
        tokens.add(mapUsers[userCollectionToken]);
      }
    }
  }
  tokens = tokens.toSet().toList();
  telephonesandtokens.add(telephones);
  telephonesandtokens.add(tokens);
  return telephonesandtokens;
}

Future<String> getOneTokens(
    String ecoleCode, List tokenTypes, String phone) async {
  List telephones = [];
  Map<String, dynamic>? mapSchool =
      await getSchoolDataFromSchoolsCollection(ecoleCode);
  if (mapSchool != null) {
    if (tokenTypes.contains(typeATR)) {
      telephones = mapSchool[schoolCollectionTokensATR];
    }
    if (tokenTypes.contains(typeCMP)) {
      telephones = mapSchool[schoolCollectionTokensCMP];
    }
    if (tokenTypes.contains(typeCNG)) {
      telephones = mapSchool[schoolCollectionTokensCNG];
    }
    if (tokenTypes.contains(typeCRS)) {
      telephones = mapSchool[schoolCollectionTokensCRS];
    }
    if (tokenTypes.contains(typeDRG)) {
      telephones = mapSchool[schoolCollectionTokensDRG];
    }
    if (tokenTypes.contains(typeDRL)) {
      telephones = mapSchool[schoolCollectionTokensDRL];
    }
    if (tokenTypes.contains(typeENS)) {
      telephones = mapSchool[schoolCollectionTokensENS];
    }
    if (tokenTypes.contains(typeGRD)) {
      telephones = mapSchool[schoolCollectionTokensGRD];
    }
    if (tokenTypes.contains(typePLT)) {
      telephones = mapSchool[schoolCollectionTokensPLT];
    }
    if (tokenTypes.contains(typePRT)) {
      telephones = mapSchool[schoolCollectionTokensPRT];
    }
    telephones = telephones.toSet().toList();
    if (telephones.contains(phone)) {
      Map<String, dynamic>? mapUsers =
          await getUserDataFromUsersCollection(phone);
      if (mapUsers != null) {
        return (mapUsers[userCollectionToken]);
      }
    }
  }
  return '';
}
