import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_rim/controllers/version_distribue_controller.dart';

import '../widgets/container_indicator.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text.dart';

class VersionDistributionPage extends StatelessWidget {
  final VersionDistributionController controller = Get.find();
  VersionDistributionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'توزيع نسخة'),
      body: Stack(
        children: [
          ContainerNormal(
            child: Column(
              children: <Widget>[
                MyButton(
                  onPressed: () {
                    controller.scannBarCode();
                  },
                  data: 'مسح الرمز QR',
                ),
                GetBuilder<VersionDistributionController>(
                  builder: (controller) => controller.barCodeScannerRes.length >
                          2
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            const Divider(),
                            MyText(data: 'كود المدرسة : ${controller.ecoleID}'),
                            MyText(
                                data:
                                    'تعريفة الجهاز : ${controller.machineID}'),
                            const Divider(),
                            const MyText(data: 'رمز QR للتوزيع'),
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
          GetBuilder<VersionDistributionController>(
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
