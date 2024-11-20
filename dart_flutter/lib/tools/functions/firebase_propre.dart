
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_school_rim/tools/constants/expression.dart';

getProbreDataFromPropreCollection() async {
  return await FirebaseFirestore.instance
      .collection(propreCollection)
      .doc('22660920')
      .get().then((value) {
        if(value.exists){
          return value.data();
        }else{
          return null;
        }
      });
}