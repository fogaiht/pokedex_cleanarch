import 'package:dartz/dartz.dart';

import '../../../../shared/contracts/i_error.dart';
import '../entities/read_pokemon_response.dart';
import '../params/read_pokemon_params.dart';

abstract class IReadPokemonRepository {
  Future<Either<IError, ReadPokemonResponse>> call(ReadPokemonParams params);
}
