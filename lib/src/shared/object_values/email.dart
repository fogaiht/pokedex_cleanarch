import '../contracts/export/contracts.dart';
import '../data/pokedex_texts.dart';
import '../validators/object_values_validators/email_validator.dart';

class Email extends IObjectValue {
  Email(String value) : super(value);

  @override
  IValidator get validator => EmailValidator();

  @override
  String get errorMessage => PokedexTexts.wrongEmail;
}
