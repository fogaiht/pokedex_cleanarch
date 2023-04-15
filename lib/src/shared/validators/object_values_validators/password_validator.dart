import '../primitive_validators/string_validator.dart';

class PasswordValidator extends StringValidator {
  @override
  bool call(String value) => _passwordValidation(value);

  bool _passwordValidation(String value) =>
      validator(value) && value.length >= 6;
}
