import '../primitive_validators/string_validator.dart';

class ConfirmPasswordValidator extends StringValidator {
  @override
  bool call(String value) => validator(value);

  bool validate(String value, String confirmValue) =>
      _confirmPasswordValidation(value, confirmValue);

  bool _confirmPasswordValidation(String value, String confirmValue) =>
      call(value) && call(confirmValue) && value == confirmValue;
}
