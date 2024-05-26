import 'package:flutter/material.dart';

class SignInState {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  String _errorMess = "";
  bool _isValidInput = false;

  set errorMess(String value) {
    _errorMess = value;
  }

  set isValidInput(bool value) => _isValidInput = value;

  String get errorMess => _errorMess;

  bool get isValidInput => _isValidInput;
}
