import '../../../../shared/data/indexed_errors.dart';
import '../../../../shared/errors/mapper_error.dart';

class LoginResponseMapperError extends MapperError {
  LoginResponseMapperError({
    required StackTrace stackTrace,
    required String errorMessage,
    bool? showInDebugTest,
  }) : super(
          errorCode: IndexedErrors.loginResponseMapperError,
          stackTrace: stackTrace,
          errorMessage: errorMessage,
          mapperName: 'LoginResponseMapperError',
          showInDebugTest: showInDebugTest ?? false,
        );
}
