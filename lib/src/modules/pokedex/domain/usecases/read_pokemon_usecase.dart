import 'package:dartz/dartz.dart';

import '../../../../shared/contracts/i_error.dart';
import '../../../../shared/errors/domain_error.dart';
import '../entities/read_pokemon_response.dart';
import '../i_repositories/i_read_pokemon_repository.dart';
import '../params/read_pokemon_params.dart';

abstract class IReadPokemonUsecase {
  Future<Either<IError, ReadPokemonResponse>> call(ReadPokemonParams params);
}

class ReadPokemonUsecase implements IReadPokemonUsecase {
  final IReadPokemonRepository repository;

  ReadPokemonUsecase(this.repository);

  @override
  Future<Either<IError, ReadPokemonResponse>> call(
    ReadPokemonParams params,
  ) async {
    const showInDebugTest = false;

    if (!params.pokemonId.isValid) {
      return Left(DomainError(
        message: params.pokemonId.hasError()!,
        stackTrace: StackTrace.current,
        showInDebugTest: showInDebugTest,
      ));
    }

    final result = await repository(params);
    return result;
  }
}
