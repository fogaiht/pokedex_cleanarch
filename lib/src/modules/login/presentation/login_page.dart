import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../core/domain/entities/pokemon_entity.dart';
import '../../../shared/shared_files.dart';
import '../../../shared/utils/pokedex_state.dart';
import '../../../shared/widgets/pokedex_button.dart';
import '../../../shared/widgets/pokedex_form_field.dart';
import '../../../shared/widgets/pokedex_text.dart';
import '../../pages.dart';
import 'components/login_form_card.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late GlobalKey<FormState> _formKey;

  late LoginController _controller;
  late List<ReactionDisposer> _disposers;

  late FocusNode _emailFocusNode, _passwordFocusNode;
  late TextEditingController _emailTextController, _passwordTextController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _controller = GetIt.I.get<LoginController>();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();

    _disposers = [
      reaction<List<Pokemon>>((r) => _controller.pokemonList,
          (pokemonList) async {
        if (pokemonList.isNotEmpty) {
          for (var pokemon in pokemonList) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await precacheImage(
                Image.network(pokemon.spriteUrl).image,
                context,
              );
            });
          }
        }
      }),
      reaction<PokedexState>((r) => _controller.pokedexState, (state) {
        if (state == PokedexState.success) {
          Navigator.of(context).pushReplacementNamed(
            PokedexPage.routeName,
            arguments: {'user': _controller.user},
          );
        }
      }),
    ];

    super.initState();
  }

  @override
  void dispose() {
    for (var dispose in _disposers) {
      dispose();
    }

    _emailTextController.dispose();
    _passwordTextController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size1 = context.constSize1;
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(size1 * 8.0),
          child: PokedexHeaderFooterPage(
            hasHeaderSpacer: true,
            centralizeBody: true,
            header: PokedexText(label: 'Pokédex', fontSize: size1 * 120),
            body: Column(
              children: [
                LoginFormCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Observer(builder: (_) {
                          return PokedexFormField(
                            isEmailField: true,
                            focusNode: _emailFocusNode,
                            controller: _emailTextController,
                            onChanged: _controller.setEmail,
                            validator: _controller.email.hasError,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'Email',
                            onFieldSubmitted: (_) {
                              _passwordFocusNode.requestFocus();
                            },
                          );
                        }),
                        SizedBox(height: size1 * 20),
                        Observer(builder: (_) {
                          return PokedexFormField(
                            isPasswordField: true,
                            focusNode: _passwordFocusNode,
                            controller: _passwordTextController,
                            onChanged: _controller.setPassword,
                            validator: _controller.password.hasError,
                            hintText: 'Senha',
                            onFieldSubmitted: (_) async {
                              await _doLogin(context);
                            },
                          );
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Observer(builder: (_) {
                                  return Checkbox(
                                    value: _controller.rememberMe,
                                    onChanged: _controller.saveLoginParams,
                                  );
                                }),
                                Text(
                                  'Lembrar-me',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .merge(
                                        TextStyle(fontSize: size1 * 18),
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: context.width * .15,
                              child: Image.asset('images/fogaiht_dev.png'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size1 * 16),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signUp');
                  },
                  child: PokedexText(
                    label: 'Cadastre-se',
                    fontSize: size1 * 40,
                    shadowOffset: const Offset(5.0, 5.0),
                  ),
                ),
              ],
            ),
            footer: Observer(builder: (_) {
              return PokedexButton(
                state: _controller.pokedexState,
                label: 'Entrar',
                onTap: () async {
                  await _doLogin(context);
                },
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> _doLogin(BuildContext context) async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      await _controller.doLogin();
    }
  }
}
