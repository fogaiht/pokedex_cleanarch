import '../primitive_validators/num_validator.dart';

class IdValidator extends NumValidator {
  @override
  bool call(num value) => _idValidation(value);

  bool _idValidation(num value) => validator(value);
}
