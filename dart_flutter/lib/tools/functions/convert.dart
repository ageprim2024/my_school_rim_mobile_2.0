import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

Future<List<Map<String, dynamic>>> convertSnapshotToList(
    QuerySnapshot snapshot) async {
  List<Map<String, dynamic>> resultList = [];

  // Iterate over the documents in the snapshot
  for (var doc in snapshot.docs) {
    // Convert each document to a Map<String, dynamic>
    Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
    resultList.add(docData);
  }

  return resultList;
}

Map<String, dynamic> convertStringToMqp(String value) {
  return jsonDecode(value);
}
