import '../analytics/error_report.dart';
import '../contracts/i_error.dart';
import '../data/indexed_utils_errors.dart';

class DataSourceError extends IError {
  final String? indexedCode;

  DataSourceError({
    required message,
    required stackTrace,
    this.indexedCode,
    String? reportTag,
    bool? showInDebugTest,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          reportTag: reportTag ?? '-> DatasourceError <-',
          errorCode: indexedCode ?? IndexedUtilsErrors.datasourceError,
          showInDebugTest: showInDebugTest ?? false,
        ) {
    _errorReport(showInDebugTest);
  }

  void _errorReport(bool? showInDebugTest) {
    ErrorReport.externalFailureError(
      message,
      stackTrace,
      reportTag ?? '',
      indexedCode ?? '',
      showInDebugTest,
    );
  }
}
