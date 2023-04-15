import 'datasource_error.dart';

class MapperError extends DataSourceError {
  final String errorMessage;
  final String mapperName;

  MapperError({
    required String errorCode,
    required StackTrace stackTrace,
    required this.errorMessage,
    required this.mapperName,
    bool? showInDebugTest,
  }) : super(
          message: '$errorCode $mapperName -> $errorMessage',
          stackTrace: stackTrace,
          reportTag: '$errorCode $mapperName -> $errorMessage',
          indexedCode: errorCode,
          showInDebugTest: showInDebugTest,
        );
}
