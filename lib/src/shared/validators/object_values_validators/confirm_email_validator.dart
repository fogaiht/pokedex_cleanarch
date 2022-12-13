import '../export/validators.dart';

class ConfirmEmailValidator extends EmailValidator {
  @override
  bool call(String value) => validator(value);

  bool validate(String value, String confirmValue) =>
      _confirmEmailValidation(value, confirmValue);

  bool _confirmEmailValidation(String value, String confirmValue) =>
      call(value) && call(confirmValue) && value == confirmValue;
}
