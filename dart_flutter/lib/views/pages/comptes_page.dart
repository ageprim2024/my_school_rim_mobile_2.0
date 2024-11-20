import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_rim/tools/constants/sizes.dart';
import 'package:my_school_rim/views/widgets/my_textfield.dart';

import '../../controllers/comptes_controller.dart';
import '../../tools/constants/expression.dart';
import '../widgets/container_indicator.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_listview.dart';
import '../widgets/my_text.dart';

class ComptesPage extends StatelessWidget {
  const ComptesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'الحسابات'),
      body: Stack(
        children: [
          GetBuilder<ComptesController>(
            builder: (controller) {
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.getAllUsers();
                },
                child: MyListView(
                  details: const Row(
                    children: [
                      Expanded(child: MyText(data: 'الحسابات',fontSize: size20)),
                      Expanded(child: MyTextField(label: 'label'))
                    ],
                  ),
                  map: controller.mapCours,
                  titleValue: userCollectionNom,
                  subtitleValue1: userCollectionPhone,
                  keyIndex: userCollectionPhone,
                  onTapOne: (phone) {
                    controller.activerDesactiverDRC(phone);
                  },
                  iconTwo: Icons.qr_code,
                  onTapTwo: (phone) {
                    controller.generateSchoolCode(phone);
                  },
                  iconThree: Icons.timer,
                  onTapThree: (phone) {
                    controller.generateExprationToken(phone, context);
                  },
                  iconFour: Icons.token,
                  onTapFour: (phone) {
                    controller.activerDesactiverTKN(phone, context);
                  },
                  iconFive: Icons.desktop_windows,
                  onTapFive: (phone) {
                    controller.activerDesactiverMCN(phone, context);
                  },
                  iconSix: Icons.remove_red_eye,
                  onTapSix: (phone) {
                   controller.showDataUser(phone, context);
                  },
                ),
              );
            },
          ),
          GetBuilder<ComptesController>(
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
