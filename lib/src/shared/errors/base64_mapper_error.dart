import '../data/indexed_utils_errors.dart';
import 'mapper_error.dart';

class Base64MapperError extends MapperError {
  Base64MapperError({
    required StackTrace stackTrace,
    required String errorMessage,
    bool? showInDebugTest,
  }) : super(
          errorCode: IndexedUtilsErrors.base64MapperError,
          stackTrace: stackTrace,
          errorMessage: errorMessage,
          mapperName: 'Base64MapperError',
          showInDebugTest: showInDebugTest ?? false,
        );
}
