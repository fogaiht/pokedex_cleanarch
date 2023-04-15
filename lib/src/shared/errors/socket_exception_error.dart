import '../analytics/error_report.dart';
import '../data/indexed_utils_errors.dart';
import 'datasource_error.dart';

class SocketExceptionError extends DataSourceError {
  SocketExceptionError({
    required String message,
    required StackTrace stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          reportTag: '-> SocketExceptionError <-',
          indexedCode: IndexedUtilsErrors.socketExceptionError,
        ) {
    _errorReport();
  }
  void _errorReport() {
    ErrorReport.externalFailureError(
      message,
      stackTrace,
      reportTag!,
      indexedCode!,
    );
  }
}
