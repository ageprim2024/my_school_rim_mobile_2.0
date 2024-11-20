import 'package:get/get.dart';
import 'package:my_school_rim/tools/constants/expression.dart';
import 'package:my_school_rim/tools/functions/get_profiles.dart';

class EcoleController extends GetxController {
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
