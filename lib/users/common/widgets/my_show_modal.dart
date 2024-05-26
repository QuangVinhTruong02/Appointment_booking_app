import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

myShowModal({
  required BuildContext context,
  required Widget child,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return child;
    },
  );
}
