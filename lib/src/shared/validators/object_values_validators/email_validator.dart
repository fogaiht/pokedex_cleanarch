import '../primitive_validators/string_validator.dart';

class EmailValidator extends StringValidator {
  final _regExp =
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  bool call(value) => _emailValidation(value);

  bool _emailValidation(String value) =>
      validator(value) && RegExp(_regExp).hasMatch(value);
}
