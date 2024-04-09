bool isEmail(String? input) {
  if (input == null || input.isEmpty) return false;
  String regEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+_/=?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  return RegExp(regEmail).hasMatch(input);
}

bool isLength(String? input) {
  if (input == null || input.isEmpty) return false;
  return input.length >= 6;
}

bool checkSpecialCharacter(String value) {
  String regSpecialCharacter = r'[!@#\$%^&*(),.?":{}|<>]';
  return RegExp(regSpecialCharacter).hasMatch(value);
}

bool checkPhoneNumber(String value) {
  String regSpecialCharacter = r"\d";
  return RegExp(regSpecialCharacter).hasMatch(value);
}
