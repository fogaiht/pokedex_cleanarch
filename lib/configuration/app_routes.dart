import 'package:flutter/material.dart';

import '/src/modules/pages.dart';

class AppRoutes {
  static List<String> get getRoutes => privateRoutes.keys.toList();

  static Map<String, WidgetBuilder> privateRoutes = {
    SplashPage.routeName: (_) => const SplashPage(),
    LoginPage.routeName: (_) => const LoginPage(),
    HomePage.routeName: (_) => const HomePage(),
  };
}
