import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_rim/views/widgets/my_icon.dart';

import '../../views/widgets/my_button.dart';
import '../../views/widgets/my_text.dart';
import '../../views/widgets/my_textfield.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';

showDialogAlert({required String data}) {
  Get.defaultDialog(
      title: "تنبيه",
      titleStyle: const TextStyle(color: Color(blue)),
      content: MyText(data: data, color: red, fontSize: font16,textAlign: TextAlign.center),
      actions: [
        MyButton(
            color: blue,
            onPressed: () {
              Get.back();
            },
            data: 'موافق',fontSize: font14,)
      ]);
}

showDialogConfirm({required String data, required void Function() onConfirm}) {
  Get.defaultDialog(
      title: "تنبيه",
      titleStyle: const TextStyle(color: Color(red)),
      content: MyText(data: data, color: blue, fontSize: font10),
      actions: [
        MyButton(color: green, onPressed: onConfirm, data: 'نعم'),
        MyButton(
            color: gray,
            onPressed: () {
              Get.back();
            },
            data: 'لا')
      ]);
}

showDialogConfirmWithData({
  String title = "تنبيه",
  TextInputType? keyboardType,
  required String label,
  required void Function() onConfirm,
  TextEditingController? controller,
}) {
  Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(color: Color(red)),
      content: Column(
        children: [
          MyTextField(
            keyboardType: keyboardType,
            label: label,
            controller: controller,
          )
        ],
      ),
      actions: [
        MyButton(color: green, onPressed: onConfirm, data: 'نعم'),
        MyButton(
            color: gray,
            onPressed: () {
              Get.back();
            },
            data: 'لا')
      ]);
}

showDialogConfirmWithExpirationToken({
  String title = "تنبيه",
  String? labelTextCode,
  String? labelTextPeriodeName,
  String? labelTextPeriodeNumber,
  required void Function() onConfirm,
  void Function()? onShowDropDownCode,
  void Function()? onShowDropDownPeriode,
  TextEditingController? controllerCode,
  TextEditingController? controllerPerideName,
  TextEditingController? controllerPerideNumber,
}) {
  Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(color: Color(red)),
      content: Column(
        children: [
          Row(
            children: [
              MyIcon(
                icon: Icons.list,
                onTap: onShowDropDownCode,
              ),
              Expanded(
                child: MyTextField(
                  readOnly: true,
                  label: '$labelTextCode',
                  controller: controllerCode,
                ),
              ),
            ],
          ),
          Row(
            children: [
              MyIcon(
                icon: Icons.list,
                onTap: onShowDropDownPeriode,
              ),
              Expanded(
                child: MyTextField(
                  readOnly: true,
                  label: '$labelTextPeriodeName',
                  controller: controllerPerideName,
                ),
              ),
              Expanded(
                child: MyTextField(
                  keyboardType: TextInputType.number,
                  label: '$labelTextPeriodeNumber',
                  controller: controllerPerideNumber,
                ),
              ),
            ],
          )
        ],
      ),
      actions: [
        MyButton(color: green, onPressed: onConfirm, data: 'نعم'),
        MyButton(
            color: gray,
            onPressed: () {
              Get.back();
            },
            data: 'لا')
      ]);
}

showDialogConfirmWithActiveDesactiveTKNandMCN({
  String title = "تنبيه",
  String? labelTextCode,
  required void Function() onConfirm,
  void Function()? onShowDropDownCode,
  TextEditingController? controllerCode,
}) {
  Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(color: Color(red)),
      content: Column(
        children: [
          Row(
            children: [
              MyIcon(
                icon: Icons.list,
                onTap: onShowDropDownCode,
              ),
              Expanded(
                child: MyTextField(
                  readOnly: true,
                  label: '$labelTextCode',
                  controller: controllerCode,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        MyButton(color: green, onPressed: onConfirm, data: 'نعم'),
        MyButton(
            color: gray,
            onPressed: () {
              Get.back();
            },
            data: 'لا')
      ]);
}

showDialogDataUser({
  String? nom,
  String? phone,
  required List<Widget> list,
}) {
  Get.defaultDialog(
      title: "البيانات",
      titleStyle: const TextStyle(color: Color(red)),
      content: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          MyRow(label: 'الإسم', data: '$nom'),
          MyRow(label: 'الهاتف', data: '$phone'),
          ...list,
        ]),
      ),
      actions: [
        MyIcon(
          color: red,
          icon: Icons.close,
          onTap: () {
            Get.back();
          },
        )
      ]);
}

class MyRow extends StatelessWidget {
  final String? label;
  final String? data;
  const MyRow({
    super.key,
    this.label,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: MyText(data: '$label')),
            Expanded(
              flex: 2,
              child: MyText(
                data: '$data',
                fontSize: font14,
                color: blue,
              ),
            )
          ],
        ),
        const Divider(),
      ],
    );
  }
}


