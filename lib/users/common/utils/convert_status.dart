import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String convertAppointmentStatus(String appointmentStatus) {
  switch (appointmentStatus) {
    case "Waiting":
      return "Chờ khám";
    case "Completed":
      return "Đã Khám";
    case "Missed":
      return "Lỡ hẹn";
    case "Canceled":
      return "Đã hủy";
    default:
      return "";
  }
}

Color getStatusColor(String status) {
  switch (status) {
    case "Waiting":
      return Colors.orange;
    case "Completed":
      return Colors.green;
    case "Missed":
      return Colors.red;
    case "Canceled":
      return Colors.red;
    default:
      return Colors.grey;
  }
}
