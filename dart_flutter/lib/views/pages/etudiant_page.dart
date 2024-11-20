import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_rim/views/widgets/my_app_bar.dart';

import '../../controllers/etudiant_controller.dart';
import '../../tools/constants/colors.dart';
import '../../tools/constants/fonts.dart';
import '../widgets/container_indicator.dart';
import '../widgets/my_floating_action_button.dart';
import '../widgets/my_icon.dart';
import '../widgets/my_text.dart';

class EtudiantPage extends StatelessWidget {
  final EtudiantController controller = Get.find();
  EtudiantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: MyFloatingActionButton(
          icon: Icons.person_add,
          onPressed: () {
            controller.scannBarCode();
          },
        ),
        appBar: MyAppBar(
          title: 'لائحة الطلاب',
          actions: [
            IconButton(
              onPressed: () {
                controller.savemydata();
              },
              icon: const MyIcon(
                icon: Icons.save,
                color: white,
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            GetBuilder<EtudiantController>(builder: (controller) {
              return RefreshIndicator(
                  onRefresh: () async {
                    await controller.getAllEtudiant();
                  },
                  child: ListView.builder(
                    itemCount: controller.mapEtudiants.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Column(
                            children: [
                              ListTile(
                                isThreeLine: false,
                                title: MyText(
                                  data:
                                      '${controller.mapEtudiants[index][controller.sqlDB.champEtuName]}',
                                  color: blue,
                                  fontSize: font16,
                                ),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const MyText(
                                          data: 'القسم : ',
                                          color: black,
                                          fontSize: font14,
                                        ),
                                        MyText(
                                          data:
                                              '${controller.mapEtudiants[index][controller.sqlDB.champEtuClasse]}',
                                          color: red,
                                          fontSize: font14,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const MyText(
                                          data: 'الكود : ',
                                          color: black,
                                          fontSize: font14,
                                        ),
                                        MyText(
                                          data:
                                              '${controller.mapEtudiants[index][controller.sqlDB.champEtuCode]}',
                                          color: orang,
                                          fontSize: font14,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: Column(
                                  children: [
                                    const Expanded(
                                        child: MyText(data: 'رقم النداء')),
                                    Expanded(
                                      child: MyText(
                                        data:
                                            '${controller.mapEtudiants[index][controller.sqlDB.champEtuNume]}',
                                        color: green,
                                        fontSize: font16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider()
                            ],
                          ),
                        ],
                      );
                    },
                  ));
            }),
            GetBuilder<EtudiantController>(
              builder: (controller) => Container(
                child: controller.loading == true
                    ? const ContainerIndicator(
                        opacity: 1,
                      )
                    : null,
              ),
            )
          ],
        ));
  }
}
