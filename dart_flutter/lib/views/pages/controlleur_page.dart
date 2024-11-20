import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/controlleur_controller.dart';
import '../../tools/constants/colors.dart';
import '../../tools/constants/expression.dart';
import '../../tools/constants/fonts.dart';
import '../widgets/container_indicator.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_text.dart';
import 'etudiant_page.dart';

class ControlleurPage extends StatelessWidget {
  final ControlleurController controller = Get.find();
  ControlleurPage({super.key});

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
                    Get.to(arguments: {
                      keyQRecoleID: controller.ecoleCode,
                    }, () => EtudiantPage());
                  },
                  title: const Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: MyText(
                          data: 'المدرسون',
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
                          data: 'غياب الطلاب',
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
                          data: 'حضور المدرسين',
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
          GetBuilder<ControlleurController>(
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
