import '../analytics/error_report.dart';
import '../contracts/i_error.dart';
import '../data/export/shared_data.dart';

class DriverError extends IError {
  final String? driverName;
  final String driverErrorMessage;

  DriverError({
    required this.driverErrorMessage,
    required StackTrace stackTrace,
    this.driverName,
    String? errorCode,
    bool? showInDebugTest,
  }) : super(
          message: PokedexTexts.unexpectedErrorCode.errorCode(
            errorCode ?? IndexedUtilsErrors.driverError,
          ),
          stackTrace: stackTrace,
          reportTag:
              "${errorCode ?? IndexedUtilsErrors.driverError} [${driverName ?? 'DriverError'}] -> $driverErrorMessage",
          errorCode: errorCode ?? IndexedUtilsErrors.driverError,
          showInDebugTest: showInDebugTest ?? false,
        ) {
    _errorReport(showInDebugTest);
  }

  void _errorReport(bool? showInDebugTest) {
    ErrorReport.externalFailureError(
      message,
      stackTrace,
      reportTag ?? '',
      errorCode,
      showInDebugTest,
    );
  }
}
