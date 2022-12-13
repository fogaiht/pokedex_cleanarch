import '../../../shared/data/indexed_errors.dart';
import '../../../shared/errors/mapper_error.dart';

class PokemonEntityMapperError extends MapperError {
  PokemonEntityMapperError({
    required StackTrace stackTrace,
    required String errorMessage,
    bool? showInDebugTest,
  }) : super(
          errorCode: IndexedErrors.pokemonEntityMapperError,
          stackTrace: stackTrace,
          errorMessage: errorMessage,
          mapperName: 'PokemonEntityMapperError',
          showInDebugTest: showInDebugTest ?? false,
        );
}
