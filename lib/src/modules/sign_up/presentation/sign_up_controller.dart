import 'package:mobx/mobx.dart';

import '../../../core/domain/entities/user_entity.dart';
import '../../../core/external/mappers/user_entity_mapper.dart';
import '../../../shared/contracts/i_error.dart';
import '../../../shared/object_values/export/object_values.dart';
import '../../../shared/utils/pokedex_state.dart';
import '../sign_up_module.dart';

part 'sign_up_controller.g.dart';

class SignUpController = _SignUpControllerBase with _$SignUpController;

abstract class _SignUpControllerBase with Store {
  final ISignUpUsecase signUpUsecase;

  _SignUpControllerBase(this.signUpUsecase);

  @observable
  PokedexState pokedexState = PokedexState.start;

  @observable
  User _user = UserEntityMapper.empty();
  @computed
  User get user => _user;

  @observable
  FullName _fullName = FullName('');
  @computed
  FullName get fullName => _fullName;
  @action
  void setFullName(String value) => _fullName = FullName(value);

  @observable
  Email _email = Email('');
  @computed
  Email get email => _email;
  @action
  void setEmail(String value) {
    _email = Email(value);
    setConfirmEmail(_confirmEmail.value);
  }

  @observable
  ConfirmEmail _confirmEmail = ConfirmEmail('', '');
  @computed
  ConfirmEmail get confirmEmail => _confirmEmail;
  @action
  void setConfirmEmail(String value) {
    _confirmEmail = ConfirmEmail(value, _email.value);
  }

  @observable
  Password _password = Password('');
  @computed
  Password get password => _password;
  @action
  void setPassword(String value) {
    _password = Password(value);
    setConfirmPassword(_confirmPassword.value);
  }

  @observable
  ConfirmPassword _confirmPassword = ConfirmPassword('', '');
  @computed
  ConfirmPassword get confirmPassword => _confirmPassword;
  @action
  void setConfirmPassword(String value) {
    _confirmPassword = ConfirmPassword(value, _password.value);
  }

  @action
  Future<void> doSignUp() async {
    pokedexState = PokedexState.loading;

    final params = SignUpParams(
      fullName: fullName,
      email: email,
      password: password,
    );

    final result = await signUpUsecase(params);

    result.fold(_doSignUpError, (r) async => await _doSignUpSuccess(r));
  }

  @action
  Future<void> _doSignUpSuccess(SignUpResponse response) async {
    _user = response.user;
    pokedexState = PokedexState.success;
  }

  @action
  Future<void> _doSignUpError(IError error) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    pokedexState = PokedexState.error;
    await Future.delayed(const Duration(milliseconds: 1000));
    pokedexState = PokedexState.start;
  }
}
