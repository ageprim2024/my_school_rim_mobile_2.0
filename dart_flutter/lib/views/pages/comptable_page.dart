import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_rim/controllers/comptable_controller.dart';

import '../../tools/constants/colors.dart';
import '../../tools/constants/fonts.dart';
import '../widgets/container_indicator.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_text.dart';

class ComptablePage extends StatelessWidget {
  final ComptableController controller = Get.find();
  ComptablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: '${controller.ecoleName} "${controller.profile}"',
          fontSize: font18,
          actions: const []),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    controller.scannBarCodePay();
                  },
                  title: const Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: MyText(
                          data: 'ارسال اشعار دفع',
                          color: blue,
                          fontSize: font16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                   controller.scannBarCodeDette();
                  },
                  title: const Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: MyText(
                          data: 'ارسال اشعار مستحقات',
                          color: blue,
                          fontSize: font16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          GetBuilder<ComptableController>(
            builder: (controller) => Container(
              child: controller.loading == true
                  ? const ContainerIndicator(
                      opacity: 1,
                    )
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
