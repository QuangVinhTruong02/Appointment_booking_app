import 'package:firebase_storage/firebase_storage.dart';

enum CloudStorageExceptionType {
  unAuthenticated,
  unknown,
  canceled,
  retryLimitExceeded
}

class CloudStorageException {
  static handleException(FirebaseException e) {
    var status;
    switch (e.code) {
      case "storage/unauthenticated":
        status = CloudStorageExceptionType.unAuthenticated;
        break;
      case "storage/canceled":
        status = CloudStorageExceptionType.canceled;
        break;
      case "storage/retry-limit-exceeded":
        status = CloudStorageExceptionType.retryLimitExceeded;
        break;
      default:
        status = CloudStorageExceptionType.unknown;
    }

    return status;
  }

  static generateExceptionMessage(CloudStorageExceptionType exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case CloudStorageExceptionType.unAuthenticated:
        errorMessage = "User is not authenticated";
        break;
      case CloudStorageExceptionType.canceled:
        errorMessage = "Upload canceled";
        break;
      case CloudStorageExceptionType.retryLimitExceeded:
        errorMessage = "Retry limit exceeded";
        break;
      default:
        errorMessage = "Unknown error";
    }
    return errorMessage;
  }


}
