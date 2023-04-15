import 'package:get_it/get_it.dart';

import 'domain/i_repositories/i_sign_up_repository.dart';
import 'domain/usecases/sign_up_usecase.dart';
import 'external/datasources/sign_up_datasource.dart';
import 'infra/i_datasources/i_sign_up_datasource.dart';
import 'infra/repositories/sign_up_repository.dart';
import 'presentation/sign_up_controller.dart';

export 'domain/entities/sign_up_response.dart';
export 'domain/i_repositories/i_sign_up_repository.dart';
export 'domain/params/sign_up_params.dart';
export 'domain/usecases/sign_up_usecase.dart';
export 'external/datasources/sign_up_datasource.dart';
export 'external/mapper_errors/sign_up_response_mapper_error.dart';
export 'external/mappers/sign_up_response_mapper.dart';
export 'infra/i_datasources/i_sign_up_datasource.dart';
export 'infra/repositories/sign_up_repository.dart';

class SignUpModule {
  SignUpModule._();

  static void initInjections() {
    final getIt = GetIt.instance;

    getIt.registerLazySingleton<ISignUpDatasource>(
      () => SignUpDatasource(getIt()),
    );
    getIt.registerLazySingleton<ISignUpRepository>(
      () => SignUpRepository(getIt()),
    );
    getIt.registerLazySingleton<ISignUpUsecase>(
      () => SignUpUsecase(getIt()),
    );

    getIt.registerFactory<SignUpController>(() => SignUpController(getIt()));
  }
}
