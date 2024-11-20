import 'dart:math';

import 'package:my_school_rim/tools/functions/firebase_schools.dart';

Future<String> getRandom() async {
  Random random = Random();
  int randomNumber = random.nextInt(9999);
  if (randomNumber < 10) {
    return '000$randomNumber';
  } else if (randomNumber < 100) {
    return '00$randomNumber';
  } else if (randomNumber < 1000) {
    return '0$randomNumber';
  }
  Map<String, dynamic>? map =
      await getSchoolDataFromSchoolsCollection('$randomNumber');
  if (map != null) {
    getRandom();
  }
  return '$randomNumber';
}
