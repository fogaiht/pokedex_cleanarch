import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_cleanarch/src/modules/login/login_module.dart';
import 'package:pokedex_cleanarch/src/shared/errors/domain_error.dart';
import 'package:pokedex_cleanarch/src/shared/object_values/export/object_values.dart';

class LoginRepositoryMock extends Mock implements ILoginRepository {}

class LoginParamsFake extends Fake implements LoginParams {}

class LoginResponseMock extends Mock implements LoginResponse {}

void main() {
  late LoginUsecase usecase;
  late ILoginRepository repository;
  late LoginParams params;
  late LoginResponse response;

  setUpAll(() {
    registerFallbackValue(LoginParamsFake());

    repository = LoginRepositoryMock();
    usecase = LoginUsecase(repository);
    params = LoginParams(
      password: Password('password'),
      email: Email('notifi@cationo.ken'),
    );
    response = LoginResponseMock();
  });

  group('LoginUsecase ->', () {
    test('Return an instance of LoginResponse', () async {
      when(() => repository(any())).thenAnswer((_) async => Right(response));

      final result = await usecase(params);

      expect(result, isA<Right>());
      expect(result.fold(id, id), isA<LoginResponse>());
    });

    test('Return an instance of DomainError - Wrong email', () async {
      params = LoginParams(
        password: Password('password'),
        email: Email('notifi@21o.'),
      );
      final result = await usecase(params);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<DomainError>());
    });
    test('Return an instance of DomainError - Wrong password', () async {
      params = LoginParams(
        password: Password('pass'),
        email: Email('notifi@cationTo.ken'),
      );
      final result = await usecase(params);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<DomainError>());
    });
  });
}
