import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(String email, String userName, String password,
      String confirmPassword) = _RegisterObject;
}

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String email, String password) = _LoginObject;
}



