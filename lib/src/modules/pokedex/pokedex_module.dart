import 'package:get_it/get_it.dart';

import 'domain/i_repositories/i_read_pokemon_repository.dart';
import 'domain/usecases/read_pokemon_usecase.dart';
import 'external/datasources/read_pokemon_datasource.dart';
import 'infra/i_datasources/i_read_pokemon_datasource.dart';
import 'infra/repositories/read_pokemon_repository.dart';
import 'presentation/pokedex_controller.dart';

export 'domain/entities/read_pokemon_response.dart';
export 'domain/i_repositories/i_read_pokemon_repository.dart';
export 'domain/params/read_pokemon_params.dart';
export 'domain/usecases/read_pokemon_usecase.dart';
export 'external/datasources/read_pokemon_datasource.dart';
export 'external/mapper_errors/read_pokemon_response_mapper_error.dart';
export 'external/mappers/read_pokemon_response_mapper.dart';
export 'infra/i_datasources/i_read_pokemon_datasource.dart';
export 'infra/repositories/read_pokemon_repository.dart';

class PokedexModule {
  PokedexModule._();

  static void initInjections() {
    final getIt = GetIt.instance;

    getIt.registerLazySingleton<IReadPokemonDatasource>(
      () => ReadPokemonDatasource(getIt()),
    );
    getIt.registerLazySingleton<IReadPokemonRepository>(
      () => ReadPokemonRepository(getIt()),
    );
    getIt.registerLazySingleton<IReadPokemonUsecase>(
      () => ReadPokemonUsecase(getIt()),
    );

    getIt.registerFactory<PokedexController>(() => PokedexController());
  }
}
