import '../contracts/export/contracts.dart';
import '../data/pokedex_texts.dart';
import '../validators/object_values_validators/confirm_email_validator.dart';

class ConfirmEmail extends IObjectValue {
  final String confirmValue;

  ConfirmEmail(String value, this.confirmValue) : super(value);

  @override
  String get errorMessage => PokedexTexts.wrongConfirmEmail;

  @override
  IValidator get validator => ConfirmEmailValidator();

  @override
  bool get isValid =>
      (validator as ConfirmEmailValidator).validate(value, confirmValue);
}
