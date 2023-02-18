import '../../../../shared/data/indexed_errors.dart';
import '../../../../shared/errors/mapper_error.dart';

class SignUpResponseMapperError extends MapperError {
  SignUpResponseMapperError({
    required StackTrace stackTrace,
    required String errorMessage,
    bool? showInDebugTest,
  }) : super(
          errorCode: IndexedErrors.signUpResponseMapperError,
          stackTrace: stackTrace,
          errorMessage: errorMessage,
          mapperName: 'SignUpResponseMapperError',
          showInDebugTest: showInDebugTest ?? false,
        );
}
