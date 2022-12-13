import '../primitive_validators/string_validator.dart';

class FullNameValidator extends StringValidator {
  final regExp =
      r"^([ a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð'])+$";
  @override
  bool call(String value) => _fullNameValidation(value);

  bool _fullNameValidation(String value) =>
      validator(value) &&
      value.trim().split(' ').length >= 2 &&
      RegExp(regExp).hasMatch(value);
}
