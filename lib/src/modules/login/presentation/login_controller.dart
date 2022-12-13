import 'package:mobx/mobx.dart';

import '../../../shared/contracts/i_error.dart';
import '../../../shared/object_values/export/object_values.dart';
import '../domain/entities/login_response.dart';
import '../domain/params/login_params.dart';
import '../domain/usecases/login_usecase.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final ILoginUsecase loginUsecase;

  _LoginControllerBase(this.loginUsecase);

  Future<void> doLogin() async {
    const email = 'teste@teste.com';
    const password = '123456';

    final params = LoginParams(
      email: Email(email),
      password: Password(password),
    );

    final result = await loginUsecase(params);

    result.fold(_doLoginError, _doLoginSuccess);
  }

  void _doLoginSuccess(LoginResponse response) {
    print(response.user.name);
  }

  void _doLoginError(IError error) {
    print(error.message);
  }
}
