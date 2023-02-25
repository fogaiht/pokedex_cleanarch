import 'package:mobx/mobx.dart';

import '../../../core/domain/entities/user_entity.dart';
import '../../../core/external/mappers/user_entity_mapper.dart';
import '../../../shared/storage/export/storage.dart';
import '../../../shared/utils/pokedex_state.dart';
import '../../pages.dart';

part 'splash_controller.g.dart';

class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  final ICustomAppStorage _storage;

  _SplashControllerBase(this._storage);
  @observable
  User? _user;
  @computed
  User? get user => _user;

  @observable
  bool userIsLogged = false;

  @action
  Future<String> splashValidation() async {
    await _userIsLogged();
    return userIsLogged ? PokedexPage.routeName : LoginPage.routeName;
  }

  @action
  Future<void> _userIsLogged() async {
    final userData = await _storage.readKey('user');

    if (userData.toString().isNotEmpty) {
      _user = UserEntityMapper.fromJson(userData);
      userIsLogged = true;
    }
  }
}
