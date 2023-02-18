import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/shared_files.dart';
import '../../../shared/utils/pokedex_state.dart';
import '../../../shared/widgets/pokedex_button.dart';
import '../../../shared/widgets/pokedex_form_field.dart';
import '../../../shared/widgets/pokedex_text.dart';
import '../../pokedex/presentation/pokedex_page.dart';
import 'sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/signUp';

  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  late SignUpController _controller;
  late List<ReactionDisposer> _disposers;

  late FocusNode _nameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _confirmEmailFocusNode,
      _confirmPasswordFocusNode;

  late TextEditingController _nameTextController,
      _emailTextController,
      _passwordTextController,
      _confirmEmailTextController,
      _confirmPasswordTextController;

  @override
  void initState() {
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmEmailFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();

    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmEmailTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();

    _controller = GetIt.I.get<SignUpController>();

    _disposers = [
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

    _nameFocusNode.dispose();
    _emailFocusNode.dispose;
    _passwordFocusNode.dispose;
    _confirmEmailFocusNode.dispose;
    _confirmPasswordFocusNode.dispose;

    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmEmailTextController.dispose();
    _confirmPasswordTextController.dispose();

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
            header: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: size1 * 40,
                      color: ThemeColors.white,
                    ),
                  ),
                ),
                PokedexText(label: 'Cadastro', fontSize: size1 * 90),
              ],
            ),
            body: Container(
              decoration: const BoxDecoration(color: Colors.white),
              padding: EdgeInsets.symmetric(
                horizontal: size1 * 30,
                vertical: size1 * 30,
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Observer(builder: (_) {
                        return PokedexFormField(
                          focusNode: _nameFocusNode,
                          controller: _nameTextController,
                          onChanged: _controller.setFullName,
                          validator: _controller.fullName.hasError,
                          textInputAction: TextInputAction.next,
                          hintText: 'Nome',
                          onFieldSubmitted: (_) {
                            _emailFocusNode.requestFocus();
                          },
                        );
                      }),
                      SizedBox(height: size1 * 20),
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
                            _confirmEmailFocusNode.requestFocus();
                          },
                        );
                      }),
                      SizedBox(height: size1 * 20),
                      Observer(builder: (_) {
                        return PokedexFormField(
                          isEmailField: true,
                          focusNode: _confirmEmailFocusNode,
                          controller: _confirmEmailTextController,
                          onChanged: _controller.setConfirmEmail,
                          validator: _controller.confirmEmail.hasError,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Confirmar Email',
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
                          onFieldSubmitted: (_) {
                            _confirmPasswordFocusNode.requestFocus();
                          },
                        );
                      }),
                      SizedBox(height: size1 * 20),
                      Observer(builder: (_) {
                        return PokedexFormField(
                          isPasswordField: true,
                          focusNode: _confirmPasswordFocusNode,
                          controller: _confirmPasswordTextController,
                          onChanged: _controller.setConfirmPassword,
                          validator: _controller.confirmPassword.hasError,
                          hintText: 'Confirmar Senha',
                          onFieldSubmitted: (_) async {
                            await _doSignUp(context);
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            footer: Observer(builder: (_) {
              return PokedexButton(
                state: _controller.pokedexState,
                label: 'Cadastrar',
                onTap: () async {
                  await _doSignUp(context);
                },
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> _doSignUp(BuildContext context) async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      await _controller.doSignUp();
    }
  }
}
