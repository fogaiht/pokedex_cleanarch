import '../../../shared/data/indexed_errors.dart';
import '../../../shared/errors/mapper_error.dart';

class PokemonTypeEntityMapperError extends MapperError {
  PokemonTypeEntityMapperError({
    required StackTrace stackTrace,
    required String errorMessage,
    bool? showInDebugTest,
  }) : super(
          errorCode: IndexedErrors.pokemonTypeEntityMapperError,
          stackTrace: stackTrace,
          errorMessage: errorMessage,
          mapperName: 'PokemonTypeEntityMapperError',
          showInDebugTest: showInDebugTest ?? false,
        );
}
