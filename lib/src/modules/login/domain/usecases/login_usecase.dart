import 'package:dartz/dartz.dart';

import '../../../../shared/contracts/i_error.dart';
import '../../../../shared/errors/domain_error.dart';
import '../entities/login_response.dart';
import '../i_repositories/i_login_repository.dart';
import '../params/login_params.dart';

abstract class ILoginUsecase {
  Future<Either<IError, LoginResponse>> call(LoginParams params);
}

class LoginUsecase implements ILoginUsecase {
  final ILoginRepository repository;

  LoginUsecase(this.repository);

  @override
  Future<Either<IError, LoginResponse>> call(LoginParams params) async {
    const showInDebugTest = false;

    if (!params.email.isValid) {
      return Left(DomainError(
        message: params.email.hasError()!,
        stackTrace: StackTrace.current,
        showInDebugTest: showInDebugTest,
      ));
    }
    if (!params.password.isValid) {
      return Left(DomainError(
        message: params.password.hasError()!,
        stackTrace: StackTrace.current,
        showInDebugTest: showInDebugTest,
      ));
    }
    final result = await repository(params);
    return result;
  }
}
