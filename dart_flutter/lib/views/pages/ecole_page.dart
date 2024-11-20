import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_rim/controllers/ecole_controller.dart';
import 'package:my_school_rim/tools/constants/expression.dart';
import 'package:my_school_rim/views/widgets/my_app_bar.dart';
import 'package:my_school_rim/views/widgets/my_image.dart';
import 'package:my_school_rim/views/widgets/my_text.dart';

import '../../tools/constants/colors.dart';
import '../../tools/constants/fonts.dart';
import '../widgets/container_indicator.dart';

class EcolePage extends StatelessWidget {
  final EcoleController controller = Get.find();
  EcolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            MyAppBar(title: controller.ecoleName, fontSize: font18, actions: const [
          
        ]),
        body: Stack(
          children: [
            GetBuilder<EcoleController>(builder: (controller) {
              return RefreshIndicator(
                  onRefresh: () async {
                    controller.getListProfiles();
                  },
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: controller.listProfiles.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 0,
                              shape: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              color: Colors.white,
                              child: ListTile(
                                onTap: () {
                                  Get.toNamed(
                                      controller.listProfiles[index][keyPage],
                                      arguments: {
                                        keyQRecoleID: controller.ecoleCode
                                      });
                                },
                                title: Center(
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MyImage(
                                          height: 140,
                                          width: 180,
                                          name: controller.listProfiles[index]
                                              [keyImage]),
                                      MyText(
                                        data: controller.listProfiles[index]
                                            [keyProfile],
                                        color: black,
                                        fontSize: font18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ));
            }),
            GetBuilder<EcoleController>(
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
