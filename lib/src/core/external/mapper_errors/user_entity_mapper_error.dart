import '../../../shared/data/indexed_errors.dart';
import '../../../shared/errors/mapper_error.dart';

class UserEntityMapperError extends MapperError {
  UserEntityMapperError({
    required StackTrace stackTrace,
    required String errorMessage,
    bool? showInDebugTest,
  }) : super(
          errorCode: IndexedErrors.userEntityMapperError,
          stackTrace: stackTrace,
          errorMessage: errorMessage,
          mapperName: 'UserEntityMapperError',
          showInDebugTest: showInDebugTest ?? false,
        );
}
