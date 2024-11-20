import 'package:flutter/material.dart';

DateTime selectedDate = DateTime.now();

Future<DateTime> mySelecteDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(1100),
    lastDate: DateTime(2100),
  );
  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
  }
  return selectedDate;
}
