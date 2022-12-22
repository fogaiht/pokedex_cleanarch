import 'package:get_it/get_it.dart';

import 'presentation/pokedex_controller.dart';

class PokedexModule {
  PokedexModule._();

  static void initInjections() {
    final getIt = GetIt.instance;

    // getIt.registerLazySingleton<ILoginDatasource>(
    //   () => LoginDatasource(getIt()),
    // );
    // getIt.registerLazySingleton<ILoginRepository>(
    //   () => LoginRepository(getIt()),
    // );
    // getIt.registerLazySingleton<ILoginUsecase>(
    //   () => LoginUsecase(getIt()),
    // );

    getIt.registerFactory<PokedexController>(() => PokedexController());
  }
}
