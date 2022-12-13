import '../contracts/export/contracts.dart';
import '../data/pokedex_texts.dart';
import '../validators/object_values_validators/fullname_validator.dart';

class FullName extends IObjectValue {
  FullName(String value) : super(value);

  @override
  IValidator get validator => FullNameValidator();

  @override
  String get errorMessage => PokedexTexts.wrongFullName;

  String get firstName => value.split(' ').first;
}
