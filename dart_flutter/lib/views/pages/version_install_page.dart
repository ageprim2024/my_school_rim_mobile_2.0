import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/version_install_controller.dart';
import '../../main.dart';
import '../../tools/constants/expression.dart';
import '../widgets/container_indicator.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text.dart';

class VersionInstallPage extends StatelessWidget {
  final VersionInstallController controller = Get.find();
  VersionInstallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'تثبيت نسخة'),
      body: Stack(
        children: [
          ContainerNormal(
            child: Column(
              children: <Widget>[
                const Divider(),
                MyText(
                    data:
                        'أكواد مدارسي\n ${mySharedPreferences!.getString(sharedPreferencesMyCodes)}'),
                const Divider(),
                MyButton(
                  onPressed: () {
                    controller.scannBarCode();
                  },
                  data: 'مسح الرمز QR',
                ),
                GetBuilder<VersionInstallController>(
                  builder: (controller) => controller.barCodeScannerRes.length >
                          2
                      ? Column(
                          children: [
                            const Divider(),
                            MyText(data: 'كود المدرسة : ${controller.ecoleID}'),
                            MyText(
                                data:
                                    'تعريفة الجهاز : ${controller.machineID}'),
                            const Divider(),
                             SizedBox(
                              width: 350,
                              height: 500,
                              child: BarcodeWidget(
                                data: controller.barCodeScannerRes,
                                barcode: Barcode.qrCode(),
                              ),
                            ),
                            const Divider(),
                            const MyText(
                              data:
                                  'قم بمسح رمز QR أعلاه عن طريق تطبيق My School RIM سطح المكتب',
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
          GetBuilder<VersionInstallController>(
            builder: (controller) => Container(
              child: controller.loading == true
                  ? const ContainerIndicator()
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
