import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_cleanarch/src/modules/login/login_module.dart';
import 'package:pokedex_cleanarch/src/shared/errors/datasource_error.dart';
import 'package:pokedex_cleanarch/src/shared/object_values/export/object_values.dart';

class LoginDatasourceMock extends Mock implements ILoginDatasource {}

class LoginParamsFake extends Fake implements LoginParams {}

class LoginResponseMock extends Mock implements LoginResponse {}

void main() {
  late LoginRepository repository;
  late ILoginDatasource datasource;
  late LoginParams params;
  late LoginResponse response;

  setUpAll(() {
    datasource = LoginDatasourceMock();
    repository = LoginRepository(datasource);
    params = LoginParams(
      password: Password('password'),
      email: Email('notifi@cationo.ken'),
    );
    response = LoginResponseMock();
    registerFallbackValue(LoginParamsFake());
  });

  group('LoginRepository ->', () {
    test('Return an instance of LoginResponse', () async {
      when(() => datasource(any())).thenAnswer((_) async => response);

      final result = await repository(params);
      expect(result, isA<Right>());
      expect(result.fold(id, id), isA<LoginResponse>());
      verify(() => datasource(any())).called(1);
    });
    test('Return an error of DataSourceError', () async {
      when(() => datasource(any())).thenThrow(DataSourceError(
        message: 'Error',
        stackTrace: StackTrace.current,
      ));

      final result = await repository(params);
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<DataSourceError>());
      verify(() => datasource(any())).called(1);
    });
    test('Return an instance of DataSourceError when Exception', () async {
      when(() => datasource(any())).thenThrow(Exception('DataSourceError'));

      final result = await repository(params);
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<DataSourceError>());
      verify(() => datasource(any())).called(1);
    });
  });
}
