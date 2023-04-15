import '../../../../core/external/mappers/user_entity_mapper.dart';
import '../../../../shared/errors/datasource_error.dart';
import '../../domain/entities/sign_up_response.dart';
import '../mapper_errors/sign_up_response_mapper_error.dart';

class SignUpResponseMapper {
  static SignUpResponse fromJson(Map<String, dynamic> json) {
    try {
      return SignUpResponse(
        user: UserEntityMapper.fromJson(json),
      );
    } on DataSourceError {
      rethrow;
    } catch (e, s) {
      throw SignUpResponseMapperError(
        errorMessage: 'Error: ${e.toString()}',
        stackTrace: s,
      );
    }
  }
}
