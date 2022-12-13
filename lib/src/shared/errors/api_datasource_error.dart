import '../analytics/error_report.dart';
import '../data/export/shared_data.dart';
import 'datasource_error.dart';

class ApiDataSourceError extends DataSourceError {
  final dynamic data;
  final dynamic code;

  ApiDataSourceError({
    required this.data,
    this.code,
    required StackTrace stackTrace,
  }) : super(
          message: data,
          stackTrace: stackTrace,
          reportTag: '-> ApiDatasourceError <-',
          indexedCode: IndexedUtilsErrors.apiDatasourceError,
        ) {
    _errorReport();
  }

  factory ApiDataSourceError.fromError(dynamic data, StackTrace stackTrace,
      {dynamic code}) {
    throw (data == null || data.isEmpty || data?['message'] == null)
        ? ApiDataSourceError(
            stackTrace: stackTrace,
            data: PokedexTexts.unexpectedError,
            code: code,
          )
        : ApiDataSourceError(
            stackTrace: stackTrace,
            data: data['message'],
            code: code ?? data['code'] ?? '',
          );
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
