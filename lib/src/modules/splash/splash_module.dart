import 'package:get_it/get_it.dart';

import 'presentation/splash_controller.dart';

class SplashModuleInjections {
  SplashModuleInjections._();

  static void init() {
    final getIt = GetIt.instance;

    ///*-------------Controllers-------------*\\\
    getIt.registerFactory<SplashController>(
      () => SplashController(getIt()),
    );
  }
}
