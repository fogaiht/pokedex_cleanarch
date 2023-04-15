import '../data/pokedex_texts.dart';
import 'i_validator.dart';

abstract class IObjectValue {
  final String value;
  IObjectValue(this.value);

  bool get isValid => validator(value);
  IValidator get validator;
  String get errorMessage;

  String? hasError() => !isValid
      ? value.isEmpty
          ? PokedexTexts.requiredField
          : errorMessage
      : null;
}
