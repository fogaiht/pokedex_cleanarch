import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/utils/pokedex_state.dart';
import '../../../shared/widgets/pokedex_header_footer_page.dart';
import '../../../shared/widgets/pokedex_spin_ring.dart';
import '../../pokedex/presentation/pokedex_page.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController _controller;
  late ReactionDisposer _disposer;

  @override
  void initState() {
    _controller = GetIt.I.get<LoginController>();

    _disposer =
        reaction<PokedexState>((r) => _controller.pokedexState, (state) {
      if (state == PokedexState.success) {
        Navigator.of(context).pushReplacementNamed(
          PokedexPage.routeName,
          arguments: {'user': _controller.user},
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PokedexHeaderFooterPage(
          body: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(),
                TextFormField(),
                Observer(builder: (_) {
                  return _controller.pokedexState == PokedexState.loading
                      ? const PokedexSpinRing()
                      : const SizedBox();
                })
              ],
            ),
          ),
          footer: FloatingActionButton.extended(
            onPressed: () async {
              await _controller.doLogin();
            },
            label: const Text('Entrar'),
          ),
        ),
      ),
    );
  }
}
