import 'package:mobx/mobx.dart';

import '../../../core/domain/entities/pokemon_entity.dart';
import '../../../core/domain/entities/user_entity.dart';
import '../../../core/external/mappers/user_entity_mapper.dart';
import '../../../shared/contracts/i_error.dart';
import '../../../shared/object_values/export/object_values.dart';
import '../../../shared/utils/pokedex_state.dart';
import '../domain/entities/login_response.dart';
import '../domain/params/login_params.dart';
import '../domain/usecases/login_usecase.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final ILoginUsecase loginUsecase;

  _LoginControllerBase(this.loginUsecase);

  @observable
  PokedexState pokedexState = PokedexState.start;

  @observable
  User _user = UserEntityMapper.empty();

  @computed
  User get user => _user;

  @observable
  Email _email = Email('');
  @computed
  Email get email => _email;
  @action
  void setEmail(String value) => _email = Email(value);

  @observable
  Password _password = Password('');
  @computed
  Password get password => _password;
  @action
  void setPassword(String value) => _password = Password(value);

  @observable
  bool _rememberMe = true;
  @computed
  bool get rememberMe => _rememberMe;
  @action
  void saveLoginParams(bool? value) => _rememberMe = value == true;

  @action
  Future<void> doLogin() async {
    pokedexState = PokedexState.loading;

    // final constParams = LoginParams(
    //   email: Email('teste@teste.com'),
    //   password: Password('123456'),
    // );

    final params = LoginParams(email: email, password: password);

    final result = await loginUsecase(params);

    result.fold(_doLoginError, (r) async => await _doLoginSuccess(r));
  }

  @observable
  List<Pokemon> pokemonList = <Pokemon>[];

  @action
  Future<void> _doLoginSuccess(LoginResponse response) async {
    _user = response.user;
    pokemonList = _user.pokemonList.asObservable();
    pokedexState = PokedexState.success;
  }

  @action
  Future<void> _doLoginError(IError error) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    pokedexState = PokedexState.error;
    await Future.delayed(const Duration(milliseconds: 1000));
    pokedexState = PokedexState.start;
  }

  @action
  Future<void> toggleState() async {
    pokedexState = PokedexState.loading;
    await Future.delayed(const Duration(milliseconds: 1500));
    pokedexState = PokedexState.success;
    await Future.delayed(const Duration(milliseconds: 1500));
    pokedexState = PokedexState.start;
    await Future.delayed(const Duration(milliseconds: 1500));
    pokedexState = PokedexState.loading;
    await Future.delayed(const Duration(milliseconds: 1500));
    pokedexState = PokedexState.error;
    await Future.delayed(const Duration(milliseconds: 1500));
    pokedexState = PokedexState.start;
  }
}
