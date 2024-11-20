import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_rim/tools/constants/fonts.dart';
import 'package:my_school_rim/views/widgets/my_app_bar.dart';
import 'package:my_school_rim/views/widgets/my_textfield.dart';

import '../../controllers/notifications_controller.dart';
import '../../tools/constants/colors.dart';
import '../../tools/constants/expression.dart';
import '../../tools/constants/sizes.dart';
import '../widgets/container_indicator.dart';
import '../widgets/my_button.dart';
import '../widgets/my_icon.dart';
import '../widgets/my_text.dart';

class NotificationsPage extends StatelessWidget {
  final NotificationsController controller = Get.find();
  NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'الإذن باشعارات المدرسة'),
      body: Stack(
        children: [
          ContainerNormal(
            child: GetBuilder<NotificationsController>(builder: (controller) {
              return Column(
                children: <Widget>[
                  const MyText(
                    data: 'خطوات السماح للمعني بتلقي اشعارات المدرسة',
                    fontSize: font20,
                    textAlign: TextAlign.center,
                    color: red,
                  ),
                  Row(children: [
                    Expanded(
                      child: MyIcon(
                        icon: Icons.list_alt,
                        size: size26,
                        color: blue,
                        onTap: () {
                          controller.selectDropDownListCodesEcole(context);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: MyTextField(
                          readOnly: true,
                          label: 'كود المدرسة',
                          fontSize: font12,
                          controller: controller.codeEcole),
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  const MyText(
                      data: 'يرجى تحديد من يكون المعني', fontSize: font12),
                  Row(
                    children: [
                      Checkbox(
                        value: controller.isCheckedCRS,
                        onChanged: (value) {
                          controller.changeValueCRS(value!);
                        },
                      ),
                      MyText(
                        data: typeCRS,
                        fontSize: font12,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: controller.isCheckedENS,
                        onChanged: (value) {
                          controller.changeValueENS(value!);
                        },
                      ),
                      MyText(
                        data: typeENS,
                        fontSize: font12,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: controller.isCheckedPRT,
                        onChanged: (value) {
                          controller.changeValuePRT(value!);
                        },
                      ),
                      MyText(
                        data: typePRT,
                        fontSize: font12,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: controller.isCheckedFNC,
                        onChanged: (value) {
                          controller.changeValueFNC(value!);
                        },
                      ),
                      const MyText(
                        data: 'موظف',
                        fontSize: font12,
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      controller.isCheckedFNC
                          ? Row(
                              children: [
                                MyIcon(
                                  onTap: () {
                                    controller
                                        .selectDropDownListFonctions(context);
                                  },
                                  icon: Icons.list,
                                  color: blue,
                                  size: size28,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                MyText(
                                  data: 'الوظيفة : ${controller.fonction}',
                                  fontSize: font12,
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const Divider(),
                  const MyText(
                    textAlign: TextAlign.center,
                    data:
                        'الرجاء الضغط على الزر أسفله لالتقاط QRCode الخاص بتوكن هاتف المعني',
                    fontSize: font12,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  MyButton(
                    onPressed: () {
                      controller.scannBarCode();
                    },
                    data: 'مسح الرمز QR',
                  ),
                ],
              );
            }),
          ),
          GetBuilder<NotificationsController>(
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
