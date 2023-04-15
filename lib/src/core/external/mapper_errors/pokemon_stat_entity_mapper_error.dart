import '../../../shared/data/indexed_errors.dart';
import '../../../shared/errors/mapper_error.dart';

class PokemonStatEntityMapperError extends MapperError {
  PokemonStatEntityMapperError({
    required StackTrace stackTrace,
    required String errorMessage,
    bool? showInDebugTest,
  }) : super(
          errorCode: IndexedErrors.pokemonStatEntityMapperError,
          stackTrace: stackTrace,
          errorMessage: errorMessage,
          mapperName: 'PokemonStatsEntityMapperError',
          showInDebugTest: showInDebugTest ?? false,
        );
}
