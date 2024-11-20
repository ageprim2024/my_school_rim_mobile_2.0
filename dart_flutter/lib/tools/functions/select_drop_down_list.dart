import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

import '../constants/fonts.dart';

void selectDropDown(BuildContext context,
    {required String label,
    required List<SelectedListItem> data,
    double fontSize = font10,
    bool enableMultipleSelection = false,
    dynamic Function(List<SelectedListItem>)? selectedItems}) {
  DropDownState(
    DropDown(
      isDismissible: true,
      searchHintText: 'بحث',
      bottomSheetTitle: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
      submitButtonChild: Text(
        'عرض',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      clearButtonChild: Text(
        'مسح',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      data: data,
      selectedItems: selectedItems,
      enableMultipleSelection: enableMultipleSelection,
    ),
  ).showModal(context);
}
