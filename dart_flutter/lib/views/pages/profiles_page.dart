import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_rim/controllers/profiles_controller.dart';

import '../../tools/constants/colors.dart';
import '../../tools/constants/expression.dart';
import '../../tools/constants/fonts.dart';
import '../widgets/container_indicator.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_text.dart';

class ProfilePage extends StatelessWidget {
  final ProfilesController controller = Get.find();
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: controller.ecoleName, fontSize: font18, actions: const []),
      body: Stack(
        children: [
          GetBuilder<ProfilesController>(builder: (controller) {
            return RefreshIndicator(
                onRefresh: () async {
                  await controller.getListProfiles();
                },
                child: ListView.builder(
                  itemCount: controller.listProfiles.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        index == 0
                            ? const Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      MyText(
                                        data: 'خياراتي',
                                        color: red,
                                        fontSize: font16,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        Card(
                          child: ListTile(
                            onTap: () {
                              Get.toNamed(
                                  controller.listProfiles[index][keyPage],
                                  arguments: {
                                    keyQRecoleID: controller.ecoleCode,
                                    keyQRecolename: controller.ecoleName,
                                    keyQRprofile: controller.listProfiles[index][keyProfile],
                                  });
                            },
                            title: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: MyText(
                                    data: controller.listProfiles[index]
                                        [keyProfile],
                                    color: blue,
                                    fontSize: font16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ));
          }),
          GetBuilder<ProfilesController>(
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
