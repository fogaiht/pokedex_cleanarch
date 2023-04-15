import 'package:dartz/dartz.dart';

import '../../../../shared/contracts/i_error.dart';
import '../../../../shared/errors/datasource_error.dart';
import '../../login_module.dart';

class LoginRepository extends ILoginRepository {
  final ILoginDatasource datasource;

  LoginRepository(this.datasource);
  @override
  Future<Either<IError, LoginResponse>> call(LoginParams params) async {
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
