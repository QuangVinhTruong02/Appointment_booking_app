import 'package:booking_doctor/users/common/entities/entities.dart';

class LayoutTemplateState {
  String _title = "";
  set title(String value) => _title = value;
  String get title => _title;

  late UserData _userData;
  set userData(UserData value) => _userData = value;

  UserData get userData => _userData;
}
