import '../../domain/entities/sign_up_response.dart';
import '../../domain/params/sign_up_params.dart';

abstract class ISignUpDatasource {
  Future<SignUpResponse> call(SignUpParams params);
}
