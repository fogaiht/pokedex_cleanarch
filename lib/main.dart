import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'configuration/app_injections.dart';
import 'configuration/app_routes.dart';
import 'src/modules/pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppInjections.init();

  await precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoderOutsideViewBoxBuilder,
      'images/captured_pokeball.svg',
    ),
    null,
  );
  await precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoderOutsideViewBoxBuilder,
      'images/openned_pokeball.svg',
    ),
    null,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'CleanArch Pokedex',
      routes: AppRoutes.privateRoutes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}
