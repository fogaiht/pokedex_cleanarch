import '../contracts/export/contracts.dart';
import '../data/pokedex_texts.dart';
import '../validators/object_values_validators/confirm_password_validator.dart';

class ConfirmPassword extends IObjectValue {
  final String confirmValue;

  ConfirmPassword(String value, this.confirmValue) : super(value);

  @override
  String get errorMessage => PokedexTexts.wrongConfirmPassword;

  @override
  IValidator get validator => ConfirmPasswordValidator();
  @override
  @override
  bool get isValid => (validator as ConfirmPasswordValidator).validate(
        value,
        confirmValue,
      );
}
