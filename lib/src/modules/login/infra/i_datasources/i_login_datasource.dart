import '../../domain/entities/login_response.dart';
import '../../domain/params/login_params.dart';

abstract class ILoginDatasource {
  Future<LoginResponse> call(LoginParams params);
}
