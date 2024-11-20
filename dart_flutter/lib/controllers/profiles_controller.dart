
import 'package:get/get.dart';

import '../tools/constants/expression.dart';
import '../tools/functions/get_profiles.dart';

class ProfilesController extends GetxController{

  bool loading = false;
  List<Map> listProfiles = [];
  String ecoleName = '';
  String profiles = '';
  String ecoleCode = '';
 

  getListProfiles() async {
    listProfiles.clear();
    listProfiles.addAll(getProfiles(profiles));
    update();
  }


   @override
  void onInit() async {
    Map map = Get.arguments;
    ecoleName = map[keyQRecolename];
    ecoleCode = map[keyQRecoleID];
    profiles = map[keyQRprofiles];
    await getListProfiles();
    super.onInit();
  }
}