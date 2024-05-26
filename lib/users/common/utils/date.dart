import 'package:intl/intl.dart';

String timeLineFormat(DateTime dt) {
  DateTime now = DateTime.now();
  Duration different = now.difference(dt);
  if (different.inMinutes < 60) {
    return '${different.inMinutes} phút';
  }
  if (different.inHours < 24) {
    return '${different.inHours} giờ';
  }
  if (different.inDays < 30) {
    return '${different.inDays} ngày';
  } else if (different.inDays < 365) {
    final dtFormat = DateFormat('dd-MM');
    return dtFormat.format(dt);
  } else {
    final dtFormat = DateFormat('dd-MM-yyyy');
    return dtFormat.format(dt);
  }
}

String formatDate(DateTime dt) {
  final dateFormat = DateFormat("dd/MM/yyyy");
  return dateFormat.format(dt);
}

String formatDayMonth(DateTime dt) {
  final dateFormat = DateFormat("dd/MM", "vi");
  return dateFormat.format(dt);
}

String formatDay(DateTime dt) {
  final dateFormat = DateFormat("EEEE", "vi");
  final dayOfWeek = dateFormat.format(dt);
  switch (dayOfWeek) {
    case 'Thứ Hai':
      return 'Thứ 2';
    case 'Thứ Ba':
      return 'Thứ 3';
    case 'Thứ Tư':
      return 'Thứ 4';
    case 'Thứ Năm':
      return 'Thứ 5';
    case 'Thứ Sáu':
      return 'Thứ 6';
    case 'Thứ Bảy':
      return 'Thứ 7';
    case 'Chủ Nhật':
      return 'Chủ nhật';
    default:
      return dayOfWeek;
  }
  // return dateFormat.format(dt);
}

String formatTime(DateTime dt) {
  final timeFormat = DateFormat("HH:mm");
  return timeFormat.format(dt);
}

String formatCurrency(int price) {
  final currencyFormat = NumberFormat.currency(locale: 'vi-VN', symbol: '₫');
  return currencyFormat.format(price);
}
