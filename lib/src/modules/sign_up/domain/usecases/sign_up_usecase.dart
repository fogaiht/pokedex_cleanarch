import 'package:dartz/dartz.dart';

import '../../../../shared/contracts/i_error.dart';
import '../../../../shared/errors/domain_error.dart';
import '../entities/sign_up_response.dart';
import '../i_repositories/i_sign_up_repository.dart';
import '../params/sign_up_params.dart';

abstract class ISignUpUsecase {
  Future<Either<IError, SignUpResponse>> call(SignUpParams params);
}

class SignUpUsecase implements ISignUpUsecase {
  final ISignUpRepository repository;

  SignUpUsecase(this.repository);

  @override
  Future<Either<IError, SignUpResponse>> call(SignUpParams params) async {
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
    if (!params.fullName.isValid) {
      return Left(DomainError(
        message: params.fullName.hasError()!,
        stackTrace: StackTrace.current,
        showInDebugTest: showInDebugTest,
      ));
    }
    final result = await repository(params);
    return result;
  }
}
