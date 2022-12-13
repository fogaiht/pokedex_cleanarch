import '../contracts/export/contracts.dart';
import '../data/pokedex_texts.dart';
import '../validators/export/validators.dart';

class PokemonId extends IObjectValue {
  PokemonId(String value) : super(value);

  @override
  IValidator get validator => IdValidator();

  @override
  String get errorMessage => PokedexTexts.wrongPokemonId;

  @override
  bool get isValid => validator(int.tryParse(value) ?? -1);
}
