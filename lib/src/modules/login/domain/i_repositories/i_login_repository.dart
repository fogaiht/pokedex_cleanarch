import 'package:dartz/dartz.dart';

import '../../../../shared/contracts/i_error.dart';
import '../entities/login_response.dart';
import '../params/login_params.dart';

abstract class ILoginRepository {
  Future<Either<IError, LoginResponse>> call(LoginParams params);
}
