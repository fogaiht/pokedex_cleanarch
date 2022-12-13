import 'package:get_it/get_it.dart';

import '../src/modules/login/login_module.dart';
import '../src/modules/splash/splash_module.dart';
import '../src/services/pokedex_services.dart';
import '../src/shared/storage/export/storage.dart';

class AppInjections {
  AppInjections._();

  static void init() {
    final getIt = GetIt.instance;

    ///*-----------------Services-------------------*\\\
    getIt.registerSingleton<ICustomAppStorage>(
      SecureAppStorage(),
    );
    getIt.registerSingleton<IHttpService>(
      HttpService(
        ApiConstants.baseUrl,
        additionalInterceptorsList: [],
      ),
    );

    ///*-----------------InitInjections-------------------*\\\
    LoginModule.initInjections();
    SplashModuleInjections.init();
  }
}
