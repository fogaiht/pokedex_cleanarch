import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_cleanarch/src/modules/sign_up/sign_up_module.dart';
import 'package:pokedex_cleanarch/src/shared/errors/domain_error.dart';
import 'package:pokedex_cleanarch/src/shared/object_values/export/object_values.dart';

class SignUpRepositoryMock extends Mock implements ISignUpRepository {}

class SignUpParamsFake extends Fake implements SignUpParams {}

class SignUpResponseMock extends Mock implements SignUpResponse {}

void main() {
  late SignUpUsecase usecase;
  late ISignUpRepository repository;
  late SignUpParams params;
  late SignUpResponse response;

  setUpAll(() {
    registerFallbackValue(SignUpParamsFake());

    repository = SignUpRepositoryMock();
    usecase = SignUpUsecase(repository);
    params = SignUpParams(
      fullName: FullName('Full Name'),
      password: Password('password'),
      email: Email('notifi@cationo.ken'),
    );
    response = SignUpResponseMock();
  });

  group('SignUpUsecase ->', () {
    test('Return an instance of SignUpResponse', () async {
      when(() => repository(any())).thenAnswer((_) async => Right(response));

      final result = await usecase(params);

      expect(result, isA<Right>());
      expect(result.fold(id, id), isA<SignUpResponse>());
    });

    test('Return an instance of DomainError - Wrong email', () async {
      params = SignUpParams(
        fullName: FullName('Full Name'),
        password: Password('password'),
        email: Email('notifi@21o.'),
      );
      final result = await usecase(params);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<DomainError>());
    });
    test('Return an instance of DomainError - Wrong password', () async {
      params = SignUpParams(
        fullName: FullName('Full Name'),
        password: Password('pass'),
        email: Email('notifi@cationTo.ken'),
      );
      final result = await usecase(params);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<DomainError>());
    });
    test('Return an instance of DomainError - Wrong fullName', () async {
      params = SignUpParams(
        fullName: FullName('FullName'),
        password: Password('pass'),
        email: Email('notifi@cationTo.ken'),
      );
      final result = await usecase(params);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<DomainError>());
    });
  });
}
