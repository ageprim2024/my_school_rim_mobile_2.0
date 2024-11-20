import 'package:get/get.dart';

import '../tools/constants/expression.dart';

class ControlleurController extends GetxController {
  bool loading = false;
  String ecoleName = '';
  String ecoleCode = '';
  String profile = '';

  @override
  void onInit() async {
    Map map = Get.arguments;
    ecoleName = map[keyQRecolename];
    ecoleCode = map[keyQRecoleID];
    profile = map[keyQRprofile];
    //await getListProfiles();
    super.onInit();
  }
}
