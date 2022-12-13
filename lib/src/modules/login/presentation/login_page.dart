import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../shared/widgets/pokedex_header_footer_page.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController _controller;

  @override
  void initState() {
    _controller = GetIt.I.get<LoginController>();

    super.initState();
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
              ],
            ),
          ),
          footer: FloatingActionButton.extended(
            onPressed: () {
              _controller.doLogin();
            },
            label: const Text('Entrar'),
          ),
        ),
      ),
    );
  }
}
