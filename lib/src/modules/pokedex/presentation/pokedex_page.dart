import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../core/domain/entities/user_entity.dart';
import '../../../shared/utils/pokedex_state.dart';
import '../../../shared/widgets/pokedex_dialog.dart';
import '../../login/presentation/login_page.dart';
import 'pokedex_controller.dart';
import 'pokedex_sides/left_side/left_side.dart';
import 'pokedex_sides/right_side/right_side.dart';

class PokedexPage extends StatefulWidget {
  static const routeName = '/pokedex';
  final User? user;

  const PokedexPage({super.key, this.user});

  @override
  _PokedexPageState createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  late PokedexController _controller;
  late PageController _pageController;

  late List<ReactionDisposer> _disposers;

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return PokedexDialog(
          message: 'Deseja Realmente sair?',
          positiveButton: 'Sim',
          onPositivePressed: () {
            _controller.onLogout();
          },
        );
      },
    );
  }

  @override
  void initState() {
    _controller = GetIt.I.get<PokedexController>();
    _pageController = PageController();

    _controller.initData(widget.user);

    _disposers = [
      reaction<PokedexState>((r) => _controller.logoutState, (state) {
        if (state == PokedexState.success) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            LoginPage.routeName,
            (route) => false,
          );
        }
      }),
      reaction<PokedexState>((r) => _controller.pokedexState, (state) async {
        if (state == PokedexState.success) {
          await Future.delayed(const Duration(milliseconds: 1500));
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      }),
    ];

    super.initState();
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _pageController.previousPage(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
        );
        return false;
      },
      child: Observer(builder: (_) {
        return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: PageView(
            controller: _pageController,
            physics: _controller.selectedPokemon == null
                ? const NeverScrollableScrollPhysics()
                : null,
            children: [
              LeftSide(
                state: _controller.pokedexState,
                pokemonList: _controller.pokemonList,
                selectedPokemon: _controller.selectedPokemon,
                readPokemon: (qrData) async {
                  return await _controller.doReadPokemon(context, qrData);
                },
                onSelectPokemon: (pokemon) {
                  _controller.onSelectPokemon(pokemon);
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn,
                  );
                },
                nextPokemon: (pokemon) => _controller.nextPokemon(),
                previousPokemon: (pokemon) => _controller.previousPokemon(),
                onLogout: () {
                  _showDialog();
                },
              ),
              RightPage(selectedPokemon: _controller.selectedPokemon),
            ],
          ),
        );
      }),
    );
  }
}
