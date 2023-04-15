import '../contracts/export/contracts.dart';
import '../data/pokedex_texts.dart';
import '../validators/object_values_validators/password_validator.dart';

class Password extends IObjectValue {
  Password(String value) : super(value);

  @override
  String get errorMessage => PokedexTexts.wrongPassword;

  @override
  IValidator get validator => PasswordValidator();
}
