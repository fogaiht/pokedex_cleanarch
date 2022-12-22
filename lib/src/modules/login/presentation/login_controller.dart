import 'package:mobx/mobx.dart';

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

  @action
  Future<void> doLogin() async {
    pokedexState = PokedexState.loading;
    const email = 'teste@teste.com';
    const password = '123456';

    final params = LoginParams(
      email: Email(email),
      password: Password(password),
    );

    final result = await loginUsecase(params);

    result.fold(_doLoginError, _doLoginSuccess);
  }

  @action
  void _doLoginSuccess(LoginResponse response) {
    pokedexState = PokedexState.success;
    _user = response.user;
    print(response.user.name);
  }

  @action
  void _doLoginError(IError error) {
    pokedexState = PokedexState.error;
    print(error.message);
  }
}
