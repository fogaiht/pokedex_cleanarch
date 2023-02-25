import 'package:get_it/get_it.dart';

import 'domain/i_repositories/i_login_repository.dart';
import 'domain/usecases/login_usecase.dart';
import 'external/datasources/login_datasource.dart';
import 'infra/i_datasources/i_login_datasource.dart';
import 'infra/repositories/login_repository.dart';
import 'presentation/login_controller.dart';

export 'domain/entities/login_response.dart';
export 'domain/i_repositories/i_login_repository.dart';
export 'domain/params/login_params.dart';
export 'domain/usecases/login_usecase.dart';
export 'external/datasources/login_datasource.dart';
export 'external/mapper_errors/login_response_mapper_error.dart';
export 'external/mappers/login_response_mapper.dart';
export 'infra/i_datasources/i_login_datasource.dart';
export 'infra/repositories/login_repository.dart';

class LoginModule {
  LoginModule._();

  static void initInjections() {
    final getIt = GetIt.instance;

    getIt.registerLazySingleton<ILoginDatasource>(
      () => LoginDatasource(getIt()),
    );
    getIt.registerLazySingleton<ILoginRepository>(
      () => LoginRepository(getIt()),
    );
    getIt.registerLazySingleton<ILoginUsecase>(
      () => LoginUsecase(getIt()),
    );

    getIt.registerFactory<LoginController>(
      () => LoginController(getIt(), getIt()),
    );
  }
}
