class InvalidException implements Exception {
  final String message;
  InvalidException({required this.message});

  @override
  String toString() {
    return message;
  }
}
