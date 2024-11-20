import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_rim/views/pages/etudiant_page.dart';
import 'package:my_school_rim/views/widgets/my_app_bar.dart';

import '../../controllers/correspondant_controller.dart';
import '../../tools/constants/colors.dart';
import '../../tools/constants/expression.dart';
import '../../tools/constants/fonts.dart';
import '../widgets/container_indicator.dart';
import '../widgets/my_text.dart';

class CorrespondantPage extends StatelessWidget {
  final CorrespondantController controller = Get.find();
  CorrespondantPage({super.key});

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
                    Get.to(arguments: {
                      keyQRecoleID: controller.ecoleCode,
                    }, () => EtudiantPage());
                  },
                  title: const Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: MyText(
                          data: 'الطلاب',
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
                    //Get.toNamed();
                  },
                  title: const Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: MyText(
                          data: 'الحساب',
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
          GetBuilder<CorrespondantController>(
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
