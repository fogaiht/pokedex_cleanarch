import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../core/domain/entities/pokemon_entity.dart';
import '../../shared/shared_files.dart';
import '../../shared/utils/pokedex_state.dart';
import 'presentation/reader_page.dart';

export 'presentation/reader_controller.dart';

class PokedexReader {
  static void toRead(
    BuildContext context, {
    required Future<Either<IError, Pokemon>> Function(String) onRead,
    required PokedexState pokedexState,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
        pageBuilder: (context, anim1, anim2) => ReaderPage(
          onRead: onRead,
          pokedexState: pokedexState,
        ),
      ),
    );
  }
}
