import 'package:firebase_auth/firebase_auth.dart';

enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisable,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}

class AuthExceptionHandle {
  static handleException(FirebaseAuthException e) {
    var status;
    switch (e.code) {
      case "invalid-credential":
        status = AuthResultStatus.invalidEmail;
        break;
      case "email-already-in-use":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case "user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      case "wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "too-many-requests":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "operation-not-allowed":
        status = AuthResultStatus.operationNotAllowed;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  static generateExceptionMessage(AuthResultStatus exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
            "The email has already registered. Please login your account";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "Account doesn't exists";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your password is wrong";
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Operation not allowed";
        break;
      default:
        errorMessage = "An undefined Error happened";
    }
    return errorMessage;
  }
}
