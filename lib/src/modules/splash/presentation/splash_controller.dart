import 'package:mobx/mobx.dart';

import '../../../shared/storage/export/storage.dart';
import '../../../shared/utils/pokedex_state.dart';
import '../../pages.dart';

part 'splash_controller.g.dart';

class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  final ICustomAppStorage _storage;

  _SplashControllerBase(this._storage);

  @observable
  PokedexState _pokedexState = PokedexState.start;
  @computed
  PokedexState get pokedexState => _pokedexState;

  @action
  Future<String> splashValidation() async {
    final userIsLogged = await _userIsLogged();
    return userIsLogged ? PokedexPage.routeName : LoginPage.routeName;
  }

  @action
  Future<bool> _userIsLogged() async {
    _pokedexState = PokedexState.loading;
    final userData = await _storage.getAllKeys();
    return userData.containsKey('token') && userData.containsKey('eventCode');
  }
}
