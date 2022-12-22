import '../../../../shared/data/indexed_errors.dart';
import '../../../../shared/errors/mapper_error.dart';

class ReadPokemonResponseMapperError extends MapperError {
  ReadPokemonResponseMapperError({
    required StackTrace stackTrace,
    required String errorMessage,
    bool? showInDebugTest,
  }) : super(
          errorCode: IndexedErrors.readPokemonResponseMapperError,
          stackTrace: stackTrace,
          errorMessage: errorMessage,
          mapperName: 'ReadPokemonResponseMapperError',
          showInDebugTest: showInDebugTest ?? false,
        );
}
