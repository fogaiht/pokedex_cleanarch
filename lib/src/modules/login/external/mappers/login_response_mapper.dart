import '../../../../core/external/mappers/user_entity_mapper.dart';
import '../../../../shared/errors/datasource_error.dart';
import '../../domain/entities/login_response.dart';
import '../mapper_errors/login_response_mapper_error.dart';

class LoginResponseMapper {
  static LoginResponse fromJson(Map<String, dynamic> json) {
    try {
      return LoginResponse(
        user: UserEntityMapper.fromJson(json),
      );
    } on DataSourceError {
      rethrow;
    } catch (e, s) {
      throw LoginResponseMapperError(
        errorMessage: 'Error: ${e.toString()}',
        stackTrace: s,
      );
    }
  }
}
