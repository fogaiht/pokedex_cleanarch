import '../analytics/error_report.dart';
import '../contracts/i_error.dart';
import '../data/indexed_utils_errors.dart';

class DomainError extends IError {
  DomainError({
    required String message,
    required StackTrace stackTrace,
    bool? showInDebugTest,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          reportTag: '-> DomainError <-',
          errorCode: IndexedUtilsErrors.domainError,
          showInDebugTest: showInDebugTest ?? false,
        ) {
    _errorReport(showInDebugTest);
  }

  void _errorReport(
    bool? showInDebugTest,
  ) {
    ErrorReport.internalFailureError(
      message,
      stackTrace,
      reportTag!,
      IndexedUtilsErrors.domainError,
      showInDebugTest,
    );
  }
}
