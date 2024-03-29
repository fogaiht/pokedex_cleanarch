abstract class IError implements Exception {
  final String message;
  final StackTrace stackTrace;
  final String? reportTag;
  final String errorCode;
  final bool showInDebugTest;

  const IError({
    required this.message,
    required this.stackTrace,
    required this.errorCode,
    this.reportTag,
    required this.showInDebugTest,
  });
}
