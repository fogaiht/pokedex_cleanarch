import 'package:dartz/dartz.dart';

import '../../../../shared/contracts/i_error.dart';
import '../../../../shared/errors/datasource_error.dart';
import '../../sign_up_module.dart';

class SignUpRepository extends ISignUpRepository {
  final ISignUpDatasource datasource;

  SignUpRepository(this.datasource);
  @override
  Future<Either<IError, SignUpResponse>> call(SignUpParams params) async {
    try {
      var result = await datasource(params);
      return Right(result);
    } on DataSourceError catch (e) {
      return Left(e);
    } catch (e, s) {
      return Left(DataSourceError(message: e.toString(), stackTrace: s));
    }
  }
}
