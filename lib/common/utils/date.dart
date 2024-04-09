import 'package:intl/intl.dart';

String timeLineFormat(DateTime dt) {
  var now = DateTime.now();
  var different = now.difference(dt);

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

String dateFormat(DateTime dt) {
  final dateFM = DateFormat("dd/MM/yyyy");
  return dateFM.format(dt);
}
