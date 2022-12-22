import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../core/domain/entities/user_entity.dart';
import 'pokedex_controller.dart';
import 'pokedex_sides/left_side/left_side.dart';
import 'pokedex_sides/right_side/right_side.dart';

class PokedexPage extends StatefulWidget {
  static const routeName = '/pokedex';
  final int pokeNumber;
  final User user;

  const PokedexPage({
    Key? key,
    required this.pokeNumber,
    required this.user,
  }) : super(key: key);

  @override
  _PokedexPageState createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  late PokedexController _controller;
  late PageController _pageController;

  @override
  void initState() {
    _controller = GetIt.I.get<PokedexController>();
    _pageController = PageController();

    _controller.initData(widget.user);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return PageView(
        controller: _pageController,
        physics: _controller.selectedPokemon == null
            ? const NeverScrollableScrollPhysics()
            : null,
        children: [
          LeftSide(
            pokemonList: _controller.pokemonList,
            selectedPokemon: _controller.selectedPokemon,
            onSelectPokemon: (pokemon) {
              _controller.onSelectPokemon(pokemon);
              _pageController.nextPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeIn,
              );
            },
            nextPokemon: (pokemon) => _controller.nextPokemon(),
            previousPokemon: (pokemon) => _controller.previousPokemon(),
          ),
          RightPage(selectedPokemon: _controller.selectedPokemon),
        ],
      );
    });
  }
}
