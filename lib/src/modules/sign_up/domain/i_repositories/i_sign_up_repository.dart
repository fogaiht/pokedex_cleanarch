import 'package:dartz/dartz.dart';

import '../../../../shared/contracts/i_error.dart';
import '../entities/sign_up_response.dart';
import '../params/sign_up_params.dart';

abstract class ISignUpRepository {
  Future<Either<IError, SignUpResponse>> call(SignUpParams params);
}
