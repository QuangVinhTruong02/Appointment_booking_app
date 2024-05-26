import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> selectDate(
    BuildContext context, TextEditingController textEditingController) async {
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2025),
  );

  if (picked != null) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    textEditingController.text = formatter.format(picked);
  }
}
