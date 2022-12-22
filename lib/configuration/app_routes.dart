import 'package:flutter/material.dart';

import '/src/modules/pages.dart';
import '../src/core/domain/entities/user_entity.dart';

class AppRoutes {
  static List<String> get getRoutes => privateRoutes.keys.toList();

  static Map<String, WidgetBuilder> privateRoutes = {
    SplashPage.routeName: (_) => const SplashPage(),
    LoginPage.routeName: (_) => const LoginPage(),
    PokedexPage.routeName: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return PokedexPage(pokeNumber: 1, user: args['user'] as User);
    },
  };
}
